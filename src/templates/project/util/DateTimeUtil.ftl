package ${project.org}.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 时间处理工具类
 */
public class DateTimeUtil {

   public DateTimeUtil() {
    }
    /**
     * 增加年
     * @param date
     * @param nYear
     * @return
     */
    public static Date addYear(Date date, int nYear) {
    	return add(date,nYear,Calendar.YEAR);
    }
    /**
     * 增加月份
     * @param date
     * @param nMonth
     * @return
     */
    public static Date addMonth(Date date, int nMonth) {
        return add(date,nMonth,Calendar.MONTH);
    }

    /**
     * 增加小时
     * @param date
     * @param hours
     * @return
     */
    public static Date addHour(Date date, int hours) {
        return add(date,hours,Calendar.HOUR_OF_DAY);
    }
    /**
     * 日期增加
     * @param date
     * @param num
     * @param type
     * @return
     */
    public static Date add(Date date,int num,int type){
    	 Calendar cal = Calendar.getInstance();
         cal.setTime(date);
         cal.add(type, num);
         Date result = cal.getTime();
         return result;
    }
    /**
     * 格式化日期为字符串函数.
     *
     * @param date 日期.
     * @return 日期转化来的字符串.
     */
    public static String formatDate(Date date) {
    	return formatDate(date,"yyyy-MM-dd");
    	
    }
    /**
     * 格式化日期为字符串函数.
     *
     * @param date 日期.
     * @param pattern 格式.
     * @return 日期转化来的字符串.
     */
    public static String formatDate(Date date,String pattern) {
        if (date == null) {
            return "";
        }
        if(null == pattern || pattern.equals("")){
        	pattern = "yyyy-MM-dd";
        }
        SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(pattern);
        return simpleDateFORMat.format(date);
    }
    /**
     * 格式化字符串为日期的函数.
     *
     * @param strDate 字符串.
     * @return 字符串包含的日期.
     */
    public static Date parseDate(String strDate) {
    	return parseDate(strDate,"yyyy-MM-dd");
    }
    /**
     * 格式化字符串为日期的函数.
     *
     * @param strDate 字符串.
     * @param pattern 格式.
     * @return 字符串包含的日期.
     */
    public static Date parseDate(String strDate,String pattern) {
            if (strDate == null || strDate.equals("")) {
                return null;
            }
            if(null == pattern || pattern.equals("")){
            	pattern = "yyyy-MM-dd";
            }
            SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(pattern);
            try {
				return simpleDateFORMat.parse(strDate);
			} catch (ParseException e) {
				throw new RuntimeException(e);
			}
    }

     /**
     * 返回某天的开始时间
     * @param date
     * @return
     */
    public static Date begin(Date date) {
       if (null == date) {
    		return null;
    	}
    	Calendar c = Calendar.getInstance();
    	c.setTime(date);
    	c.set(Calendar.HOUR_OF_DAY,0);
    	c.set(Calendar.SECOND, 0);
    	c.set(Calendar.MINUTE, 0);
    	return c.getTime();
    }
    /**
     * 返回某天的结束时间
     * @param date
     * @return
     */
    public static Date end(Date date) {
        if (null == date) {
            return null;
        }
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        c.set(Calendar.HOUR_OF_DAY, 23);
        c.set(Calendar.SECOND, 59);
        c.set(Calendar.MINUTE, 59);
        return c.getTime();
    }
}
