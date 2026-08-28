<template>
  <view class="onlineLoader-container">
    <view class="form-container">
      <wd-form ref="form" :model="formData">
        <wd-cell-group border>
          <view
            class="onlineLoader-form"
            v-for="(item, index) in rootProperties"
            :key="index"
            :class="{ 'mt-14px': index % 2 == 0 }"
          >
            <!-- 图片 -->
            <wd-cell
              v-if="item.type == 'image'"
              :name="item.key"
              :title="get4Label(item.label)"
              :title-width="labelWidth"
              :required="fieldRequired(item)"
            >
              <online-image
                v-model:value="formData[item.key]"
                :name="item.key"
                :disabled="componentDisabled(item)"
                :key="index"
              ></online-image>
            </wd-cell>

            <!-- 文件 -->
            <wd-cell
              v-else-if="item.type == 'file'"
              :name="item.key"
              :title="get4Label(item.label)"
              :title-width="labelWidth"
              :required="fieldRequired(item)"
            >
              <online-image
                v-model:value="formData[item.key]"
                uploadFileType="all"
                :name="item.key"
                :disabled="componentDisabled(item)"
                :key="index"
              ></online-image>
            </wd-cell>

            <!-- 日期时间 -->
            <online-datetime
              v-else-if="item.type === 'datetime'"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :name="item.key"
              :disabled="componentDisabled(item)"
              v-model:value="formData[item.key]"
              :required="fieldRequired(item)"
            ></online-datetime>

            <!-- 日期 -->
            <online-date
              v-else-if="item.type === 'date'"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :name="item.key"
              :type="getDateExtendType(item.formSchema)"
              :disabled="componentDisabled(item)"
              v-model:value="formData[item.key]"
              :required="fieldRequired(item)"
            ></online-date>

            <!-- 时间 -->
            <online-time
              v-else-if="item.type === 'time'"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :name="item.key"
              :disabled="componentDisabled(item)"
              v-model:value="formData[item.key]"
              :required="fieldRequired(item)"
            ></online-time>

            <!-- 下拉选择 -->
            <online-select
              v-else-if="item.type === 'list' || item.type === 'sel_search'"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :name="item.key"
              :type="item.type"
              :dict="item.listSource"
              :dictStr="item.dictStr"
              :disabled="componentDisabled(item)"
              v-model="formData[item.key]"
              :required="fieldRequired(item)"
            ></online-select>

            <!-- checkbox   -->
            <online-checkbox
              v-else-if="item.type === 'checkbox'"
              :name="item.key"
              :type="item.type"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :dict="item.listSource"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
            ></online-checkbox>

            <!-- radio  -->
            <online-radio
              v-else-if="item.type === 'radio'"
              :name="item.key"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :type="item.type"
              :dict="item.listSource"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
            ></online-radio>

            <!-- 下拉多选  -->
            <online-multi
              v-else-if="item.type === 'list_multi'"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :name="item.key"
              :dict="item.listSource"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
            ></online-multi>

            <!-- 省市区   -->
            <online-pca
              v-else-if="item.type === 'pca'"
              :name="item.key"
              :label="get4Label(item.label)"
              :labelWidth="labelWidth"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model:value="formData[item.key]"
            ></online-pca>

            <!-- 数字框 小数 -->
            <wd-input
              v-else-if="item.type === 'number' && (!item.onlyInteger || item.onlyInteger == false)"
              :label-width="labelWidth"
              v-model="formData[item.key]"
              :label="get4Label(item.label)"
              :name="item.key"
              inputMode="decimal"
              :disabled="componentDisabled(item)"
              :placeholder="item.placeholder"
              :rules="item.rules"
            />

            <!-- 数字框 整数 -->
            <wd-input
              v-else-if="item.type === 'number' && item.onlyInteger === true"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :name="item.key"
              v-model="formData[item.key]"
              inputMode="numeric"
              :disabled="componentDisabled(item)"
              :placeholder="item.placeholder"
              :rules="item.rules"
            />

            <!-- 开关 -->
            <wd-cell
              v-else-if="item.type == 'switch'"
              :name="item.key"
              :title="get4Label(item.label)"
              :title-width="labelWidth"
              center
              :required="fieldRequired(item)"
            >
              <view style="text-align: left">
                <wd-switch
                  :label="get4Label(item.label)"
                  :name="item.key"
                  size="18px"
                  :disabled="componentDisabled(item)"
                  v-model="formData[item.key]"
                  :active-value="switchOpt(item.formSchema?.extendOption, 0)"
                  :inactive-value="switchOpt(item.formSchema?.extendOption, 1)"
                />
              </view>
            </wd-cell>

            <!-- 多行文本 -->
            <wd-textarea
              v-else-if="['textarea', 'markdown', 'umeditor'].includes(item.type)"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :name="item.key"
              v-model="formData[item.key]"
              clearable
              :maxlength="300"
              :disabled="componentDisabled(item)"
              :placeholder="item.placeholder"
              :rules="item.rules"
            />
            <!-- 密码输入框 -->
            <wd-input
              v-else-if="item.type === 'password'"
              :label-width="labelWidth"
              v-model="formData[item.key]"
              :disabled="componentDisabled(item)"
              :label="get4Label(item.label)"
              :name="item.key"
              :placeholder="item.placeholder"
              :rules="item.rules"
              show-password
            />
            <!-- popup字典 -->
            <PopupDict
              v-else-if="item.type === 'popup_dict'"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
              :multi="item.formSchema.popupMulti"
              :dictCode="`${item.formSchema.code},${item.formSchema['destFields']},${item.formSchema['orgFields']}`"
            ></PopupDict>
            <!-- popup -->
            <Popup
              v-else-if="item.type === 'popup'"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
              :multi="item.formSchema.popupMulti"
              :code="`${item.formSchema.code}`"
              :setFieldsValue="setFieldsValue"
              :fieldConfig="getPopupFieldConfig(item)"
            ></Popup>
            <!-- 关联记录 -->
            <online-popup-link-record
              v-else-if="item.type === 'link_table'"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :name="item.key"
              v-model:formSchema="item.formSchema"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model:value="formData[item.key]"
              @selected="linkRecordChange"
            ></online-popup-link-record>
            <!-- 他表字段 -->
            <wd-input
              v-else-if="item.type === 'link_table_field'"
              :label-width="labelWidth"
              v-model="formData[item.key]"
              :disabled="true"
              :label="get4Label(item.label)"
              :name="item.key"
            />
            <!-- 用户选择   -->
            <select-user
              v-else-if="item.type === 'sel_user'"
              :label-width="labelWidth"
              :name="item.key"
              :label="get4Label(item.label)"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
            ></select-user>

            <!-- 部门选择   -->
            <select-dept
              v-else-if="item.type === 'sel_depart'"
              :label-width="labelWidth"
              :name="item.key"
              :label="get4Label(item.label)"
              labelKey="departName"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
            ></select-dept>
            <!-- 分类字典树 -->
            <CategorySelect
              v-else-if="item.type === 'cat_tree'"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
              :pid="`${item.formSchema.pidValue}`"
            ></CategorySelect>
            <!-- 自定义树 -->
            <TreeSelect
              v-else-if="item.type === 'sel_tree'"
              :label-width="labelWidth"
              :label="get4Label(item.label)"
              :disabled="componentDisabled(item)"
              :required="fieldRequired(item)"
              v-model="formData[item.key]"
              :dict="`${item.formSchema.dict}`"
              :pidField="`${item.formSchema.pidField}`"
              :pidValue="`${item.formSchema.pidValue}`"
              :hasChildField="`${item.formSchema.hasChildField}`"
            ></TreeSelect>
            <!-- 普通输入框 -->
            <wd-input
              v-else
              :label-width="labelWidth"
              v-model="formData[item.key]"
              :disabled="componentDisabled(item)"
              :label="get4Label(item.label)"
              :name="item.key"
              :placeholder="item.placeholder"
              :rules="item.rules"
              clearable
            />
          </view>
        </wd-cell-group>
      </wd-form>
    </view>
    <view class="footer" v-if="showFooter">
      <wd-button :disabled="loading" block :loading="loading" @click="formSubmit">提交</wd-button>
    </view>
  </view>
