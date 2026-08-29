/**
 * 密码 AES-CBC 加密（与 jeecgboot-vue3 / 后端 EncryptedString 保持一致）
 * key / iv 必须与后端 org.jeecg.common.util.encryption.EncryptedString 相同
 */
import CryptoJS from 'crypto-js'

/** 与后端 EncryptedString.key 一致，长度 16 */
export const AES_KEY = '1234567890adbcde'
/** 与后端 EncryptedString.iv 一致，长度 16 */
export const AES_IV = '1234567890hjlkew'

/**
 * AES CBC + PKCS7 加密，输出 CryptoJS 默认 Base64 密文
 * 后端 AesEncryptUtil.resolvePassword 可解密；解不开时仍回退明文
 */
export function encryptAESCBC(plainText: string): string {
  if (!plainText)
    return plainText
  const key = CryptoJS.enc.Utf8.parse(AES_KEY)
  const iv = CryptoJS.enc.Utf8.parse(AES_IV)
  return CryptoJS.AES.encrypt(plainText, key, {
    iv,
    mode: CryptoJS.mode.CBC,
    padding: CryptoJS.pad.Pkcs7,
  }).toString()
}
