<template>
  <view class="content">
    <statusTip v-if="pageTips.show" :status="pageTips.status"></statusTip>
    <!-- #ifdef APP-PLUS || H5 -->
<!--    <EchartsMap v-else v-model:option="option" v-model:map="mapObject" v-model:echartId="echartId" />-->
    <!-- #endif -->
    <!-- #ifdef APP-PLUS || H5 || MP-WEIXIN -->
    <echartsUniapp v-else :option="option" :mapName="mapName" :mapData="mapDataJson"></echartsUniapp>
    <!-- #endif -->
  </view>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { echartProps } from '@/pages-work/components/echarts/props'
import EchartsMap from "../index.vue";
import echartsUniapp from "../../index.vue";
import {deepMerge, handleTotalAndUnit, disposeGridLayout, getGeoCoordMap} from '../../../common/echartUtil'
import useChartHook from '@/pages-work/components/hooks/useEchartMap'
import {merge} from "lodash-es";
// 定义 props
const props = defineProps({
  ...echartProps
});
// 定义响应式数据
const option = ref({});
const chartOption = ref({
  geo: {
    map: '',
    itemStyle: {},
  },
  tooltip: {
    textStyle: {
      color: "#fff"
    },
    padding: 5,
    formatter: null
  }
});
let [{ dataSource, reload, pageTips, config,mapDataJson,mapName,getAreaCode,city_point },
  { queryData,registerMap,setGeoAreaColor,handleTotalAndUnitMap,handleCommonOpt,queryCityCenter}] = useChartHook(props, initOption)
const echartId = ref("");
// 地图属性
const mapObject = computed(() => ({ code: getAreaCode.value, data: mapDataJson.value }));