</template>

<script lang="ts" setup>
import FormProperty from '@/components/online/FormProperty'
import OnlineImage from '@/components/online/view/online-image.vue'
import OnlineSelect from '@/components/online/view/online-select.vue'
import OnlineTime from '@/components/online/view/online-time.vue'
import OnlineDatetime from '@/components/online/view/online-datetime.vue'
import OnlineDate from '@/components/online/view/online-date.vue'
import OnlineRadio from '@/components/online/view/online-radio.vue'
import OnlineCheckbox from '@/components/online/view/online-checkbox.vue'
import OnlineMulti from '@/components/online/view/online-multi.vue'
import OnlinePca from '@/components/online/view/online-pca.vue'
import OnlinePopupLinkRecord from '@/components/online/view/online-popup-link-record.vue'
import SelectDept from '@/components/SelectDept/SelectDept.vue'
import SelectUser from '@/components/SelectUser/SelectUser.vue'
import { loadOneFieldDefVal } from './defaultVal'
import { useToast, useMessage, useNotify } from 'wot-design-uni'
import { http } from '@/utils/http'
import { deepClone } from 'wot-design-uni/components/common/util'
import { isArray, isNumber } from '@/utils/is'
import { formatDate } from '@/common/uitls'
import { duplicateCheck } from '@/service/api'

