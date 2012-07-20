package ${project.org}.common.action.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * struts日期转换
 */
public class DateConverter extends StrutsTypeConverter {

	private final static String DATE_TIME_FOMART = "yyyy-MM-dd HH:mm:ss";

	private final static String DATE_FOMART = "yyyy-MM-dd";

	@SuppressWarnings("rawtypes")
	@Override
	public Object convertFromString(Map context, String[] values, Class toClass) {

		Date date = null;

		String dateString = null;

		if (values != null && values.length > 0) {

			dateString = values[0];

			if (dateString != null) {

//				SimpleDateFormat format = new SimpleDateFormat(DATE_FOMART);
//
//				try {
//
//					date = format.parse(dateString);
//
//				} catch (ParseException e) {
//
//					date = null;
//
//				}

				if (date == null) {
					SimpleDateFormat format = new SimpleDateFormat(DATE_TIME_FOMART);
//					SimpleDateFormat format = new SimpleDateFormat(DATE_FOMART);

					try {

						date = format.parse(dateString);

					} catch (ParseException e) {
						try{
							format = new SimpleDateFormat(DATE_FOMART);
							date = format.parse(dateString);
						}catch (ParseException e1){
							date = null;
						}
					}
				}

			}

		}

		return date;

	}

	@SuppressWarnings("rawtypes")
	@Override
	public String convertToString(Map arg0, Object arg1) {

		if(arg1 instanceof Date){
//			SimpleDateFormat format = new SimpleDateFormat(DATE_FOMART);
			SimpleDateFormat format = new SimpleDateFormat(DATE_TIME_FOMART);
			return format.format(arg1);
		}
		if(null == arg1){
			return null;
		}else{
			return arg1.toString();
		}

	}

}
