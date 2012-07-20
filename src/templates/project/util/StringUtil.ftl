package ${project.org}.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

/**
 *
 * User: joeytang
 * Date: ${project.currentTime}
 * 字符串处理工具类
 */
public class StringUtil extends StringUtils {
	/**
	 * 将字符串的第一个字母变成小写
	 * @param str
	 * @return
	 */
	public static String lowerFirstChar(String str){
		if(str == null ){
			return null;
		}
		str = str.trim();
		if(str.length() < 1){
			return null;
		}
		String first = str.substring(0,1);
		String rest = "";
		if(str.length() > 1){
			rest = str.substring(1);
		}
		return first.toLowerCase()+rest;
	}
	
	/**
	 * 将字符串的第一个字母变成大写
	 * @param str
	 * @return
	 */
	public static String upperFirstChar(String str){
		if(str == null ){
			return null;
		}
		str = str.trim();
		if(str.length() < 1){
			return null;
		}
		String first = str.substring(0,1);
		String rest = "";
		if(str.length() > 1){
			rest = str.substring(1);
		}
		return first.toUpperCase()+rest;
	}
	/**
     * 截取中英文混排字符串，
     * @param str 原始字符串
     * @param len 需要截取的长度，该值为字节的个数。英文一个字符占一个字节，中文一个字符占两个字节
     * @param more 如果被截取了，则加上的字符串
     * @return 根据字节数截取后的中英文混排字符串。如果在字节数的位置正好是半个中文，则将整个中文保留。并在最后加上 more指定的字符串
     * 如：“中文abc中文” 如果len=3，正常截取的为“中”+半个“文”，这里处理的结果为“中文”
	 * @throws UnsupportedEncodingException 
     */
    public static String substring(String str, int len,String more) throws UnsupportedEncodingException {
        int reInt = 0;
        String reStr = "";
        char tempChar[] = str.toCharArray();
        for (int kk = 0; kk < tempChar.length && len > reInt; kk++) {
            String s1 = String.valueOf(tempChar[kk]);
            byte b[];
			b = s1.getBytes("gbk");
			reInt += b.length;
			reStr = (new StringBuilder(String.valueOf(reStr))).append(tempChar[kk]).toString();
        }

        if (len == reInt || len == reInt - 1)
            reStr = (new StringBuilder(String.valueOf(reStr))).append(more).toString();
        return reStr;
    }
    /**
     * 计算一个字符串的字节数，英文字符一个字符占一字节，中文占两字节
     * @param str
     * @return
     * @throws UnsupportedEncodingException 
     */
    public static int byteLength(String str) throws UnsupportedEncodingException{
    	if(StringUtils.isBlank(str)){
    		return 0;
    	}
    	return str.getBytes("gbk").length;
    }
    /**
     * 在字符串每隔length字节个数位置插入ch字符
     * @param str 原始字符串
     * @param length 需要插入的位置，该值为字节的个数。英文一个字符占一个字节，中文一个字符占两个字节
     * @param ch 需要插入的字符
     * @return
     * @throws UnsupportedEncodingException 
     */
    public static String insertChar(String str,int length,String ch) throws UnsupportedEncodingException{
    	if(StringUtils.isBlank(str)){
    		return null;
    	}
    	if(length > byteLength(str)){
    		return str+ch;
    	}
    	String temp;
    	String tempStr = str;
    	StringBuffer sbuf = new StringBuffer();
    	while(byteLength(tempStr) > length){
    		temp = substring(tempStr,length,"");
    		sbuf.append(temp);
    		sbuf.append(ch);
    		tempStr = tempStr.substring(temp.length());
    	}
    	if(null != tempStr && tempStr.length() > 0){
    		sbuf.append(tempStr);
    	}
    	return sbuf.toString();
    	
    }
    private static MessageDigest digest = null;
    /**
     * md5方式编码字符串
     * @param data
     * @return
     * @throws UnsupportedEncodingException 
     * @throws NoSuchAlgorithmException 
     */
    public static final synchronized String hash(String data) throws UnsupportedEncodingException, NoSuchAlgorithmException {
        if (digest == null){
        	digest = MessageDigest.getInstance("MD5");
        }
        digest.update(data.getBytes("UTF-8"));
        return toHex(digest.digest());
    }
    public static final String toHex(byte hash[]) {
        StringBuffer buf = new StringBuffer(hash.length * 2);
        for (int i = 0; i < hash.length; i++) {
            if ((hash[i] & 0xff) < 16)
                buf.append("0");
            buf.append(Long.toString(hash[i] & 0xff, 16));
        }

        return buf.toString();
    }
	/**
	 * 计算字符串实际长度，ASCII字符算半个长度
	 * @param str
	 * @return
	 */
	public static int len(String str){
		int len = str.length();
		String s = str.replaceAll("[\\x00-\\x7f]", "");
		return (int) (len - Math.floor((len - s.length())/(double)2));
	}
	
