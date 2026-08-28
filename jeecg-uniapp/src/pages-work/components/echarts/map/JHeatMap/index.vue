<template>
  <view class="content">
    <statusTip v-if="pageTips.show" :status="pageTips.status"></statusTip>
    <!-- #ifdef APP-PLUS || H5 -->
<!--    <EchartsMap-->
<!--      v-else-->
<!--      v-model:option="option"-->
<!--      v-model:map="mapObject"-->
<!--      v-model:echartId="echartId"-->
<!--    />-->
    <!-- #endif -->
    <!-- #ifdef APP-PLUS || H5 || MP-WEIXIN -->
    <echartsUniapp v-else :option="option" :mapName="mapName" :mapData="mapDataJson"></echartsUniapp>
    <!-- #endif -->
  </view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { echartProps } from '@/pages-work/components/echarts/props'
import EchartsMap from '../index.vue'
import echartsUniapp from "../../index.vue";
import { merge } from 'lodash-es';
import {
  deepMerge,
  handleTotalAndUnit,
  disposeGridLayout,
  getGeoCoordMap,
} from '../../../common/echartUtil'
import useChartHook from '@/pages-work/components/hooks/useEchartMap'
// 定义 props
const props = defineProps({
  ...echartProps,
})
// 定义响应式数据
const option = ref({})
const chartOption = ref({
  geo: {
    map: '',
    itemStyle: {},
  },
  tooltip: {
    textStyle: {
      color: '#fff',
    },
    padding: 5,
    formatter: null,
  },
})
let [
  { dataSource, reload, pageTips, config, mapDataJson,mapName, getAreaCode, city_point },
  {
    queryData,
    registerMap,
    setGeoAreaColor,
    handleTotalAndUnitMap,
    handleCommonOpt,
    queryCityCenter,
    getHeatMapData,
  },
] = useChartHook(props, initOption)
const echartId = ref('')
// 计算属性
const mapObject = computed(() => ({ code: getAreaCode.value, data: mapDataJson.value }))
// 初始化配置选项
async function initOption(data) {
  let chartData = dataSource.value
  let mapName = await registerMap()
  try {
    // 使用 registerMap 注册的地图名称
    //地图配置
    chartOption.value.tooltip = {
      enterable: true,
      transitionDuration: 1,
      textStyle: {
        color: '#000',
        decoration: 'none',
      },
      trigger: 'item',
      formatter: (params) => {
        let value = params.value || 0
        return `${params.name || '空'}:${value}`
      },
    }
    //使用 registerMap 注册的地图名称
    chartOption.value.geo.map = mapName;
    //配置项修改
    chartOption.value.series = [
      {
        name: '地图',
        type: 'map',
        map: mapName,
        geoIndex: 0,
        aspectScale: 0.75, //长宽比
        showLegendSymbol: false, // 存在legend时显示
        label: {
          show: true,
          color: '#000',
        },
        emphasis: {
          show: true,
          color: '#000',
          itemStyle: {
            areaColor: '#2B91B7',
          },
        },
        roam: true,
        itemStyle: {
          areaColor: '#3B5077',
          borderColor: '#3B5077',
        },
        animation: true,
        data: chartData,
        zlevel: 1,
      },
      {
        name: '数据',
        type: 'heatmap',
        coordinateSystem: 'geo',
        blurSize: config.commonOption?.heat?.blurSize || 20,
        pointSize: config.commonOption?.heat?.pointSize || 15,
        maxOpacity: config.commonOption?.heat?.maxOpacity || 1,
        data: getHeatMapData(chartData),
      },
    ]
    // 合并配置
    if (props.config && props.config.option) {
      merge(chartOption.value, props.config.option)
      chartOption.value = setGeoAreaColor(chartOption.value, props.config)
      chartOption.value = handleTotalAndUnitMap(
        props.compName,
        chartOption.value,
        props.config,
        chartData,
      )
      chartOption.value = handleCommonOpt(chartOption.value)
    }

    //如果视觉映射未设置最大值，就计算数据的最大值并赋值
    if(chartOption.value?.visualMap?.max === 0 && chartData.length>0){
      let maxValue = chartData.reduce((max, data) => Math.max(max, data.value), chartData[0].value);
      chartOption.value.visualMap.max = maxValue;
    }
    if (chartOption.value?.visualMap?.top) {
      chartOption.value.visualMap.top = 'auto';
      chartOption.value.visualMap.bottom = '1%';
    }
    setTimeout(() => {
      option.value = { ...chartOption.value }
      pageTips.show = false
      echartId.value = props.i
    }, 300)
    if (dataSource.value && dataSource.value.length === 0) {
      pageTips.status = 1
      pageTips.show = true
    }
  } catch (e) {
    console.log('热力地图报错', e)
  }
}

// 挂载时查询数据
onMounted(async () => {
  await queryCityCenter()
  await queryData()
})
</script>

<style>
.content {
  margin: 5px;
}
</style>
