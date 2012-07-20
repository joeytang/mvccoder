package com.wanmei.common.controller;

import java.beans.PropertyEditorSupport;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.lang.StringUtils;


public class MyDateConverter extends PropertyEditorSupport{
	public MyDateConverter( ) {
	}



	/**
	 * Parse the Date from the given text, using the specified DateFormat.
	 */
	@Override
	public void setAsText(String text) throws IllegalArgumentException {
		setValue(parseDate(text));
	}

	/**
	 * Format the Date as String, using the specified DateFormat.
	 */
	@Override
	public String getAsText() {
		Date value = (Date) getValue();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:dd");
		return (value != null ? dateFormat.format(value) : "");
	}
	private Date parseDate(String dateStr) throws IllegalArgumentException{
		Date d = null;
		String pattern = getParttern(dateStr);
		if(StringUtils.isBlank(pattern)){
			return null;
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat(pattern);
		try {
			d = dateFormat.parse(dateStr);
		} catch (ParseException e) {
			throw new IllegalArgumentException("parse date error:"+dateStr);
		}
		return d;
	}
	private String getParttern(String dateStr){
		if(StringUtils.isBlank(dateStr)){
			return null;
		}
		switch(dateStr.length()){
		case 4:
			return "yyyy";
		case 7:
			return "yyyy-MM";
		case 10:
			return "yyyy-MM-dd";
		case 13:
			return "yyyy-MM-dd HH";
		case 16:
			return "yyyy-MM-dd HH:mm";
		case 19:
			return "yyyy-MM-dd HH:mm:dd";
		}
		return null;
	}
}
