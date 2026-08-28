// 全局要用的类型放到这里

declare global {
  type IResData<T> = {
    code: number
    msg: string
    data: T
  }

  // uni.uploadFile文件上传参数
  type IUniUploadFileOptions = {
    file?: File
    files?: UniApp.UploadFileOptionFiles[]
    filePath?: string
    name?: string
    formData?: any
  }

  type IUserInfo = {
    token?: string
    userid?: string
    username?: string
    realname?: string
    welcome?: string
    avatar?: string
    tenantId?: string | number
    sex?: number
    phone?: string
    email?: string
    /** 微信的 openid，非微信没有这个字段 */
    openid?: string
    // 存到本地的时间戳
    localStorageTime: number
  }
}

export {} // 防止模块污染