    /**
     * 提取字符串中的所有网址
     * @param content
     * @return
     */
    public static List<String> extractUrl(String content){
    	if(isBlank(content)){
    		return null;
    	}
    	String strRegex = "(" //开始
			+"((((https|http|ftp|rtsp|mms)://)" //以http等协议+ip/域名开头 或者以www加域名开头
			+ "(([0-9]{1,3}\\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
			+ "|" // 允许IP和DOMAIN（域名）
			+ "([0-9a-z_!~*'()-]+\\.)*" // 域名- www.
            + "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\." // 二级域名
            + "[a-z]{2,6}))" // first level domain- .com or .museum
			+ "|" // 或者
			+ "((www[0-9a-z_!~*'()-]*\\.)+" // 域名- www.
			+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\." // 二级域名
			+ "[a-z]{2,6}))" // first level domain- .com or .museum
            + "(:[0-9]+)?" // 端口- :80 ,至少一个数字
            + "(/[0-9a-z_!~*'().;?:@&=+$,%#-]*)*" //地址后面跟着路径如www.baicu.com/aaa/bbb/ 这里匹配/aaa /bbb
            + "(\\?([a-zA-Z0-9\\._'\\s])+=[0-9a-z_!~*'().;:@+$,%#-]*" // 后面可以跟?开始的变量串有问号就必须至少有一个变量?a=
            + "(((&)|(&amp;))([a-zA-Z0-9\\._'\\s])+=[0-9a-z_!~*'().;:@+$,%#-]*)*" //后面的变量以&开头，并且可以0到多个
            + ")?" //地址后面的问号带的变量串结束。最多只能有一串?跟的变量
            + "/?"//可以/结束
			+")";//结束
		Pattern p = Pattern.compile(strRegex,Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(content);
		List<String> urls = null;
		boolean initialized = false;
		while(m.find()){
			if(!initialized){
				urls = new ArrayList<String>();
				initialized = true;
			}
			urls.add(m.group()); // 得到网址链接
		}
		return urls;
    }

    /**
     * 替换字符串中的子字符串，如果oldString和newString为null或者为空的话，不会进行字符串替换操作
     *
     * @param line      要进行替换操作的字符串
     * @param oldString 要被替换的字符串
     * @param newString 要被替换为的字符串
     * @return 返回替换后的字符串
     */
    public static final String replace(String line,
                                       String oldString, String newString) {
        if (line == null) return null;
        int i = 0;
        int j = 0;
        if (oldString == null || oldString.equals(""))
            return line;
        if (newString == null)
            return line;
        int oldLength = oldString.length();
        int srcLength = line.length();
        int totalLength = srcLength;
        StringBuffer sb = new StringBuffer();
        while (i < totalLength) {
            j = line.indexOf(oldString, i);
            if (j == -1) {
                sb.append(line.substring(i, srcLength));
                break;
            }
            sb.append(line.substring(i, j)).append(newString);
            i = j + oldLength;
            j = i;
        }
        return sb.toString();
    }

    /**
     * 按给定汉字长度截断字符串。两个字母或数字算一个汉字
     *
     * @param line   给定字符串
     * @param nchars 给定长度（汉字长度）
     * @param append 截断后添加到截断字符串的串，如"..."
     * @return 按给定汉字长度截断字符串并添加append字符串。
     */
    public static String chopString(String line, int nchars, String append) {
        if (line == null || line.length() <= nchars) return line;
        int n = 0;
        int max = nchars * 2;
        for (int i = 0; i < line.length(); i++) {
            char c = line.charAt(i);
            if (c > 128) n += 2;//汉字
            else n++;
            if (n >= max && i < line.length() - 1) {
                String s = line.substring(0, i + 1);
                if (append != null && append.length() > 0) s = s + append;
                return s;
            }
        }
        return line;
    }


    /**
     * 判断字符串是否和给定通配符串匹配：'*'表示任意字符任一次。
     *
     * @param s     给定字符串
     * @param regex 指定带通配符的串
     * @return 如果匹配，return true,否则 return false;
     */
    public static boolean match(String s, String regex) {
        if (s == null || regex == null) return false;
        /*
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(s);
        boolean b = m.matches();
        return b;
        */
        if (s.length() < regex.length() - 1) return false;

        int n = regex.indexOf('*');
        if (n < 0) return s.equals(regex);
        String prefix = regex.substring(0, n);
        String suffix = regex.substring(n + 1);
        return s.startsWith(prefix) && s.endsWith(suffix);

    }

    /**
     * 将字符串给定的分隔符划分成字符串数组
     *
     * @param s     待划分的字符串
     * @param delim 分隔符
     * @return 将字符串给定的分隔符划分成字符串数组，如果字符串或分隔符 == null,return null
     */
    public static String[] toGroup(String s, String delim) {
        if (s == null || delim == null) return null;
        StringTokenizer st = new StringTokenizer(s, delim);
        String[] g = new String[st.countTokens()];
        for (int i = 0; i < g.length; i++) {
            g[i] = st.nextToken();
        }
        return g;
    }

    /**
     * 将一个字符串数组碾平为一个字符串，中间加上给定的分隔符。
     *
     * @param g     字符串数组
     * @param delim 分隔符
     * @return 将一个字符串数组碾平为一个字符串，中间加上给定的分隔符。如果g==null,return null
     */
    public static String flatGroup(String[] g, String delim) {
        if (g == null) return null;
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < g.length; i++) {
            if (g[i] == null) continue;
            if (i == 0) {
                sb.append(g[i]);
            } else {
                sb.append(delim);
                sb.append(g[i]);
            }
        }
        return sb.toString();
    }

