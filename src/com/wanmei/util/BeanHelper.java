package com.wanmei.util;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import org.springframework.beans.BeanUtils;

import com.wanmei.domain.DomainField;

public class BeanHelper {
	protected static final Object[] NULL_ARGUMENTS = {};

	private static Map<String, Map<Integer, Map<String, Method>>> cache = new HashMap<String, Map<Integer, Map<String, Method>>>();

	private static BeanHelper bhelp = new BeanHelper();

	private final static int GETID = 0;

	private final static int SETID = 1;

	ReentrantReadWriteLock rwl = new ReentrantReadWriteLock();

	public static BeanHelper getInstance() {
		return bhelp;
	}

	private BeanHelper() {
	}

	protected static PropertyDescriptor[] getPropertyDescriptor(Class<?> beanCls) {
		try {
			BeanInfo beanInfo = Introspector.getBeanInfo(beanCls);
			return beanInfo.getPropertyDescriptors();
		} catch (IntrospectionException e) {
			throw new RuntimeException(
					"Failed to instrospect bean: " + beanCls, e);
		}
	}

	public static List<String> getPropertys(Object bean) {
		return Arrays.asList(getInstance().getPropertiesAry(bean));

	}

	public String[] getPropertiesAry(Object bean) {
		Map<Integer, Map<String, Method>> cMethod = null;
		rwl.readLock().lock();
		try {
			cMethod = cacheMethod(bean.getClass());
		} finally {
			rwl.readLock().unlock();
		}
		String[] retProps = cMethod.get(SETID).keySet().toArray(new String[0]);

		return retProps;
	}

	public static Object getProperty(Object bean, String propertyName) {

		try {
			Method method = getInstance().getMethod(bean, propertyName, false);
			if (method == null)
				return null;
			return method.invoke(bean, NULL_ARGUMENTS);
		} catch (Exception e) {
			String errStr = "Failed to get property: " + propertyName;
			throw new RuntimeException(errStr, e);
		}
	}

	public static Method getMethod(Object bean, String propertyName) {
		return getInstance().getMethod(bean, propertyName, true);
	}

	private Method getMethod(Object bean, String propertyName,
			boolean isSetMethod) {

		Method method = null;
		rwl.readLock().lock();
		Map<Integer, Map<String, Method>> cMethod = null;
		try {
			cMethod = cacheMethod(bean.getClass());
		} finally {
			rwl.readLock().unlock();
		}
		if (isSetMethod)
			method = cMethod.get(SETID).get(propertyName);
		else
			method = cMethod.get(GETID).get(propertyName);

		return method;
	}

	private Map<Integer, Map<String, Method>> cacheMethod(Class<?> beanCls) {
		String key = beanCls.getName();
		Map<Integer, Map<String, Method>> cMethod = cache.get(key);
		if (cMethod == null) {
			rwl.readLock().unlock();
			rwl.writeLock().lock();
			try {
				cMethod = cache.get(key);
				if (cMethod == null) {
					cMethod = new HashMap<Integer, Map<String, Method>>();
					Map<String, Method> getMap = new HashMap<String, Method>();
					Map<String, Method> setMap = new HashMap<String, Method>();
					cMethod.put(GETID, getMap);
					cMethod.put(SETID, setMap);
					cache.put(key, cMethod);
					PropertyDescriptor[] pdescriptor = getPropertyDescriptor(beanCls);
					for (PropertyDescriptor pd : pdescriptor) {
						if (pd.getReadMethod() != null)
							getMap.put(pd.getName().toLowerCase(), pd
									.getReadMethod());
						if (pd.getWriteMethod() != null)
							setMap.put(pd.getName().toLowerCase(), pd
									.getWriteMethod());
					}
				}
			} finally {
				rwl.readLock().lock();
				rwl.writeLock().unlock();
			}
		}
		return cMethod;
	}

	public static void invokeMethod(Object bean, Method method, Object value) {
		try {
			if (method == null)
				return;
			Object[] arguments = { value };
			method.invoke(bean, arguments);
		} catch (Exception e) {
			String errStr = "Failed to set property: " + method.getName();
			throw new RuntimeException(errStr, e);
		}
	}

