package com.wanmei.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

 /**
 * User: joeytang
 * Date: 2012-03-20 18:17
 * 内容管理工具类
 */
public class ContentUtils {
	
	 // 超过了长度后缀
    public static final String STRING_TOO_LONG_SUFFIX = "...";

    public static String getSubString(String content, Integer len) {
    	len = (null == len || len < 1?20:len);
        return truncateRecord(content, len.intValue());
    }

    /**
     * 带链接和图片的字符串截取
     *
     * @param content
     * @param len     字符长度
     * @return
     */
    public static String truncateRecord(String content, int len) {

        if (null == content || content.trim().length() == 0)
            return "";

        String pattern = "<a [^<>]*>([^<>]*)</a>|<img [^<>]*/>|[^<>]*";
        Pattern p = Pattern.compile(pattern);
        Matcher m = p.matcher(content);
        StringBuffer sb = new StringBuffer();
        int realLen = 0;
        while (m.find()) {

            if (realLen > len) {
                break;
            }
            String match = m.group(1);
            if (null != match) {
                // 匹配了链接
                int matchLen = match.length();

                if (realLen + matchLen > len) {

                    String tructateMatch = match.substring(0, len - realLen) + STRING_TOO_LONG_SUFFIX;

                    m.appendReplacement(sb, tructateMatch);
                } else {
                    sb.append(m.group(0));
                    realLen += matchLen;
                }

            } else {
                // 匹配了图片或普通文本
                String content2 = m.group(0);
                String pattern2 = "<a [^<>]*>[^<>]*</a>|<img [^<>]*/>";
                Pattern p2 = Pattern.compile(pattern2);
                Matcher m2 = p2.matcher(content2);
                if (!m2.find()) {
                    // 匹配了普通文本
                    int m2Len = content2.length();
                    if (realLen + m2Len > len) {
                        String truncateM2 = content2.substring(0, len - realLen) + STRING_TOO_LONG_SUFFIX;
                        sb.append(truncateM2);
                        break;
                    } else {
                        sb.append(content2);
                        realLen += m2Len;
                    }
                } else {
                    // 匹配了图片，默认图片占2个字符的大小
                    sb.append(content2);
                    realLen += 2;
                }
            }
        }

        return sb.toString();
    }
    public static void main(String[] args) {

        /*
          String content = "sdfsdf[共匪]fsd温秀秀完美国际df";
          Map<String, String> map = new HashMap<String, String>();
          map.put("完美", "http://wm.htm");
          map.put("完美国际", "http://wi.htm");
          map.put("赤壁", "http://cb.htm");

          String keywords = "完美世界|完美国际|赤壁";
          Pattern p = Pattern.compile(keywords);
          Matcher m = p.matcher(content);

          StringBuffer sb = new StringBuffer();
          while(m.find()){
              String keyword = m.group(0);
              String url = map.get(keyword);
              if(null != url && url.trim().length() > 0)
                  m.appendReplacement(sb, "<a href='" + url + "' target='_blank'>" + keyword +"</a>");
          }
          m.appendTail(sb);

          System.out.println(sb.toString());
          */

        // 测试截取
        //String content = "是打发士大夫<a href='http://wanmei.com' target='_blank'>完美世界</a><img src='/images/emotion/huli/13.gif' width='20' height='20'/>sdfsdf<img src='/images/emotion/huli/27.gif' width='20' height='20'/>sdf<a href='http://wanmei.com' target='_blank'>sd</a>士大夫";
       // String content = "设定发撒旦发生地方是大方撒旦发生地方说的是打发士大夫士大夫是打发士大夫是";
       // int len = 25;


//        System.out.println(truncateRecord(content, len));
		
	}
}
