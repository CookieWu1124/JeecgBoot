package org.jeecg.modules.sale.so.utils;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.jeecg.common.constant.CommonConstant;
import org.jeecg.common.util.oConvertUtils;
import org.jeecg.modules.system.entity.SysDict;
import org.jeecg.modules.system.entity.SysDictItem;
import org.jeecg.modules.system.service.ISysDictItemService;
import org.jeecg.modules.system.service.ISysDictService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Component
public class DictUtil {
    @Autowired
    private ISysDictItemService itemService;
    @Autowired
    private ISysDictService dictService;

    public String getNameByKey(String code,String key){
        return getStringBy(code, key, "KEY");
    }

    public String getKeyByValue(String code,String value){
        return getStringBy(code, value, "VAL");
    }

    public String getStringBy(String code, String value, String type) {
        LambdaQueryWrapper<SysDict> queryWrapper=new LambdaQueryWrapper<>();
        queryWrapper.eq(SysDict::getDictCode,code);
        List<SysDict> dictList = dictService.list(queryWrapper);
        if(CollectionUtils.isEmpty(dictList)) return "";
        String id = dictList.get(0).getId();
        LambdaQueryWrapper<SysDictItem> wrapper=new LambdaQueryWrapper<>();
        wrapper.eq(SysDictItem::getDictId,id);
        if (StringUtils.equals(type, "KEY")) {
            wrapper.eq(SysDictItem::getItemValue,value);
        } else {
            wrapper.eq(SysDictItem::getItemText,value);
        }
        List<SysDictItem> itemList = itemService.list(wrapper);
        if(CollectionUtils.isEmpty(itemList)) return "";
        if (StringUtils.equals(type, "KEY")) {
            return itemList.get(0).getItemText();
        } else {
            return itemList.get(0).getItemValue();
        }
    }

    public List<SysDictItem> getDictItems(String code){
        LambdaQueryWrapper<SysDict> queryWrapper=new LambdaQueryWrapper<>();
        queryWrapper.eq(SysDict::getDictCode,code);
        List<SysDict> dictList = dictService.list(queryWrapper);
        if(CollectionUtils.isEmpty(dictList)) return new ArrayList<>();
        String id = dictList.get(0).getId();
        LambdaQueryWrapper<SysDictItem> wrapper=new LambdaQueryWrapper<>();
        wrapper.eq(SysDictItem::getDictId,id);
        List<SysDictItem> itemList = itemService.list(wrapper);
        if(CollectionUtils.isEmpty(itemList)) return new ArrayList<>();
        return itemList;
    }

    /**
     * 单个对象字典翻译
     */
    public <T> JSONObject translate(T entity) {
        if (entity == null) {
            return null;
        }
        JSONObject json = (JSONObject) JSONObject.toJSON(entity);
        Field[] fields = entity.getClass().getDeclaredFields();
        for (Field field : fields) {
            if (field.isAnnotationPresent(org.jeecg.common.aspect.annotation.Dict.class)) {
                org.jeecg.common.aspect.annotation.Dict dict = field.getAnnotation(org.jeecg.common.aspect.annotation.Dict.class);
                String dictCode = dict.dicCode();
                String fieldName = field.getName();
                Object value = json.get(fieldName);
                if (value != null) {
                    String text = getNameByKey(dictCode, value.toString());
                    json.put(fieldName + CommonConstant.DICT_TEXT_SUFFIX, text);
                }
            }
        }
        return json;
    }

    /**
     * List 字典翻译
     */
    public <T> List<JSONObject> translateList(List<T> list) {
        if (oConvertUtils.isEmpty(list)) {
            return Collections.emptyList();
        }
        List<JSONObject> resultList = new ArrayList<>();
        for (T entity : list) {
            resultList.add(translate(entity));
        }
        return resultList;
    }

}
