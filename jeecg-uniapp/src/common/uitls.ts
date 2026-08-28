import pagesJson from '../pages.json'
// 引入uni-parse-pages
import pagesJsonToRoutes from 'uni-parse-pages'
import { colorPanel } from './constants'

/**
 * 缓存,默认有效期2小时
 * @param key 缓存key
 * @param value  缓存值
 * @param seconds 缓存时间（秒）
 * @returns {*}
 */
export function cache(key, value = null, seconds = 2 * 3600) {
  var timestamp = +new Date() / 1000
  if (key && value === null) {
    //获取缓存
    var val = uni.getStorageSync(key)
    if (val && val.length > 0) {
      var tmp = val.split('|')
      if (!tmp[2] || timestamp >= tmp[2]) {
        console.log('key已失效')
        //删除缓存
        uni.removeStorageSync(key)
        return ''
      } else {
        console.log('key未失效')
        if (tmp[1] == 'json') {
          return JSON.parse(tmp[0])
        }
        return tmp[0]
      }
    }
  } else if (key && value) {
    //设置缓存
    var expire = timestamp + seconds
    console.log('typeof value', typeof value)
    if (typeof value == 'object') {
      value = JSON.stringify(value) + '|json|' + expire
    } else {
      value = value + '|string|' + expire
    }
    uni.setStorageSync(key, value)
  } else {
    console.log('key不能空')
  }
}

// 获取静态文件地址
export const getStaticDomainURL = () => {
  return import.meta.env.VITE_SERVER_BASEURL + '/sys/common/static'
}

export const getFileAccessHttpUrl = function (avatar, subStr?) {
  if (!avatar) return ''
  if (!subStr) subStr = 'http'
  if (avatar) {
    avatar = avatar.replace(/user_imgs\\/, 'user_imgs/')
  }
  if (avatar && avatar.startsWith(subStr)) {
    return avatar
  } else {
    return getStaticDomainURL() + '/' + avatar
  }
}
interface hasRouteType {
  name?: string
  path?: string
  routeList?: any
}
// 判断路由是否存在
export const hasRoute = ({ name, path, routeList }: hasRouteType) => {
  routeList = routeList ?? pagesJsonToRoutes(pagesJson)
  if (path) {
    return !!routeList.find((item) => item.path === path)
  }
  if (name) {
    return !!routeList.find((item) => item.path.split('/').pop() === name)
  }
}

/**
 * 人性化显示时间
 *
 * @param {Object} datetime
 */
export function beautifyTime(datetime = '') {
  if (datetime == null) {
    return ''
  }
  datetime = datetime.toString().replace(/-/g, '/')
  let time = new Date()
  let outTime = new Date(datetime)
  if (/^[1-9]\d*$/.test(datetime)) {
    outTime = new Date(parseInt(datetime))
  }

  if (time.getTime() < outTime.getTime()) {
    return parseTime(outTime, '{y}/{m}/{d}')
  }

  if (time.getFullYear() != outTime.getFullYear()) {
    return parseTime(outTime, '{y}/{m}/{d}')
  }

  if (time.getMonth() != outTime.getMonth()) {
    return parseTime(outTime, '{m}/{d}')
  }

  if (time.getDate() != outTime.getDate()) {
    let day = outTime.getDate() - time.getDate()
    if (day == -1) {
      return parseTime(outTime, '昨天 {h}:{i}')
    }

    if (day == -2) {
      return parseTime(outTime, '前天 {h}:{i}')
    }

    return parseTime(outTime, '{m}-{d}')
  }

  if (time.getHours() != outTime.getHours()) {
    return parseTime(outTime, '{h}:{i}')
  }

  let minutes = outTime.getMinutes() - time.getMinutes()
  if (minutes == 0) {
    return '刚刚'
  }

  minutes = Math.abs(minutes)
  return `${minutes}分钟前`
}
/**
 * 格式化时间
 * @param {Object} time
 * @param {Object} cFormat
 */
export function parseTime(time, cFormat) {
  if (arguments.length === 0) {
    return null
  }

  let date
  const format = cFormat || '{y}-{m}-{d} {h}:{i}:{s}'

  if (typeof time === 'object') {
    date = time
  } else {
    if (typeof time === 'string' && /^[0-9]+$/.test(time)) {
      time = parseInt(time)
    } else {
      time = new Date(time)
    }
    date = new Date(time.toString().replace(/-/g, '/'))
  }

  const formatObj = {
    y: date.getFullYear(),
    m: date.getMonth() + 1,
    d: date.getDate(),
    h: date.getHours(),
    i: date.getMinutes(),
    s: date.getSeconds(),
    a: date.getDay(),
  }

  const time_str = format.replace(/{([ymdhisa])+}/g, (result, key) => {
    const value = formatObj[key]
    // Note: getDay() returns 0 on Sunday
    if (key === 'a') {
      return ['日', '一', '二', '三', '四', '五', '六'][value]
    }

    return value.toString().padStart(2, '0')
  })

  return time_str
}

