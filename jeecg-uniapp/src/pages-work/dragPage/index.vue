<route lang="json5" type="page">
{
  layout: 'default',
  style: {
    navigationStyle: 'custom',
    navigationBarTitleText: '仪表盘',
  },
}
</route>

<template>
<PageLayout :navTitle="title">
 <scroll-view class="scroll-area" :scroll-y="true" :scroll-with-animation="scrollAnimation" :scroll-top="scrollTop" :scroll-into-view="scrollToView">
	<view v-for="(item,index) in dragData.compsData" :key="index">
	  <view class="mt-4 " :class="[dragData.style=='bigScreen'?'bg-white':'bg-white']" :id="'drag'+item.i" :style="[getStyle(item.component)]">
			<template v-if="compList.includes(item.component)">
				<!-- #ifdef APP-PLUS || H5 -->
				<component
				 :ref="COMP_NAME_PREFIX + item.i"
				 :is="item.component"
				 :compName="item.component"
				 :i="item.i"
				 :id="item.i"
                 :size="item.config?.size"
				 :config="item.config" />
				<!-- #endif -->
				<!-- #ifdef MP-WEIXIN -->
				<dynamic-component :compName="item.component" :i.sync="item.i" :config.sync="item.config" :size="item.config?.size"></dynamic-component>
				<!-- #endif -->
			</template>
		  <template v-else>
				<view class="flex flex-col flex-justify-center flex-items-center" style="min-height: 600upx;height:100%">
					<wd-icon name="info-circle-filled" size="64px"></wd-icon>
					<view class="text-bold">
						<text>暂不支持</text>
					</view>
				</view>
			</template>
		</view>
	</view>
 </scroll-view>
 </PageLayout>
</template>

<script lang="ts" setup>
import { compList, noActionList, COMP_NAME_PREFIX } from '../components/common/concants'
import { http } from '@/utils/http';
// #ifdef MP-WEIXIN
import dynamicComponent from '../components/echarts/dynamic-component.vue';
// #endif

defineOptions({
  name: 'dragPage',
})
const title = ref('仪表盘示例');
const pageId = ref('');
const appId = ref('');
const compObj = ref({});
const dragData = ref({
  name: '',
  compsData: [],
  style:'default'
})

const scrollY = true;
const scrollAnimation = false;
const scrollTop = 0;
const scrollToView = '';
const getStyle = computed(()=>{
	return (component: string)=> {
		let isSetHeight = component === "JDragEditor"?false:true;
		if(component === "JText"){
			return {
				height: 'auto',
				zIndex: 1000
			}
		};
		if(component === "JCalendar"){
			return {
        minHeight: '600rpx',
				height: 'auto',
				zIndex: 1000
			}
		};
		if(component === "JList"){
			return {
        minHeight: '400rpx',
				height: 'auto',
				zIndex: 1000
			}
		};
		if(component === "JFilterQuery"){
			return {
				height: 'auto',
				zIndex: 1000
			}
		};
		return {
			minHeight: '600rpx',
			height: isSetHeight ? '600rpx' : 'auto',
			zIndex: 1000
		}
	}
})
//查询仪表盘数据
function queryData(){
	http.get('/drag/page/queryById',{id:unref(pageId)})
	.then((res:any)=>{
		if (res.success && res.result) {
			let result = res.result;
			let template = result.template ? JSON.parse(result.template) : [];
			dragData.value.name = result.name;
			dragData.value.style = result?.style || "default";
			title.value = result.name;
			template.forEach((item:any)=>{
				if(item.component === "JFilterQuery"){
					item["mobileY"] = 0;
				}else{
					item["mobileY"] = item["mobileY"]||item["mobileY"]==0?item["mobileY"]:1;
				}
				if(item.config.filter && !item.config.filter.customTime){
					item.config.filter['customTime'] = [];
				}
			})
			template.sort((a,b)=>a.mobileY - b.mobileY)
			dragData.value.compsData = template || [];
		}
	})
}
onLoad((option)=>{
	let params:any = option;
	pageId.value = params.id;
	queryData();
})
</script>

<style lang="scss" scoped>
//
</style>