// 接收 props
const props = defineProps({
  showHeader: {
    type: Boolean,
    required: false,
    default: false,
  },
  table: {
    type: String,
    default: '',
    required: false,
  },
  taskId: {
    type: String,
    default: '',
    required: false,
  },
  showFooter: {
    type: Boolean,
    required: false,
    default: true,
  },
  edit: {
    type: Boolean,
    default: false,
    required: false,
  },
  flowEdit: {
    type: Boolean,
    default: false,
    required: false,
  },
  dataId: {
    type: String,
    default: '',
    required: false,
  },
  title: {
    type: String,
    default: '',
    required: false,
  },
  disabled: {
    type: Boolean,
    default: false,
    required: false,
  },
  onlyBackData: {
    type: Boolean,
    default: false,
    required: false,
  },
})

// 定义 emits
const emits = defineEmits(['back', 'success', 'formSuccess'])
const toast = useToast()
// 定义响应式数据
const onlinekey = ref(1)
//刷新状态
const reFresh = ref(false)
//请求地址
const url = ref({
  load: '/online/cgform/api/getFormItemBytbname/',
  optPre: '/online/cgform/api/form/',
})
// 表单ID
const code = ref('')
//表类型，1：单表，2：一对多
const single = ref(false)
//是否树表
const treeForm = ref(false)
//表描述
const tableTxt = ref('')
//表名称
const tableName = ref('')
//表名称
const tableType = ref(1)
//表数据Data
const formData = ref<any>({})
//是否填值规则字段
const hasFillRuleFields = ref('')
//是否必填字段
const hasRequiredFields = ref([])
//字段属性
const rootProperties = ref<any>([])
//小程序字段属性
const wxProperties = ref<any>([])
//加载状态
const loading = ref(false)
//表单数据ID
const formDataId = ref('')

// 导航标题
const navTitle = computed(() => {
  if (!props.title || props.title.length === 0) {
    return tableTxt.value
  } else {
    return props.title
  }
})
// 标题宽度
const labelWidth = computed(() => {
  return '100px'
})
// 导航标题
const get4Label = computed(() => {
  return (lable) => {
    return `${lable && lable.length > 4 ? lable.substring(0, 4) : lable}：`
  }
})

