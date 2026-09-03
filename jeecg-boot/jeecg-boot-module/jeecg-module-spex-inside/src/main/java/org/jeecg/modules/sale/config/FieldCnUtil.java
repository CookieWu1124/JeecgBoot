package org.jeecg.modules.sale.config;

import io.swagger.v3.oas.annotations.media.Schema;

import java.lang.reflect.Field;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class FieldCnUtil {
    // 缓存：Class -> {字段英文名: 中文注释}
    private static final Map<Class<?>, Map<String, String>> CACHE = new ConcurrentHashMap<>();

    /**
     * 根据类全限定名 + 字段英文名，获取@ApiModelProperty中文
     */
    public static String getFieldCn(String className, String fieldEnName) {
        Class<?> clazz;
        try {
            clazz = Class.forName(className);
        } catch (ClassNotFoundException e) {
            // 类找不到，兜底返回英文字段
            return fieldEnName;
        }
        // 读取缓存，没有则反射加载字段注解
        Map<String, String> fieldMap = CACHE.computeIfAbsent(clazz, k -> {
            Map<String, String> map = new ConcurrentHashMap<>();
            for (Field field : clazz.getDeclaredFields()) {
                // 1. 使用新版的 @Schema 注解
                Schema schema = field.getAnnotation(Schema.class);
                if (schema != null) {
                    // 2. 新版中，中文描述通过 .description() 获取，且优先使用 .title()
                    String desc = schema.description();
                    if (desc == null || desc.isEmpty()) {
                        desc = schema.title(); // 如果没有 description，尝试获取 title
                    }
                    if (desc != null && !desc.isEmpty()) {
                        map.put(field.getName(), desc);
                    }
                }
            }
            return map;
        });
        return fieldMap.getOrDefault(fieldEnName, fieldEnName);
    }
}