// 初始化配置选项
let geoCoordMap = {};
async function initOption(data){
  let chartData = dataSource.value;
  let mapName = await registerMap();
  try {
    // 使用 registerMap 注册的地图名称
    geoCoordMap = getGeoCoordMap(mapDataJson.value);
    chartOption.value.geo.map = mapName;
    let barSize = config?.commonOption?.barSize || 17;
    let barColor = config?.commonOption?.barColor || '#F8E71C';
    let barColor2 = config?.commonOption?.barColor2 || '#F8E71C';
    chartOption.value.series = [
      {
        geoIndex: 0,
        // coordinateSystem: 'geo',
        showLegendSymbol: false,
        type: 'map',
        roam: true,
        label: {
          show: false,
          color: '#ffffff',
        },
        emphasis: {
          color: 'white',
          show: false,
          itemStyle:{
            areaColor: '#FA8C16',
            borderWidth: 0,
            color: 'green',
          }
        },
        itemStyle: {
          borderColor: '#2980b9',
          borderWidth: 1,
          areaColor: '#12235c',
        },
        map: mapName, // 使用
        animation: true,
        data: chartData,
      },
      {
        type: 'lines',
        zlevel: 5,
        geoIndex: 0,
        effect: {
          show: false,
          symbolSize: 5, // 图标大小
        },
        lineStyle: {
          width: barSize, // 尾迹线条宽度
          color: {
            type: 'linear',
            x: 0,
            y: 0,
            x2: 1,
            y2: 0,
            colorStops: [
              {
                offset: 0,
                color: barColor, // 0% 处的颜色
              },
              {
                offset: 0.5,
                color: barColor, // 0% 处的颜色
              },
              {
                offset: 0.5,
                color: barColor2, // 0% 处的颜色
              },
              {
                offset: 1,
                color: barColor2, // 0% 处的颜色
              },
              {
                offset: 1,
                color: barColor, // 100% 处的颜色
              },
            ],
            global: false, // 缺省为 false
          },
          opacity: 1, // 尾迹线条透明度
          curveness: 0, // 尾迹线条曲直度
        },
        label: {
          show: 0,
          position: 'end',
          formatter: '245',
        },
        silent: true,
        data: lineData(chartData),
      },
      {
        type: 'scatter',
        coordinateSystem: 'geo',
        geoIndex: 0,
        zlevel: 2,
        label: {
          show: false,
          position: 'bottom',
          formatter: (params) => {
            return data[params.dataIndex]?.value
          },
          padding: [4, 8],
          backgroundColor: '#003F5E',
          borderRadius: 5,
          borderColor: '#67F0EF',
          borderWidth: 1,
          color: '#67F0EF',
        },
        symbol: 'diamond',
        symbolSize: [barSize - 1, 8],
        itemStyle: {
          color: barColor,
          opacity: 1,
        },
        silent: true,
        data: scatterData(chartData),
      },
      {
        type: 'scatter',
        coordinateSystem: 'geo',
        geoIndex: 0,
        zlevel: 1,
        label: {
          formatter: '{b}',
          position: 'bottom',
          color: '#fff',
          fontSize: 11,
          distance: 10,
          show: false,
        },
        symbol: 'diamond',
        symbolSize: [barSize - 1, 8],
        itemStyle: {
          // color: '#F7AF21',
          color: {
            type: 'linear',
            x: 0,
            y: 0,
            x2: 1,
            y2: 0,
            colorStops: [
              {
                offset: 0,
                color: barColor, // 0% 处的颜色
              },
              {
                offset: 0.5,
                color: barColor, // 0% 处的颜色
              },
              {
                offset: 0.5,
                color: barColor2, // 0% 处的颜色
              },
              {
                offset: 1,
                color: barColor2, // 0% 处的颜色
              },
              {
                offset: 1,
                color: barColor, // 100% 处的颜色
              },
            ],
            global: false, // 缺省为 false
          },
          opacity: 1,
          // shadowColor: '#fff',
          // shadowBlur: 5,
          // shadowOffsetY: 2
        },
        silent: true,
        data: scatterData2(chartData),
      },
    ];
    // 合并配置
    if (props.config && props.config.option) {
      merge(chartOption.value, props.config.option);
      chartOption.value = setGeoAreaColor(chartOption.value, props.config);
      chartOption.value = handleTotalAndUnitMap(props.compName, chartOption.value, props.config, chartData);
      chartOption.value = handleCommonOpt(chartOption.value);
      setTimeout(() => {
        option.value = { ...chartOption.value };
        console.log("柱形地图option.value", option.value);
        pageTips.show = false;
        echartId.value = props.i;
      }, 300);
    }
    if (dataSource.value && dataSource.value.length === 0) {
      pageTips.status = 1;
      pageTips.show = true;
    }
  } catch (e) {
    console.log("柱形地图报错", e);
  }
};
// 动态计算柱形图的高度（定一个max）
function lineMaxHeight(chartData) {
  const maxValue = Math.max(...chartData.map((item) => item.value));
  return maxValue < 10 ? maxValue : 1 / maxValue;
}

// 柱状体的主干
function lineData(chartData) {
  let lineData = [];
  chartData.forEach((item) => {
    let geoCoord = city_point.value[item.name];
    if (geoCoord) {
      let coords = [geoCoord, [geoCoord[0], geoCoord[1] + item.value * lineMaxHeight(chartData)]];
      lineData.push({
        coords: coords,
      });
    }
  });
  return lineData;
}

// 柱状体的顶部
function scatterData(chartData) {
  let scatterData = [];
  chartData.forEach((item) => {
    let geoCoord = city_point.value[item.name];
    if (geoCoord) {
      scatterData.push([geoCoord[0], geoCoord[1] + item.value * lineMaxHeight(chartData)]);
    }
  });
  return scatterData;
}

// 柱状体的底部
function scatterData2(chartData) {
  let scatterData2 = [];
  chartData.forEach((item) => {
    let geoCoord = city_point.value[item.name];
    if (geoCoord) {
      scatterData2.push({
        name: item.name,
        value: geoCoord,
      })
    }
  });
  return scatterData2;
}

// 挂载时查询数据
onMounted(async () => {
  await queryCityCenter()
  await queryData();
});
</script>

<style>
.content {
  margin: 5px;
}
</style>