onMounted(() => {
  console.log('开始渲染online表单')
})

/**
 * 获取日期控件的扩展类型
 * @param formSchema
 * @returns {string}
 */
const getDateExtendType = (formSchema: any) => {
  if (formSchema.fieldExtendJson) {
    let fieldExtendJson = JSON.parse(formSchema.fieldExtendJson)
    let mapField = {
      month: 'year-month',
      year: 'year',
      quarter: 'date',
      week: 'date',
      day: 'date',
    }
    return fieldExtendJson?.picker && mapField[fieldExtendJson?.picker]
      ? mapField[fieldExtendJson?.picker]
      : 'date'
  }
  return 'date'
}
/**
 * 判断是否选中
 * @param opts
 * @param value
 * @returns {boolean|boolean}
 */
const isChecked = (opts: any, value: any) => {
  return opts && opts.length > 0 ? value === opts[0] : false
}
/**
 * 开关选项
 * @param opts
 * @param value
 * @returns {boolean|boolean}
 */
const switchOpt = (opts: any, index: any) => {
  const options = Array.isArray(opts) && opts.length > 0 ? opts : ['Y', 'N']
  return options[index] + ''
}
/**
 *
 * @param item
 * @returns {*|boolean}
 */
const componentDisabled = (item: any) => {
  if (props.disabled === true || (!props.showFooter && !props.onlyBackData)) {
    return true
  }
  return item.disabled
}

/**
 * 判断字段是否必填
 * @param item
 * @returns {boolean}
 */
const fieldRequired = (item: any) => {
  return item?.key && hasRequiredFields.value.includes(item.key)
}
/**
 * 关联记录同步修改他表字段
 * @param linkRecord
 * @param key
 */
const linkRecordChange = (linkRecord, key) => {
  let linkFieldArr = rootProperties.value.filter(
    (item) => item.type === 'link_table_field' && item?.formSchema?.dictTable == key,
  )
  linkFieldArr.forEach((field) => {
    let value = linkRecord.map((record) => record[field.formSchema.dictText]).join(',')
    nextTick(() => {
      formData.value[field.key] = value
    })
  })
}
/**
 * 返回按钮点击事件
 */
const backRoute = () => {
  emits('back')
}

/**
 * 处理多选字段
 * @param value
 */
function handleMultiOrDateField() {
  let finalData = deepClone(formData.value)
  //日期字段
  let dateFieldArr = rootProperties.value.filter(
    (item) => item.type === 'date' || item.type === 'datetime',
  )
  //省市区字段
  let pcaArr = rootProperties.value.filter((item) => item.type === 'pca')
  finalData = Object.keys(finalData).reduce((acc, key) => {
    let value = finalData[key]
    //省市区获取最后一位
    if (value && pcaArr.length > 0 && pcaArr.map((item) => item.key).includes(key)) {
      console.log('省市区获取最后一位value', value)
      value = isArray(value) ? value[2] : value.split(',')[2]
    }
    //是数组的就转换成字符串
    if (value && isArray(value)) {
      value = value.join(',')
    }
    //时间戳类型的日期转具体格式字符串
    if (dateFieldArr.length > 0) {
      const dateField = dateFieldArr.find((obj) => obj.key === key)
      if (dateField) {
        value =
          value && isNumber(value)
            ? formatDate(
                value,
                dateField.type === 'datetime' ? 'yyyy-MM-dd HH:mm:ss' : 'yyyy-MM-dd',
              )
            : value
      }
    }
    acc[key] = value
    return acc
  }, {})
  return finalData
}

/**
 * 表单提交事件
 * @param e
 */
const formSubmit = async (e) => {
  // 判断字段必填和正则
  if (await fieldCheck(formData.value)) {
    return
  }
  // 处理多选字段
  let finalData = await handleMultiOrDateField()
  // 判断是否只返回数据
  if (props.onlyBackData) {
    emits('success', finalData)
    return
  }
  if (props.flowEdit === true) {
    // 原代码未实现该逻辑，可按需补充
  } else if (props.edit === true) {
    //表单编辑
    await handleEdit(finalData)
  } else {
    //表单新增
    await handleSave(finalData)
  }
}
/**
 * 校验字段
 * @param values
 * @returns {boolean}
 */