    /**
     * 将null字符串用""代替
     *
     * @param object 给定字符串,如果不是字符串，以其toString()转成字符串
     * @return 如果s==null,return "",否则，return s;
     */
    public static String chopNullString(Object object) {
        if (object == null) return "";
        return object.toString();
    }

    /**
     * 根据给定的值返回是否为真，返回空串或另一个指定的串的字符串
     *
     * @param value       是否为真的串，"Y"和"true"表示真
     * @param returnValue 希望返回的值
     * @return 如果value为真，返回 returnValue,否则返回""
     */
    public static String getBooleanValue(String value, String returnValue) {
        if ("Y".equalsIgnoreCase(value) || "true".equalsIgnoreCase(value)) {
            return returnValue;
        } else {
            return "";
        }
    }

    /**
     * 根据给定的值返回是否为真，返回空串或另一个指定的串的字符串,于getBooleanValue()相反
     *
     * @param value       是否为真的串，"Y"和"true"表示真
     * @param returnValue 希望返回的值
     * @return 如果value为真，"" ,否则返回 returnValue
     */
    public static String getBackBooleanValue(String value, String returnValue) {
        if ("Y".equalsIgnoreCase(value) || "true".equalsIgnoreCase(value)) {
            return "";
        } else {
            return returnValue;
        }
    }

