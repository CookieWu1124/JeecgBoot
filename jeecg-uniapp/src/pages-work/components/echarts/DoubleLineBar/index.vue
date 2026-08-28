<template>
  <view class="content">
    <statusTip v-if="pageTips.show" :status="pageTips.status"></statusTip>
	<echartsUniapp v-else :option="option"></echartsUniapp>
  </view>
</template>

<script lang="ts" setup>
import { echartProps } from '@/pages-work/components/echarts/props';
import { deepMerge, handleTotalAndUnit, disposeGridLayout,getCustomColor } from '../../common/echartUtil';
import { isNumber } from '@/utils/is';
import useChartHook from '@/pages-work/components/hooks/useEchart';
import { deepClone } from '@/uni_modules/da-tree/utils';
import echartsUniapp from '@/pages-work/components/echarts/index.vue';
import statusTip from '@/pages-work/components/statusTip.vue';
import {merge} from "lodash-es";
//组件传参
const props = defineProps({
	...echartProps
})
//最终图表配置项
const option = ref({});
let chartOption = {
    title: {
        show: true,
    },
    legend: {
        show: true,
        data: [],
    },
    xAxis: {
        type: 'category',
        nameGap:25,
        data: [],
    },
    yAxis: [
        { type: 'value', alignTicks: true },
        { type: 'value', alignTicks: true },
    ],
    graphic:{
        type: "text",
        right: 0,
        top: 0,
        style: {
            text: "",
            fill: "#464646",
            font: "bolder 18px \"Microsoft YaHei\", sans-serif"
        }
    },
    series: []
};
//图表数据查询
let [{ dataSource, reload, pageTips, config }, { queryData }] = useChartHook(
  props,
  initOption
)


//初始化图表配置项
function initOption(data) {
  let chartData: any = dataSource.value
  if (typeof chartData === 'string') {
    chartData = JSON.parse(chartData)
  }
  if (chartData && chartData.length > 0) {
      const colors = getCustomColor(config.option.customColor);
      let configOption = config.option;
      let leftChartType = configOption.yAxis && configOption.yAxis.length>0?configOption.yAxis[0].chartType:'bar';
      //@ts-ignore
      let legendData = [...new Set(chartData.map((item) => item.type))];
      chartOption.series = [];
      legendData.forEach((legend,index) => {
          //图例颜色
          let legendColor = configOption.series.length>0&&configOption.series[0].color?configOption.series[0].color[index]:null;
          //1.获取类型
          let allData = chartData.filter((item) => item.type == legend);
          //2.获取数据
          let leftData = allData.filter((item) => !item.yAxisIndex || (item.yAxisIndex && item.yAxisIndex == '0'));
          let rightData = allData.filter((item) => item.yAxisIndex && item.yAxisIndex == '1');
          //3.设置数据
          //左y轴
          let seriesType = config.seriesType.filter((item) => item.series == legend);
          if (leftData && leftData.length > 0) {
              let leftSeriesType = seriesType && seriesType.length > 0 ? seriesType[0]['type']:'bar';
              let color = colors&&colors[index]?colors[index].color:"#64b5f6";
              chartOption.series.push({
                  name: legend,
                  type: leftChartType=='line'?leftChartType:leftSeriesType,
                  data: leftData.map((item) => item['value']),
                  color: legendColor || color || '',
                  yAxisIndex: 0,
              });
          }
          //右y轴
          if (rightData && rightData.length > 0) {
              let color = colors && colors[index]?colors[index].color:"";
              chartOption.series.push({
                  name: legend,
                  type: 'line',
                  data: rightData.map((item) => item['value']),
                  color: legendColor || color || '',
                  yAxisIndex: 1,
              });
          }
      });
    //@ts-ignore
      chartOption.xAxis.data = [...new Set(chartData.map((item) => item.name))];
      chartOption.legend.data = legendData;
      // 合并配置
      if (props.config && config.option) {
          merge(chartOption, config.option)
          chartOption = handleTotalAndUnit(props.compName, chartOption, config, chartData)
          chartOption = disposeGridLayout(props.compName, chartOption, config, chartData)
          let title = config.option.title;
          let color = title.textStyle.color||'#000';
          let weight = title.textStyle.fontWeight || 'normal';
          let fontSize = title.textStyle.fontSize || '14';
          chartOption.graphic.style = {
              text: "",
              fill: color,
              font: `${weight} ${fontSize}px "Microsoft YaHei", sans-serif`
          }
      }
      console.log("双轴图this.chartOption====>",chartOption);
      option.value = deepClone(chartOption)
      pageTips.show = false
  } else {
    pageTips.status = 1
    pageTips.show = true
  }
}

onMounted(()=>{
	queryData();
})

</script>
<style>
.content {
  padding: 10px;
}
</style>
