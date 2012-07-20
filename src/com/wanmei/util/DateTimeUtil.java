package com.wanmei.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
/**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 时间处理工具类
 */
public class DateTimeUtil {

    public DateTimeUtil() {
    }

    public static Date addDay(Date date, int nDay) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(5, nDay);
        Date result = cal.getTime();
        return result;
    }

    public static Date addHours(Date date, int hours) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.HOUR, hours);
        Date result = cal.getTime();
        return result;
    }

    public static String dateToStr(Date date) {
        return timeFormatter.format(date);
    }

    public static String dateToStr(Date date, String format) {
        SimpleDateFormat formatter = new SimpleDateFormat(format);
        return formatter.format(date);
    }

    public static Date strToDate(String strDate, String format) {
        Date date = null;
        SimpleDateFormat dateFormatter = new SimpleDateFormat(format);
        try {
            date = dateFormatter.parse(strDate);
        } catch (Exception ignored) {
            ignored.printStackTrace();
        }
        return date;
    }

    public static Date strToDate(String strDate) {
        Date date = null;
        try {
            date = timeFormatter.parse(strDate);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return date;
    }

    public static Timestamp dateToTimestamp(Date date) {
        return new Timestamp(date.getTime());
    }

    public static final String zeroPadString(String string, int length) {
        if (string == null || string.length() > length) {
            return string;
        } else {
            StringBuffer buf = new StringBuffer(length);
            buf.append(ZERO_ARRAY, 0, length - string.length()).append(string);
            return buf.toString();
        }
    }

    public static final String dateToMillis(Date date) {
        return zeroPadString(Long.toString(date.getTime()), 15);
    }

    private static SimpleDateFormat timeFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    private static final char ZERO_ARRAY[] = "0000000000000000".toCharArray();


    public static String getDateString(Date date) {
        return getDateString(date, "yyyy-MM-dd");
    }

    public static String getDateString(Date date, String format) {
        java.text.SimpleDateFormat bartDateFormat = new java.text.SimpleDateFormat(format);
        String dateString = bartDateFormat.format(date);
        return dateString;
    }


    public static boolean isDate(String str) {
        String regex = "^[0-9]{4}\\-[0-9]{1,2}\\-[0-9]{1,2}$";
        return str.matches(regex);
    }

    public static boolean isTime(String str) {
        String regex = "^[0-9]{2}:[0-9]{1,2}:[0-9]{1,2}$";
        return str.matches(regex);
    }

    public static boolean isDateTime(String str) {
        String regex = "^[0-9]{4}\\-[0-9]{1,2}\\-[0-9]{1,2} [0-9]{2}:[0-9]{1,2}$";
        return str.matches(regex);
    }

    public static Date parseDateTime(String dateString) {
        return parseDateTime(dateString, "yyyy-MM-dd HH:mm:ss");
    }

    public static Date parseDateTime(String dateString, String format) {
        DateFormat dateFormat = new SimpleDateFormat(format);

        Date date = null;

        try {
            date = dateFormat.parse(dateString);
        } catch (ParseException ignored) {
            ignored.printStackTrace();
        }

        return date;
    }

    public static int getCreatetime(Date date, Date enddate) {
        int f = 0;
        try {
            if (date.getTime() > enddate.getTime()) {
                return 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public static int getDays(String BeginDate, String EndDate) {

        int days = 0;//2005-02-23
        if (BeginDate.length() < 10 || EndDate.length() < 10) {
            return 0;
        }

        int beginyear = Integer.parseInt(BeginDate.substring(0, 4));
        int beginmonth = Integer.parseInt(BeginDate.substring(5, 7));
        int begindate = Integer.parseInt(BeginDate.substring(8, 10));
        int begindays = 0;
        //System.out.println("beginyear:"+beginyear+" beginmonth:"+beginmonth+" begindate:"+begindate);

        int endyear = Integer.parseInt(EndDate.substring(0, 4));
        int endmonth = Integer.parseInt(EndDate.substring(5, 7));
        int enddate = Integer.parseInt(EndDate.substring(8, 10));
        int enddays = 0;
        //System.out.println("endyear:"+endyear+" endmonth:"+endmonth+" enddate:"+enddate);


        Calendar begincal = new GregorianCalendar();
        begincal.set(beginyear, beginmonth - 1, begindate);
        begindays = begincal.get(Calendar.DAY_OF_YEAR);

        Calendar endcal = new GregorianCalendar();
        endcal.set(endyear, endmonth - 1, enddate);
        enddays = endcal.get(Calendar.DAY_OF_YEAR);
        //System.out.println("enddays-begindays:"+enddays+"-"+begindays);
        days = (endyear - beginyear) * 365 + (enddays - begindays);
        return days;
    }
    public static final String YYYYMMDDHHMMSS = "yyyy-MM-dd HH:mm:ss";
    public static final String YYYYMMDD = "yyyy-MM-dd";
    public static final String YYYYMMDDS = "yyyyMMdd";
    public static final String YYYYMM = "yyyyMM";

    /**
     * 数字转换日期
     *
     * @param lDate long/1000的数据
     * @return Date
     */
    public static Date numberToDate(Long lDate) {
        if (null == lDate) {
            return null;
        }
        Date date = new Date();
        date.setTime(lDate.longValue() * ((long) 1000));
        return date;

    }

    /**
     * 格式化日期为字符串函数.
     *
     * @param date 日期.
     * @return 日期转化来的字符串.
     */
    public static String forMatDate(Date date) {
        if (date == null) {
            return "";
        }
        SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(YYYYMMDDHHMMSS);

        return simpleDateFORMat.format(date);

    }


    public static String forMatDateYMD(Date date) {
        if (date == null) {
            return "";
        }
        SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(YYYYMMDD);

        return simpleDateFORMat.format(date);

    }

    public static String forMatDateYMDS(Date date) {
        if (date == null) {
            return "";
        }
        SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(YYYYMMDDS);

        return simpleDateFORMat.format(date);

    }

    public static String forMatDateYM(Date date) {
        if (date == null) {
            return "";
        }
        SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(YYYYMM);

        return simpleDateFORMat.format(date);

    }

    /**
     * 返回字符串数字
     *
     * @param date 日期
     * @return long
     */
    public static Long dateForMat(Date date) {
        if (null == date) {
            return null;
        }
        return new Long(date.getTime() / 1000);
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

    /**
     * 格式化字符串为日期的函数.
     *
     * @param strDate 字符串.
     * @return 字符串包含的日期.
     */
    public static Date parseDate(String strDate) {

        try {

            if (strDate == null || strDate.equals("")) {

                return null;
            }

            SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(YYYYMMDDHHMMSS);

            return simpleDateFORMat.parse(strDate);

        }

        catch (Exception ignored) {
           ignored.printStackTrace();
        }
        return null;

    }

    /**
     * 格式化字符串为日期的函数.
     *
     * @param strDate 字符串.
     * @return 字符串包含的日期.
     */
    public static Date parseDateYMD(String strDate) {

        try {

            if (strDate == null || strDate.equals("")) {

                return null;
            }

            SimpleDateFormat simpleDateFORMat = new SimpleDateFormat(YYYYMMDD);

            return simpleDateFORMat.parse(strDate);

        }

        catch (Exception ignored) {
          ignored.printStackTrace();
        }
        return null;

    }

    @SuppressWarnings("deprecation")
    public static Long beginDate(long date) {
        Date ndate;
        if (0 != date) {
            ndate = numberToDate(date);
        } else {
            ndate = new Date();
        }
        ndate.setHours(0);
        ndate.setSeconds(0);
        ndate.setMinutes(0);
//        ndate.setDate(ndate.getDate() - 1);
        return ndate.getTime() / 1000;
    }

    @SuppressWarnings("deprecation")
    public static Long endDate(long date) {
        Date ndate;
        if (0 != date) {
            ndate = numberToDate(date);

        } else {
            ndate = new Date();
        }
        ndate.setHours(0);
        ndate.setSeconds(0);
        ndate.setMinutes(0);
        ndate.setDate(ndate.getDate() + 1);
        return ndate.getTime() / 1000;
    }

    public static String cha(Date date1, Date date2) {
        StringBuffer str = new StringBuffer();
        if (null != date1 && null != date2 && date2.getTime() > date1.getTime()) {
            long cha = (date2.getTime() - date1.getTime()) / 1000;
            int hor = (int) cha / 3600;
            if (0 != hor) {
                str.append(hor).append("小时");
            }
            int secd = (int) cha % 3600 / 60;
            if (0 != secd) {
                str.append(secd).append("分");
            }
            int miao = (int) cha % 60;
            if (0 != miao) {
                str.append(miao).append("秒");
            }
        }
        return str.toString();
    }

    

    @SuppressWarnings("deprecation")
    public static Date endDates(Date date) {
        if (null == date) {
            return null;
        }
        date.setDate(date.getDate() + 3);
        return date;
    }
}