const fieldCheck = async (values: any) => {
  // 校验字段
  let flag = false
  for (const item of rootProperties.value) {
    // 校验提示
    const tip = (msg) => {
      // 提示校验未通过
      toast.warning(msg)
      flag = true
    }
    // 校验必填
    if (fieldRequired(item) && !values[item.key]) {
      tip(`${item.label}不能为空！`)
      break
    }
    // 校验正则
    let pattern = item?.formSchema?.pattern
    if (pattern) {
      if (pattern == 'only') {
        const res: any = await duplicateCheck({
          tableName: tableName.value,
          fieldName: item.key,
          fieldVal: values[item.key],
          dataId: formDataId.value,
        })
        if (!res.success) {
          tip(`${item.label} ${res.message}`)
          break
        }
      } else {
        const regex = new RegExp(pattern)
        if (values[item.key] && pattern && !regex.test(values[item.key])) {
          let errorInfo = item?.formSchema?.errorInfo || '格式不正确!'
          tip(`${item.label}${errorInfo}`)
          break
        }
      }
    }
  }
  return flag
}
/**
 * 新增保存
 */
const handleSave = (finalData: any) => {
  if (finalData?.bpm_status) {
    finalData.bpm_status = '1'
  }
  console.log('===onlineForm表单组件走新增保存  handleSave===', finalData)
  http
    .post(`${url.value.optPre}${code.value}?tabletype=${tableType.value}`, finalData)
    .then((res: any) => {
      if (res.success) {
        emits('success', res.result)
      } else {
        toast.warning(res.message)
      }
    })
}
/**
 * 编辑保存
 */
const handleEdit = (finalData: any) => {
  http
    .put(`${url.value.optPre}${code.value}?tabletype=${tableType.value}`, finalData)
    .then((res: any) => {
      if (res.success) {
        emits('success', formData.value.id)
      } else {
        toast.warning(res.message)
      }
    })
}
/**
 * 根据表名加载表单数据
 * @param dataID
 */
const loadByTableName = (dataID: any) => {
  formDataId.value = props.dataId
  // #ifdef MP-WEIXIN
  if (dataID && dataID.length > 0) {
    formDataId.value = dataID
  }
  // #endif
  let urlStr = url.value.load + props.table
  http.get(urlStr, { taskId: props.taskId }).then((res: any) => {
    if (res.success) {
      console.log('===onlineForm加载表单数据 schema===', res.result.schema)
      let config = res.result
      code.value = config.head.id
      single.value = config.head.tableType === 1
      tableType.value = config.head.tableType
      createRootProperties(config.schema)
      treeForm.value = config.head.isTree === 'Y'
      tableTxt.value = config.head.tableTxt
      if (props.edit === true || props.flowEdit === true) {
        loadFormData()
      } else {
        // 新增页面处理表单默认值
        handleDefaultValue()
      }
    } else {
      // 假设 $tip 是全局方法，可按需修改
      toast.info(res.message)
    }
  })
}
/**
 * 创建根属性
 * @param formSchema
 */