    /**
     * 对字符串s中的字符，如果包含在es中，则将其转义，转义符号为echar
     * <pre>
     * 例如: escape("aaabbbbcccdddeee","bc","/")
     * 返回："aaa/b/b/b/b/c/c/cdddeee"
     * </pre>
     *
     * @param s     待转义的字符串
     * @param es    所有必须转义的字符组成的字符串
     * @param echar 转义符
     * @return s转义后的字符串
     */
    public static String escape(String s, String es, char echar) {
        if (s == null || es == null || es.length() == 0) return s;
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (es.indexOf(c) >= 0) {
                sb.append(echar).append(c);
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }

    /**
     * 字符串转义
     *
     * @param s 给定字符串
     * @return 将字符串中的引号和反斜杠转义
     */
    public static String escape(String s) {
        return escape(s, "\"\\", '\\');
    }

    /**
     * 获得给定时间的中文表示,如上午,早上,晚上
     *
     * @param cal   给定日期
     * @param hours 给定时间分割,如{5,9,11,13,18,23}
     * @param names 对于相应的时间,返回相应的名称,如{"深夜","早上","上午","中午","下午","晚上"}
     * @return 给定时间对应的中文名称,超过最后一个,也返回第一个名称
     */
    public static String getTimeName(java.util.Calendar cal, int[] hours, String[] names) {
        int hour = cal.get(java.util.Calendar.HOUR_OF_DAY);
        for (int i = 0; i < hours.length; i++) {
            if (hour < hours[i]) return names[i];
        }
        //比最后一个还大,返回第一个名称
        return names[0];
    }


    /**
     * @return hours={5,9,11,13,18,23} names={"深夜","早上","上午","中午","下午","晚上"}所对应的当前时间
     *
     */
    public static String getTimeName() {
        int[] hours = {5, 9, 11, 13, 18, 23};
        String[] names = {"深夜", "早上", "上午", "中午", "下午", "晚上"};
        return getTimeName(java.util.Calendar.getInstance(), hours, names);
    }

    /**
     * 只显示日期,不显示时间
     *
     * @param timestamp
     */
    public static String getYMDStr(Object timestamp) {
        if (timestamp == null) return "";
        else return timestamp.toString().substring(0, 10);
    }



    public static String nullStr(String Str) {

        if (Str == null || "null".equals(Str)) {
            Str = "";
        }

        return Str.trim();
    }

    public static String nullStr(String Str, String newStr) {

        if (Str == null || "null".equals(Str)) {
            Str = newStr;
        }

        return Str.trim();

    }

    public static int nullStr(String Str, int newInt) {
        int returnInt = newInt;
        try {
            if (Str == null || "null".equals(Str)) {
                return returnInt;
            }
            returnInt = Integer.parseInt(Str.trim());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    public static double nullStr(String Str, double newdou) {
        double returnDou = newdou;
        try {
            if (Str == null || "null".equals(Str)) {
                return returnDou;
            }
            returnDou = Double.parseDouble(Str.trim());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnDou;
    }

    public static double nullStr(String Str, float newfloat) {
        float returnFlt = newfloat;
        try {
            if (Str == null || "null".equals(Str)) {
                return returnFlt;
            }
            returnFlt = Float.parseFloat(Str.trim());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnFlt;
    }

    public static float nullStrFloat(String Str, float newfloat) {
        float returnFlt = newfloat;
        try {
            if (Str == null || "null".equals(Str)) {
                return returnFlt;
            }
            returnFlt = Float.parseFloat(Str.trim());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnFlt;
    }

    public static String getValueStr(String[] values) {
        if (values != null && values.length > 0) {
            String temp = "";
            for (int i = 0; i < values.length; i++) {
                if (temp.length() == 0) {
                    temp = values[i];
                } else {
                    temp += "," + values[i];
                }
            }
            return temp;
        } else {
            return "";
        }
    }

    /**
     * 在jsp中让输出的字符串按照wordCount的大小自动换行；
     *
     * @param str
     * @param wordCount
     * @return string
     */
    public static String converString(String str, int wordCount) {
        if (str == null || str.equals("")) {
            return "";
        }
        StringBuffer tempstr = new StringBuffer();
        int j = str.length() / wordCount;
        if (str.length() % wordCount > 0) {
            j += 1;
        }

        for (int i = 0; i < j; i++) {
            if (i == j - 1) {
                tempstr.append(str.substring(i * wordCount, str.length()));
            } else
            	tempstr.append(str.substring(i * wordCount, i * wordCount + wordCount) + "<br>");
        }
        return tempstr.toString();
    }
}

