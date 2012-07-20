package com.wanmei.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * @author
 * @EMail:
 * @version
 */
public class DateUtil {
	/**
	 * 将字符串转换为yyyy-MM-dd格式的日期
	 * @param date
	 * @return
	 */
	public static Date strToDate(String date) {
		if (date == null)
			return null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date aa = sdf.parse(date, new ParsePosition(0));
		return aa;
	}
	/**
	 * 将date型日期转换成特定格式的时间字符串
	 * @param date
	 * @param format
	 * @return
	 */
	public static String toDateStr(Date date, String format ) {
		if (date == null)
			return null;
		SimpleDateFormat sdf = new SimpleDateFormat( format );
		return sdf.format(date);
	}
	
	/**
	 * 将date型日期转换成yyyy-MM-dd HH:mm格式的时间字符串
	 * @param date 日期
	 * @return 返回yyyy-MM-dd HH:mm格式的时间字符串
	 */
	public static String toDateTimeStr(Date date) {
		if (date == null)
			return null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		return sdf.format(date);
	}
	
	/**
	 * 将date型日期转换成yyyy-MM-dd格式的日期字符串
	 * @param date 日期
	 * @return 返回yyyy-MM-dd格式的日期字符串
	 */
	public static String toDateStr(Date date) {
		if (date == null)
			return null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}
	
	/**
	 * 计算出date day天之前或之后的日期
	 * @param date 日期
	 * @param date 天数，正数为向后几天，负数为向前几天
	 * @return 返回Date日期类型
	 */
	public static Date getDateBeforeOrAfterDays(Date date, int days) {   
		Calendar now = Calendar.getInstance();   
		now.setTime(date);   
		now.set(Calendar.DATE, now.get(Calendar.DATE) + days);   
		return now.getTime();   
	}   
	/**
	 * 计算出date monthes月之前或之后的日期
	 * @param date 日期
	 * @param monthes 月数，正数为向后几天，负数为向前几天
	 * @return 返回Date日期类型
	 */
	public static Date getDateBeforeOrAfterMonthes(Date date, int monthes) {   
		Calendar now = Calendar.getInstance();   
		now.setTime(date);   
		now.set(Calendar.MONTH, now.get(Calendar.MONTH) + monthes);   
		return now.getTime();   
	} 
	/**
	 * 计算出date years年之前或之后的日期
	 * @param date 日期
	 * @param years 年数，正数为向后几天，负数为向前几天
	 * @return 返回Date日期类型
	 */
	public static Date getDateBeforeOrAfterYears(Date date, int years) {   
        Calendar now = Calendar.getInstance();   
        now.setTime(date);   
        now.set(Calendar.YEAR, now.get(Calendar.YEAR) + years);   
        return now.getTime();   
    }   

	/**  
     * 计算两个日期之间的天数
     * @param beginDate  
     * @param endDate  
     * @return  如果beginDate 在 endDate之后返回负数 ，反之返回正数
     */  
    public static int daysOfTwoDate(Date beginDate,Date endDate){   
       
        Calendar beginCalendar = Calendar.getInstance();   
        Calendar endCalendar = Calendar.getInstance();   
          
        beginCalendar.setTime(beginDate);   
        endCalendar.setTime(endDate);   

        return getDaysBetween(beginCalendar,endCalendar);	
      
    } 
    
	/**  
     * 计算两个日期之间的天数
     * @param d1  
     * @param d2  
     * @return  如果d1 在 d2 之后返回负数 ，反之返回正数
     */ 
    public static int getDaysBetween(Calendar d1, Calendar d2) {

    	int days = 0;
    	int years = d1.get(Calendar.YEAR) - d2.get(Calendar.YEAR);
    	if( years == 0 )
    	{
    		 days = d2.get(Calendar.DAY_OF_YEAR) - d1.get(Calendar.DAY_OF_YEAR);
    		 return days;
    	}else if( years > 0)
    		  {
    			 	for(int i=0; i<years ;i++)
    			 	{
    			 		d2.add(Calendar.YEAR, 1);
    			 		days += -d2.getActualMaximum(Calendar.DAY_OF_YEAR);
    			 		if(d1.get(Calendar.YEAR) == d2.get(Calendar.YEAR))
    			 		{
    			 			days += d2.get(Calendar.DAY_OF_YEAR) - d1.get(Calendar.DAY_OF_YEAR);
    			 			return days;
    			 		}
    			 	}
    		   }else 
    		    {
    			   
    			   for(int i=0; i<-years ;i++)
   			 		{
   			 		d1.add(Calendar.YEAR, 1);
   			 		days += d1.getActualMaximum(Calendar.DAY_OF_YEAR);
   			 		if(d1.get(Calendar.YEAR) == d2.get(Calendar.YEAR))
   			 		{
   			 			days += d2.get(Calendar.DAY_OF_YEAR) - d1.get(Calendar.DAY_OF_YEAR);
   			 			return days;
   			 		}
   			 	}
    			   
    		    }
    		
    		
    	return days;
    	 

    	}

    
    /**
     * 获得当前时间当天的开始时间，即当前给出的时间那一天的0时0分0秒的时间
     * @param date 当前给出的时间
     * @return
     */
    public static Date getDateBegin(Date date){
    	SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyy-MM-dd");
    	if(date!=null)
    	{
        	try {
    			return  DateFormat.getDateInstance(DateFormat.DEFAULT,Locale.CHINA).parse(ymdFormat.format(date));
    		} catch (ParseException e) {
    			e.printStackTrace();
    		}    		
    	}

		return null;
    }

    public static Date getDateEnd(Date date)
    {
    	SimpleDateFormat ymdFormat = new SimpleDateFormat("yyyy-MM-dd");
    	if(date!=null)
    	{
        	try 
        	{
        		date = getDateBeforeOrAfterDays(date,1);
    			date = DateFormat.getDateInstance(DateFormat.DEFAULT,Locale.CHINA).parse(ymdFormat.format(date));
    			Date endDate = new Date();
    			endDate.setTime(date.getTime()-1000);
    			
    			return endDate;
    		} catch (ParseException e) {
    			e.printStackTrace();
    		}    		
    	}

		return null;
    }
	public static void main(String args[])
	{
		System.out.println(getDateBegin(new Date()));
		System.out.println(getDateEnd(new Date()));
		System.out.println(getDateBeforeOrAfterMonthes(new Date(),-1));
	}
    

}
