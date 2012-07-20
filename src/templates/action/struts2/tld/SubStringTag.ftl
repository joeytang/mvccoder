/*
 * $Id: PropertyTag.java 471756 2006-11-06 15:01:43Z husted $
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
package ${project.org}.tool.tags;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;
import org.apache.struts2.views.jsp.ComponentTagSupport;

import com.opensymphony.xwork2.util.ValueStack;

import ${project.org}.tool.tags.component.SubString;


/**
 * User:joeytang
 * Date: ${project.currentTime}
 * struts实现的截取字符串标签
 */
public class SubStringTag extends ComponentTagSupport {

    private static final long serialVersionUID = 435308349113743852L;

    private String defaultValue;
    private String value;
    private String tail = "...";
    private Integer length ;
    private Integer rowLength ;
    private Integer rowCount ;
    private boolean escape = true;

    public Component getBean(ValueStack stack, HttpServletRequest req, HttpServletResponse res) {
        return new SubString(stack);
    }

    protected void populateParams() {
        super.populateParams();

        SubString tag = (SubString) component;
        tag.setDefault(defaultValue);
        tag.setValue(value);
        tag.setLength(length);
        tag.setRowLength(rowLength);
        tag.setRowCount(rowCount);
        tag.setEscape(escape);
        tag.setTail(tail);
    }

    public void setDefault(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public void setEscape(boolean escape) {
        this.escape = escape;
    }

    public void setValue(String value) {
        this.value = value;
    }

	public void setLength(Integer length) {
		this.length = length;
	}

	public void setRowLength(Integer rowLength) {
		this.rowLength = rowLength;
	}

	public void setRowCount(Integer rowCount) {
		this.rowCount = rowCount;
	}
	
	public void setTail(String tail) {
		this.tail = tail;
	}
}