	public static void setProperty(Object bean, String propertyName,
			Object value) {
		try {
			Method method = getInstance().getMethod(bean, propertyName, true);
			if (method == null)
				return;
			Object[] arguments = { value };
			method.invoke(bean, arguments);
		} catch (Exception e) {
			String errStr = "Failed to set property: " + propertyName
					+ " on bean: " + bean.getClass().getName() + " with value:"
					+ value;
			throw new RuntimeException(errStr, e);
		}
	}

		
	/*
	 *  
	 */
	public Method[] getAllGetMethod(Class<?> beanCls, String[] fieldNames) {

		Method[] methods = null;
		Map<Integer, Map<String, Method>> cMethod = null;
		List<Method> al = new ArrayList<Method>();
		rwl.readLock().lock();
		try {
			cMethod = cacheMethod(beanCls);
		} finally {
			rwl.readLock().unlock();
		}
		Map<String, Method> map = cMethod.get(GETID);

		for (String str : fieldNames) {
			al.add(map.get(str));
		}
		methods = al.toArray(new Method[al.size()]);
		return methods;
	}
	/**
	 * 获得某个类的属性
	 * @param c
	 * @param fn
	 * @return
	 * @throws NoSuchFieldException
	 */
	public static Field getField( Class<?> c, String fn) throws NoSuchFieldException
	{
		Field f;
		try 
		{
			f = c.getDeclaredField( fn );
		} 
		catch ( NoSuchFieldException e) 
		{
			Class<?> p = c.getSuperclass();
			if( p.getName().equals("java.lang.Object") )
				throw e;
			f = getField( p, fn );
		}
		return f;
	}
	/**
	 * 给某个对象的某个属性设置值，可以根据点表达式来设置关联的对象
	 * @param bean
	 * @param field
	 * @param value
	 * @return
	 * @throws NoSuchFieldException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	public static Object setField(Object bean,String field,Object value) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, InstantiationException{
		String fName = field;
		int poIndex = field.indexOf(".");
		Field f = null;
		if(poIndex != -1){
			fName = field.substring(0,poIndex);
			f = BeanHelper.getField(bean.getClass(), fName);
			f.setAccessible(true);
			Object o = f.get(bean);
			if(null == o){
				Class<?> c = f.getType();
				o = c.newInstance();
			}
			value = setField(o,field.substring(poIndex + 1),value);
		}
		if(null == f){
			f = BeanHelper.getField(bean.getClass(), fName);
		}
		f.setAccessible(true);
		f.set(bean, value);
		return bean;
	}
	/**
	 * 将变量和值对，放到map中
	 * @param map
	 * @param field
	 * @param value
	 * @return
	 * @throws NoSuchFieldException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	public static Object putMap(Map<String,Object> map,String field,Object value) throws NoSuchFieldException, IllegalArgumentException, IllegalAccessException, InstantiationException{
		String fName = field;
		int poIndex = field.indexOf(".");
		if(poIndex != -1){
			fName = field.substring(0,poIndex);
			@SuppressWarnings("unchecked")
			Map<String,Object> o = (Map<String, Object>) map.get(fName);
			if(null == o){
				o = new HashMap<String,Object>();
			}
			value = putMap(o,field.substring(poIndex + 1),value);
		}
		map.put(fName, value);
		return map;
	}
	/**
	 * 判断是不是基本类型
	 * @param c
	 * @return
	 */
	public static boolean isBasicType(Class<?> c){
		if(String.class.equals(c)){
			return true;
		}else if(Integer.class.equals(c) || int.class.equals(c)){
			return true;
		}else if(Double.class.equals(c) || double.class.equals(c)){
			return true;
		}else if(Float.class.equals(c) || float.class.equals(c)){
			return true;
		}else if(Long.class.equals(c) || long.class.equals(c)){
			return true;
		}else if(Short.class.equals(c) || short.class.equals(c)){
			return true;
		}else if(Boolean.class.equals(c) || boolean.class.equals(c)){
			return true;
		}else if(Byte.class.equals(c) || byte.class.equals(c)){
			return true;
		}else if(Character.class.equals(c) || char.class.equals(c)){
			return true;
		}else if(Date.class.equals(c)){
			return true;
		}else if(List.class.equals(c) || ArrayList.class.equals(c)){
			return true;
		}else if(String[].class.equals(c)){
			return true;
		}else if(int[].class.equals(c) || Integer[].class.equals(c)){
			return true;
		}else if(long[].class.equals(c) || Long[].class.equals(c)){
			return true;
		}else if(short[].class.equals(c) || Short[].class.equals(c)){
			return true;
		}else if(float[].class.equals(c) || Float[].class.equals(c)){
			return true;
		}else if(double[].class.equals(c) || Double[].class.equals(c)){
			return true;
		}else if(byte[].class.equals(c) || Byte[].class.equals(c)){
			return true;
		}else if(boolean[].class.equals(c) || Boolean[].class.equals(c)){
			return true;
		}else if(char[].class.equals(c) || Character[].class.equals(c)){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 将source对象中值不为null的属性的值拷贝给target对象中同名的属性。
	 * @param source
	 * @param target
	 */
	public static void copyNotNullProperties( Object source, Object target )
	{
		Class<?> actualEditable = target.getClass();
		PropertyDescriptor[] targetPds = BeanUtils.getPropertyDescriptors(actualEditable);
		for (int i = 0; i < targetPds.length; i++) {
			PropertyDescriptor targetPd = targetPds[i];
			PropertyDescriptor sourcePd = BeanUtils.getPropertyDescriptor(source.getClass(), targetPd.getName());
			if (sourcePd != null && sourcePd.getReadMethod() != null) {
				
				try {
					Method readMethod = sourcePd.getReadMethod();
					if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
						readMethod.setAccessible(true);
					}
					Object value = readMethod.invoke(source, new Object[0]);
					if( value!=null )
					{
						Method writeMethod = targetPd.getWriteMethod();
						if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
							writeMethod.setAccessible(true);
						}
						writeMethod.invoke(target, new Object[] {value});
					}
				}
				catch (Throwable ex) {
				// new Exception("Could not copy properties from source to target", ex);
				}
			}
		}	
		
	}
	public static void main(String[] args) {
		DomainField df = new DomainField();
		df.setListOrder(10);
		com.wanmei.domain.Field f = new com.wanmei.domain.Field();
		copyNotNullProperties(df,f);
		System.out.println(f.getListOrder());
	}
}
