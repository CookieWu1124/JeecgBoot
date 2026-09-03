package org.jeecg.modules.sale.so.utils;

import com.alibaba.fastjson.JSON;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.jeecg.common.system.api.ISysBaseAPI;
import org.jeecg.common.system.util.JwtUtil;
import org.jeecg.common.system.vo.LoginUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import jakarta.servlet.http.HttpServletRequest;
import java.lang.reflect.Field;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Component
public class PreDealUtils {
	@Autowired
    private ISysBaseAPI sysBaseAPI;
	public LoginUser getLoginUser() {
        //获取RequestAttributes
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        //从获取RequestAttributes中获取HttpServletRequest的信息
        HttpServletRequest request = (HttpServletRequest) requestAttributes.resolveReference(RequestAttributes.REFERENCE_REQUEST);

		if(request == null){
			return null;
		}
		LoginUser user = null;
		String token = request.getHeader("X-Access-Token");
        if(StringUtils.isNotBlank(token)){
            Map<String, String> map = JwtUtil.parseToken(token);
            if (MapUtils.isNotEmpty(map)) {
                String userName = map.get("userName");
                user = sysBaseAPI.getUserByName(userName);
            }
        }
		return user;
	}

    public LoginUser getLoginUserByUserName(String userName) {
        return sysBaseAPI.getUserByName(userName);
    }
	
    public <T> void preDealEntityById(T entity) {
    	LoginUser user = getLoginUser();
        try {
            Field f_id = getDeclaredField(entity, "id");
            if (f_id != null) {
                f_id.setAccessible(true);
                Date date = new Date();
                if (f_id.get(entity) == null) {
                    //新增
                    setFieldValue(entity, "createTime", date);
                    if (user != null) {
                        setFieldValue(entity, "createNo", user.getUsername());
                        setFieldValue(entity, "createBy", user.getRealname());
                        setFieldValue(entity, "sysOrgCode", user.getOrgCode());
                    }
                }
                setFieldValue(entity, "updateTime", date);
                if (user != null) {
                    setFieldValue(entity, "updateNo", user.getUsername());
                    setFieldValue(entity, "updateBy", user.getRealname());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public <T> void preAddDealEntityById(T entity) {
        LoginUser user = getLoginUser();
        try {
            Field f_id = getDeclaredField(entity, "id");
            if (f_id != null) {
                f_id.setAccessible(true);
                Date date = new Date();
                //新增
                setFieldValue(entity, "createTime", date);
                if (user != null) {
                    setFieldValue(entity, "createNo", user.getUsername());
                    setFieldValue(entity, "createBy", user.getRealname());
                    setFieldValue(entity, "sysOrgCode", user.getOrgCode());

                    setFieldValue(entity, "updateTime", date);
                    setFieldValue(entity, "updateNo", user.getUsername());
                    setFieldValue(entity, "updateBy", user.getRealname());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public <T> void preDealBatchEntityById(List<T> entitys) {
    	LoginUser user = getLoginUser();
    	System.out.println(JSON.toJSONString(user));
        try {
            for (T entity : entitys) {
                Field f_id = getDeclaredField(entity, "id");
                if (f_id != null) {
                    f_id.setAccessible(true);
                    Date date = new Date();
                    
                    if (f_id.get(entity) == null) {
                        //新增
                        setFieldValue(entity, "createTime", date);
                        if (user != null) {
                            setFieldValue(entity, "createNo", user.getUsername());
                            setFieldValue(entity, "createBy", user.getRealname());
                            setFieldValue(entity, "sysOrgCode", user.getOrgCode());
                        }
                    }
                    
                    setFieldValue(entity, "updateTime", date);
                    if (user != null) {
                        setFieldValue(entity, "updateNo", user.getUsername());
                        setFieldValue(entity, "updateBy", user.getRealname());
                    }
              
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }


    public LoginUser getLoginUser(HttpServletRequest request) {
        if(request == null){
            return null;
        }
        LoginUser user = null;
        String token = request.getHeader("X-Access-Token");
        if(StringUtils.isNotBlank(token)){
            Map<String, String> map = JwtUtil.parseToken(token);
            if (MapUtils.isNotEmpty(map)) {
                String userName = map.get("userName");
                user = sysBaseAPI.getUserByName(userName);
            }
        }
        return user;
    }

    public <T> void preDealEntityById(T entity,HttpServletRequest request) {
        LoginUser user = getLoginUser(request);
        System.out.println(JSON.toJSONString(user));
        try {
            Field f_id = getDeclaredField(entity, "id");
            if (f_id != null) {
                f_id.setAccessible(true);
                Date date = new Date();
                if (f_id.get(entity) == null) {
                    //新增
                    setFieldValue(entity, "createTime", date);
                    if (user != null) {
                        setFieldValue(entity, "createNo", user.getUsername());
                        setFieldValue(entity, "createBy", user.getRealname());
                        setFieldValue(entity, "sysOrgCode", user.getOrgCode());
                    }
                }
                setFieldValue(entity, "updateTime", date);
                if (user != null) {
                    setFieldValue(entity, "updateNo", user.getUsername());
                    setFieldValue(entity, "updateBy", user.getRealname());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public <T> void preDealBatchEntityById(List<T> entitys,HttpServletRequest request) {
        LoginUser user = getLoginUser(request);
        System.out.println(JSON.toJSONString(user));
        try {
            for (T entity : entitys) {
                Field f_id = getDeclaredField(entity, "id");
                if (f_id != null) {
                    f_id.setAccessible(true);
                    Date date = new Date();

                    if (f_id.get(entity) == null) {
                        //新增
                        setFieldValue(entity, "createTime", date);
                        if (user != null) {
                            setFieldValue(entity, "createNo", user.getUsername());
                            setFieldValue(entity, "createBy", user.getRealname());
                            setFieldValue(entity, "sysOrgCode", user.getOrgCode());
                        }
                    }

                    setFieldValue(entity, "updateTime", date);
                    if (user != null) {
                        setFieldValue(entity, "updateNo", user.getUsername());
                        setFieldValue(entity, "updateBy", user.getRealname());
                    }

                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
    
    /**
     * 反射-获取指定字段
     *
     * @param <T>
     * @param clazz
     * @param fieldName
     * @return
     */
    public <T> Field getDeclaredField(T entity, String fieldName) {
        Class<?> clazz = entity.getClass();
        Field field = null;
        for (; clazz != Object.class; clazz = clazz.getSuperclass()) {
            try {
                field = clazz.getDeclaredField(fieldName);
                return field;
            } catch (Exception e) {
            }
        }

        return null;
    }


    /**
     * 反射-给指定字段设置
     *
     * @param <T>
     * @param clazz
     * @param fieldName
     * @param value
     */
    public <T> void setFieldValue(T entity, String fieldName, Object value) {
        //根据 对象和属性名通过取 Field对象
        Field field = getDeclaredField(entity, fieldName);
        try {
            if (field != null) {
                //抑制Java对其的检查
                field.setAccessible(true);
                //将 object 中 field 所代表的值 设置为 value
                field.set(entity, value);
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }

    }

    public LoginUser getUserByName (String userName) {
        return sysBaseAPI.getUserByName(userName);
    }
}