const createRootProperties = (formSchema: any) => {
  tableName.value = formSchema.table
  formData.value = {}
  hasFillRuleFields.value = formSchema.hasFillRuleFields
  hasRequiredFields.value = formSchema?.required ?? []
  const properties = formSchema.properties
  let rootProps = [],
    subInfo = []
  console.log('===onlineForm表单配置项 properties===', properties)
  Object.keys(properties).map((key) => {
    if (key) {
      const item = properties[key]
      //TODO 配置主子表的
      if (item.view === 'tab') {
        subInfo.push(item)
      } else {
        formData.value[key] = ''
        let fp = FormProperty(key, item, formSchema.required)
        rootProps.push(fp)
      }
    }
  })
  rootProps.sort((one, next) => {
    return one.formSchema.order - next.formSchema.order
  })
  rootProperties.value = [...rootProps]
  console.log('--rootProperties--', rootProps)

  // #ifdef MP-WEIXIN
  // wxProperties.value = rootProperties.value.map((item) => {
  //   let {
  //     popupCode,
  //     formSchema,
  //     dest,
  //     ogn,
  //     key,
  //     label,
  //     placeholder,
  //     type,
  //     rules,
  //     listSource,
  //     dictStr,
  //     disabled,
  //   } = item
  //   let event = {
  //     formSchema,
  //     dest,
  //     key,
  //     type,
  //     rules,
  //     listSource,
  //     label,
  //     dictStr,
  //     disabled,
  //     placeholder,
  //     ogn,
  //     popupCode,
  //   }
  //   return event
  // })
  // console.log('this.wxProperties', wxProperties.value)

  nextTick(() => {
    reFresh.value = true
    onlinekey.value += 1
  })
  // #endif
  emits('formSuccess', true)
}
/**
 * 获取字段类型
 * @param item
 * @returns {string}
 */
const getFieldNumberType = (item: any) => {
  return item.onlyInteger === true ? 'digit' : 'number'
}
/**
 * 获取表单数据
 */
const loadFormData = () => {
  let urlStr = url.value.optPre + code.value + '/' + formDataId.value
  urlStr = urlStr.replace(/"/g, '')
  http.get(urlStr).then((res: any) => {
    if (res.success) {
      formData.value = { ...res.result }
      console.log('===onlineForm表单组件走获取表单数据 loadFormData===', formData.value)
      // #ifdef MP-WEIXIN
      reFresh.value = false
      nextTick(() => {
        reFresh.value = true
      })
      // #endif
    }
  })
}
/**
 * 获取默认值
 */
const handleDefaultValue = () => {
  console.log('===onlineForm表单组件走默认值 handleDefaultValue===')
  rootProperties.value.forEach((item) => {
    let field = item.key
    let { defVal, type } = item.formSchema
    loadOneFieldDefVal(defVal, type, (value) => {
      formData.value[field] = value
    })
  })
}
const setFieldsValue = (data) => {
  formData.value = { ...formData.value, ...data }
}
const getPopupFieldConfig = (item) => {
  const { formSchema } = item
  const { destFields = '', orgFields = '' } = formSchema
  const result = orgFields.split(',').map((oField, index) => {
    return {
      source: oField,
      target: destFields.split(',')[index],
    }
  })
  return result
}
defineExpose({
  navTitle,
  getDateExtendType,
  isChecked,
  componentDisabled,
  fieldRequired,
  backRoute,
  formSubmit,
  loadByTableName,
  getFieldNumberType,
})
</script>

<style lang="scss" scoped>
.onlineLoader-container {
  .form-container {
    :deep(.wd-cell-group__body){
      background: #F1F1F1;
    }
    .onlineLoader-form{
      :deep(.wd-input__label-inner){
        font-size: 16px;
      }
      :deep(.wd-picker__label){
        font-size: 16px;
      }
      :deep(.wd-select-picker__label){
        font-size: 16px;
      }
      :deep(.wd-cell__title){
        font-size: 16px;
      }
      :deep(.wd-textarea__label-inner){
        font-size: 16px;
      }
      :deep(.wd-input__label.is-required){
         padding-left: 0px;
       }
      :deep(.wd-input__label.is-required::after){
        left: -10px;
      }
      :deep(.wd-textarea__clear){
        color: #bfbfbf;
      }
      :deep(.wd-select-picker__clear){
        color: #bfbfbf;
      }
      :deep(.wd-input__clear){
        color: #bfbfbf;
      }
      :deep(.wd-upload__close){
        color: #bfbfbf;
      }
    }
  }
  .footer {
    padding: 12px;
  }
}
</style>
