/*
 * $Id: Property.java 497654 2007-01-19 00:21:57Z rgielen $
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package ${project.org}.tool.tags.component;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.commons.lang.xwork.StringEscapeUtils;
import org.apache.struts2.components.Component;
import org.apache.struts2.views.annotations.StrutsTag;
import org.apache.struts2.views.annotations.StrutsTagAttribute;

import com.opensymphony.xwork2.util.ValueStack;

import ${project.org}.util.StringUtil;
/**
 * User:joeytang
 * Date: ${project.currentTime}
 * struts实现的截取字符串标签实现
 */
 
@StrutsTag(name="substring", tldBodyContent="empty", tldTagClass="org.apache.struts2.views.jsp.PropertyTag",
    description="Print out expression which evaluates against the stack")
public class SubString extends Component {
    private static final Log LOG = LogFactory.getLog(SubString.class);

    public SubString(ValueStack stack) {
        super(stack);
    }

    private String defaultValue;
    private String value;
    private String tail;
    private Integer length ;
    private Integer rowLength ;
    private Integer rowCount ;
    private boolean escape = true;

    @StrutsTagAttribute(description="The default value to be used if <u>value</u> attribute is null")
    public void setDefault(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    @StrutsTagAttribute(description=" Whether to escape HTML", type="Boolean", defaultValue="true")
    public void setEscape(boolean escape) {
        this.escape = escape;
    }

    @StrutsTagAttribute(description="Value to be displayed", type="Object", defaultValue="&lt;top of stack&gt;")
    public void setValue(String value) {
        this.value = value;
    }
    
	public void setTail(String tail) {
		this.tail = tail;
	}
	
	public void setLength(Integer length) {
		this.length = length;
	}

	public Integer getLength() {
		return length;
	}

	public Integer getRowLength() {
		return rowLength;
	}

	public void setRowLength(Integer rowLength) {
		this.rowLength = rowLength;
	}

	public Integer getRowCount() {
		return rowCount;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}

	public boolean start(Writer writer) {
        boolean result = super.start(writer);

        String actualValue = null;

        if (value == null) {
            value = "top";
        }
        else if (altSyntax()) {
            // the same logic as with findValue(String)
            // if value start with %{ and end with }, just cut it off!
            if (value.startsWith("%{") && value.endsWith("}")) {
                value = value.substring(2, value.length() - 1);
            }
        }

        // exception: don't call findString(), since we don't want the
        //            expression parsed in this one case. it really
        //            doesn't make sense, in fact.
        actualValue = (String) getStack().findValue(value, String.class);

        
        try {
            if (actualValue != null) {
//            	actualValue = actualValue.replaceAll("\r\n", "<br/>");
            	actualValue = prepare(actualValue);
            	actualValue = actualValue.trim();
            	actualValue = StringUtil.trimChar(actualValue,"\n");
            	if(StringUtils.isBlank(actualValue)){
            		writer.write(actualValue);
            		return result;
            	}
            	actualValue = actualValue.replaceAll("\t", "    ");
            	
            	if(null != rowLength && 0 != rowLength.intValue()){
            		String[] strs = actualValue.split("\r\n");
            		List<String> rList = new ArrayList<String>();
            		String ts = "";
            		for(String s:strs){
            			while(StringUtil.byteLength(s) > rowLength*2){
        					ts = StringUtil.substring(s, rowLength*2, "");
        					s = s.substring(ts.length());
        					rList.add(ts+"<br/>");
        				}
            			if(!StringUtils.isBlank(s)){
            				rList.add(s+"<br/>");
            			}
            		}
            		if(null != rowCount && 0 != rowCount.intValue()){
            			if(rList.size() > rowCount){
            				String lastList = rList.get(rowCount);
            				if(StringUtil.byteLength(lastList) + 3 < rowLength * 2){
            					lastList += "...";
            				}
            				rList = rList.subList(0,rowCount);
            				rList.add(lastList);
            			}
            		}
            		StringBuffer sb = new StringBuffer();
            		for(String s:rList){
            			sb.append(s);
            		}
            		actualValue = sb.toString();
            		actualValue = StringUtil.trimChar(actualValue,"<br/>");
            	}
            	if(null != length && 0 != length.intValue() && StringUtil.byteLength(actualValue) > length*2 ){
            		actualValue = StringUtil.substring(actualValue ,length*2,tail);
            	}
//            	if(null != rowLength && 0 != rowLength.intValue()){
//            		if(null != rowCount && 0 != rowCount){
//            			int tempRC = 0;
//            			int t = 0;
//            			StringBuffer sb = new StringBuffer();
//            			char[] chars = actualValue.toCharArray();
//            			int i = 0;
//            			for(;i<chars.length;i++){
//            				t += String.valueOf(chars[i]).getBytes().length;
//            				sb.append(chars[i]);
//            				if(t != 0 && t%(rowLength * 2) == 0){
//            					tempRC ++;
//            				}
//            				if(tempRC >= rowCount){
//            					if(sb.toString().endsWith("..")){
//            						actualValue = sb.toString()+".";
//            					}else if(sb.toString().endsWith(".")){
//            						actualValue = sb.toString()+"..";
//            					}else{
//            						if(i < chars.length -1){
//            							actualValue = sb.toString()+"...";
//            						}else{
//            							actualValue = sb.toString();
//            						}
//            					}
//            					break;
//            				}
//            			}
//            			String[] strs = actualValue.split("\n");
//            			if(null != strs && strs.length > 1){
//            				for(int i = 0;i<strs.length;i++){
//            					tempRC++;
//            					t = StringUtil.byteLength(strs[i])/(rowLength * 2);
//            					tempRC += t;
//            					tempRC += (StringUtil.byteLength(strs[i])%(rowLength * 2) > 0?0:-1);
//            					if(tempRC+1 >= rowCount ){
//            						if(t > 0){
//            							sb.append(StringUtil.substring(strs[i],t*2*rowLength));
//            						}else{
//            							sb.append(strs[i]);
//            						}
//            						if(i < strs.length -1){
//            							sb.append("...");
//            						}
//            						break;
//            					}else{
//            						sb.append(strs[i] + "\n");
//            					}
//            				}
//            			}
            			
//            		}
//        			while(actualValue.indexOf("\n") != -1 && StringUtil.byteLength(actualValue) > rowLength * 2){
//        				actualValue = StringUtil.substring(actualValue ,StringUtil.byteLength(actualValue) - rowLength * 2,"");
//        			}
        			
//        			actualValue = StringUtil.insertChar(actualValue, rowLength*2, " ");
//        		}
            	writer.write(actualValue);
            } else if (defaultValue != null) {
                writer.write(prepare(defaultValue));
            }
        } catch (IOException e) {
            LOG.info("Could not print out value '" + value + "'", e);
        }

        return result;
    }

    private String prepare(String value) {
        if (escape) {
            return StringEscapeUtils.escapeHtml(value);
        } else {
            return value;
        }
    }
}
