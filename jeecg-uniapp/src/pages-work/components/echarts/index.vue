<template>
	<l-echart ref="chartRef"></l-echart>
</template>

<script setup>
//#ifdef MP-WEIXIN
//const uniEchartsWx = require('../../../uni_modules/lime-echart/static/echarts.min');
const uniEchartsWx = require('../../../pages-work/static/echarts.min');
// #endif

//#ifndef MP-WEIXIN
import * as uniEcharts from 'echarts'
// #endif
const props = defineProps({
	option: {
      type: Object,
      default: () => {
          return {}
      }
	},
	mapName: {
	  type: String,
	  default:'china'
	},
	mapData: {
	  type: Object,
	  default: () => {
	      return {}
	  }
	}
})
const chartRef = ref(null)

watchEffect(()=>{
	props.option && init(props.option)
})

function init(finalOption){
	if(finalOption){
		// 组件能被调用必须是组件的节点已经被渲染到页面上
		setTimeout(async()=>{
			if(!chartRef.value) return
      //#ifdef MP-WEIXIN
			const myChartWx = await chartRef.value.init(uniEchartsWx)
			if(props.mapName){
        uniEchartsWx.registerMap(props.mapName,props.mapData)
			}
      myChartWx.setOption(finalOption)
      // #endif

      //#ifndef MP-WEIXIN
			const myChart = await chartRef.value.init(uniEcharts)
			if(props.mapName){
				uniEcharts.registerMap(props.mapName,props.mapData)
			}
      myChart.setOption(finalOption)
      // #endif
		},300)
	}
}


</script>

<style scoped>
	.content{

	}
</style>