/**
 * 随机生成字符串
 * @param length 字符串的长度
 * @param chats 可选字符串区间（只会生成传入的字符串中的字符）
 * @return string 生成的字符串
 */
export function randomString(length, chats) {
  if (!length) length = 1
  if (!chats) chats = '0123456789qwertyuioplkjhgfdsazxcvbnm'
  let str = ''
  for (let i = 0; i < length; i++) {
    //@ts-ignore
    let num = randomNumber(0, chats.length - 1)
    str += chats[num]
  }
  return str
}

/**
 * 随机生成数字
 *
 * 示例：生成长度为 12 的随机数：randomNumber(12)
 * 示例：生成 3~23 之间的随机数：randomNumber(3, 23)
 *
 * @param1 最小值 | 长度
 * @param2 最大值
 * @return int 生成后的数字
 */
export function randomNumber() {
  // 生成 最小值 到 最大值 区间的随机数
  const random = (min, max) => {
    return Math.floor(Math.random() * (max - min + 1) + min)
  }
  if (arguments.length === 1) {
    //@ts-ignore
    let [length] = arguments
    // 生成指定长度的随机数字，首位一定不是 0
    //@ts-ignore
    let nums = [...Array(length).keys()].map((i) => (i > 0 ? random(0, 9) : random(1, 9)))
    return parseInt(nums.join(''))
  } else if (arguments.length >= 2) {
    //@ts-ignore
    let [min, max] = arguments
    return random(min, max)
  } else {
    return Number.NaN
  }
}

/**
 * 时间格式化
 * @param value
 * @param fmt
 * @returns {*}
 */
export function formatDate(value, fmt) {
  var regPos = /^\d+(\.\d+)?$/
  if (regPos.test(value)) {
    //如果是数字
    let getDate = new Date(value)
    let o = {
      'M+': getDate.getMonth() + 1,
      'd+': getDate.getDate(),
      'h+': getDate.getHours(),
      'H+': getDate.getHours(),
      'm+': getDate.getMinutes(),
      's+': getDate.getSeconds(),
      'q+': Math.floor((getDate.getMonth() + 3) / 3),
      S: getDate.getMilliseconds(),
    }
    if (/(y+)/.test(fmt)) {
      fmt = fmt.replace(RegExp.$1, (getDate.getFullYear() + '').substr(4 - RegExp.$1.length))
    }
    for (let k in o) {
      if (new RegExp('(' + k + ')').test(fmt)) {
        fmt = fmt.replace(
          RegExp.$1,
          RegExp.$1.length === 1 ? o[k] : ('00' + o[k]).substr(('' + o[k]).length),
        )
      }
    }
    return fmt
  } else {
    //TODO
    if (value && value.length > 0) {
      value = value.trim()
      return value.substr(0, fmt.length)
    }
    return value
  }
}

// 通过时间或者时间戳获取对应antd的年、月、周、季度。
export function getWeekMonthQuarterYear(date) {
  // 获取 ISO 周数的函数
  const getISOWeek = (date) => {
    const jan4 = new Date(date.getFullYear(), 0, 4)
    const oneDay = 86400000 // 一天的毫秒数
    return Math.ceil(((date - jan4.getTime()) / oneDay + jan4.getDay() + 1) / 7)
  }
  // 将时间戳转换为日期对象
  const dateObj = new Date(date)
  // 计算周
  const week = getISOWeek(dateObj)
  // 计算月
  const month = dateObj.getMonth() + 1 // 月份是从0开始的，所以要加1
  // 计算季度
  const quarter = Math.floor(dateObj.getMonth() / 3) + 1
  // 计算年
  const year = dateObj.getFullYear()
  return {
    year: `${year}`,
    month: `${year}-${month.toString().padStart(2, '0')}`,
    week: `${year}-${week}周`,
    quarter: `${year}-Q${quarter}`,
  }
}

// 生成 1 到 10 之间的随机整数
export function getRandomIntBetweenOneAndTen() {
    return Math.floor(Math.random() * 10) + 1;
}
/**
 * 获取随机颜色
 * @param {any} color
 * 颜色板
 * classic：经典
 * technology：科技
 * business：商务
 * botany：植物
 * natural：自然
 * colour：彩色
 * @return
 */
export function getRandomColor() {
	let colorType = ['classic','technology','business','botany','natural','colour'];
	// 生成一个随机索引，范围是从 0 到数组长度减 1
	let randomIndex = Math.floor(Math.random() * colorType.length);
	// 根据随机索引从数组中获取一个随机类型
	let randomColorType = colorType[randomIndex];
	return colorPanel['natural'][getRandomIntBetweenOneAndTen()] || '#00bcd4';
}

// 消除后缀：
export const getPlaceholder = (attrs: any = {}) => {
  let label = attrs.label
  if (label.endsWith('：') || label.endsWith(':')) {
    label = label.substr(0, label.length - 1)
  }
  return `请选择${label}`
}