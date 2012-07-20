package com.wanmei.tool.paging;

/**
 * User: joeytang
 * Date: 2012-03-23 14:32
 * 公共的列表，主要适用于查询数据库时，返回结果要分页处理
 * 使用方法：
 * 1、modelMap.put("commonList", new CommonList(mcount,commonList.pageNo,commonList.pageSize));
 * 2、commonList.calculate(mcount,commonList.pageNo,commonList.pageSize);
 * 3、commonList.calculate();
 * 4、 url.append("&guildid=").append(this.guildid);this.commonList = new CommonList(url.toString(), this.size, this.pages, this.pagesize);
 */
public class CommonList {
	
	/**
     * 默认页大小
     */
	public static final int DEFAULT_PAGE_SIZE = 10;
//    public static final int DEFAULT_PAGE_SIZE = 2;
    
    /**
     * 当前页数
     */
    public int pageNo = 1;

    /**
     * 每页显示记录数，当其值小于0时。应该是返回所有记录
     */
    public int pageSize = DEFAULT_PAGE_SIZE;

    /**
     * 总页数
     */
    public int pageNum = 1;

    /**
     * 总纪录数
     */
    public int recNum;

    /**
     * 开始记录数
     */
    public int startPos;

    /**
     * 结束记录数
     */
    public int endPos;

    /**
     * ajax uri
     */
    public String uri;
    
    public String target;
    

    /**
     * 该属性仅供基于Struts框架使用
     */
    public static final String COMMONLIST_TAG_KEY = "commonlist_tag_key";


    // 记录查询条件组成的字符串；
    public String searchStr = "";

    /**
     * @param recNum   总纪录数
     * @param pageNo   当前页
     * @param pageSize 页大小
     */
    public CommonList(int recNum, int pageNo, int pageSize) {
//        super(pageSize > 0 ? pageSize : DEFAULT_PAGE_SIZE);
    	pageSize = pageSize > 0 ?pageSize:DEFAULT_PAGE_SIZE;
        calculate(recNum, pageNo, pageSize);
    }


    /**
     * @param searchStr 搜索条件组成的字符串，形式如："&name=abc&id=4"
     * @param recNum    总纪录数
     * @param pageNo    当前页
     * @param pageSize  页大小
     */
    public CommonList(String searchStr, int recNum, int pageNo, int pageSize) {
//        super(pageSize > 0 ? pageSize : DEFAULT_PAGE_SIZE);
    	pageSize = pageSize > 0 ?pageSize:DEFAULT_PAGE_SIZE;
        this.searchStr = searchStr;
        calculate(recNum, pageNo, pageSize);
    }


    /**
     * @param pageNo   返回的当前页
     * @param pageSize 返回的当前
     */
    public CommonList(int pageNo, int pageSize) {
//        super(pageSize > 0 ? pageSize : DEFAULT_PAGE_SIZE);
    	pageSize = pageSize > 0 ?pageSize:DEFAULT_PAGE_SIZE;
        if (pageNo < 0) {
            //---------------------------------
            // 定义返回结果，初始化一个空的String
            //---------------------------------
            pageNo = 0;
        }
        this.pageNo = pageNo;
        this.pageSize = pageSize;
    }

    /**
     * 默认构造方法<br>
     * --------------------------------------------------------------------------<br>
     */
    public CommonList() {
//        super(DEFAULT_PAGE_SIZE);
    	pageSize = DEFAULT_PAGE_SIZE;
    }


    /**
     * 通过已知属性和总记录数，计算其它属性<br>
     *
     * @param recNum 总纪录数
     */
    public void calculate(int recNum) {
        calculate(recNum,
                pageNo,
                pageSize);
    }

    /**
     * 通过总记录数、当前页、每页记录数，计算其它属性<br>
     * --------------------------------------------------------------------------<br>
     *
     * @param recNum   总纪录数
     * @param pageNo   当前页
     * @param pageSize 页大小
     */
    public void calculate(int recNum, int pageNo, int pageSize) {
        //---------------------------------
        // 总记录数小于1没有任何任何计算意义。
        //---------------------------------
        if (recNum < 1) return;

        //---------------------------------
        // 页大小为0的时候，无意义
        //---------------------------------
        if (pageSize == 0) {
            pageSize = DEFAULT_PAGE_SIZE;
        }

        //---------------------------------
        // 当前页小于1的时候。默认为第1页
        //---------------------------------
        if (pageNo < 1) pageNo = 1;
        this.pageNo = pageNo;
        this.pageSize = pageSize;
        this.recNum = recNum;

        if (pageSize > 0) {
            //---------------------------------
            // 总页数=总记录/页大小，不能整除就要进一位
            //---------------------------------
            if (recNum % pageSize > 0)
                pageNum = recNum / pageSize + 1;
            else
                pageNum = recNum / pageSize;

            //---------------------------------
            // 当前页不能大于总页数。
            //---------------------------------
            if (pageNo > pageNum) this.pageNo = pageNum;
            if (this.pageNo < 1) this.pageNo = 1;

            //---------------------------------
            // 计算数据库记录的开始处和结束处。
            //---------------------------------
            startPos = (this.pageNo - 1) * pageSize + 1;
            endPos = this.pageNo * pageSize;
        } else {
            //---------------------------------
            // 页大小小于0的时候，应该是所有记录数
            //---------------------------------
            startPos = 0;
            endPos = recNum;
        }
    }

    /**
     * 显示分页标志<br>
     * 请参照：
     * getPage(CommonList,int,String)方法<br>
     *
     * @param cl 列表
     * @return 结果
     */
    public static String getPage(CommonList cl) {
        return getPage(cl,
                10,
                null);
    }

    /**
     * 显示分页标志<br>
     * 请参照：
     * getPage(CommonList,int,String)方法<br>
     * --------------------------------------------------------------------------<br>
     *
     * @param cl      列表
     * @param pageNum 显示的数目
     * @return 结果
     */
    public static String getPage(CommonList cl, int pageNum) {
        return getPage(cl,
                pageNum,
                null);
    }

    /**
     * 显示分页标志<br>
     * 显示分页标志，此方法产生的结果要与f.js配合使用。<br>
     * 返回结果看起来是这样：<br>
     * &lt;a href="JavaScript:tunePage(0,'pageNo')">|&lt;&lt;/a>
     * &lt;a href="JavaScript:tunePage(90,'pageNo')">&lt;&lt;/a>
     * &lt;a href="JavaScript:tunePage(0,'pageNo')">...&lt;/a>
     * &lt;a href="JavaScript:tunePage(100,'pageNo')">&lt;font
     * color='#FF0000'>&lt;b>11&lt;/b>&lt;/font>&lt;/a>
     * &lt;a href="JavaScript:tunePage(110,'pageNo')">12&lt;/a>
     * ..........
     * &lt;a href="JavaScript:tunePage(190,'pageNo')">20&lt;/a>
     * &lt;a href="JavaScript:tunePage(200,'pageNo')">...&lt;/a>
     * &lt;a href="JavaScript:tunePage(110,'pageNo')">&gt;&lt;/a>
     * &lt;a href="JavaScript:tunePage(290,'pageNo')">&gt;|&lt;/a><br>
     * 显示最终结果应该是这样：<br>
     * |&lt; &lt; ... 11 -- 20. ... > >|<br>
     * --------------------------------------------------------------------------<br>
     * <p/>
     * --------------------------------------------------------------------------
     *
     * @param cl      列表
     * @param pageNum 每页中可以翻页的数目
     * @param strPage 分页参数
     * @return 结果
     */
    public static String getPage(CommonList cl, int pageNum, String strPage) {
        //---------------------------------
        // 定义返回结果变量
        //---------------------------------
        String rValue = null;
        try {
            if (cl != null) {
                //---------------------------------
                // 当列表不为null才有效
                //---------------------------------

                StringBuffer buffer = new StringBuffer();

                //---------------------------------
                // strPage可以为空。js中默认为pageNo
                //---------------------------------
                strPage = strPage != null && strPage.length() > 0 ? ",\"" + strPage + "\"" : "";

                //---------------------------------
                // 默认为每页显示10个可翻页的数字。
                //---------------------------------
                if (pageNum < 1) pageNum = 10;
                //---------------------------------
                // 加入总记录数、当前页、总页数标签
                //---------------------------------
                buffer.append(
                        "共有[<font color='#FF0000'>" + cl.recNum + "</font>]条记录，" + cl.pageNo + "/" + cl.pageNum + "页。");
                if (cl.pageNo > 1) {
                    //---------------------------------
                    // 当前页不是第一页，
                    // 还要加入第一页和上一页标签
                    //---------------------------------
                    buffer.append(
                            " <a href='JavaScript:tunePage(1" + strPage + ")'>|&lt;</a> <a href='JavaScript:tunePage(" + (cl.pageNo - 1) + strPage + ")'>&lt;</a>");
                }

                //---------------------------------
                // 如果当前页大于每页显示页码数。
                // 则要显示快速向上翻的标签(标签是：...)
                //---------------------------------
                int currentNum = (cl.pageNo % pageNum == 0 ? (cl.pageNo / pageNum) - 1 : (int) (cl.pageNo / pageNum)) * pageNum;
                if (currentNum < 0) currentNum = 0;
                if (cl.pageNo > pageNum) {
                    buffer.append(
                            " <a href='JavaScript:tunePage(" + (currentNum - pageNum + 1) + strPage + ")'>...</a>");
                }

                //---------------------------------
                // 显示中间可用的翻页码
                //---------------------------------
                for (int i = 0; i < pageNum; i++) {
                    if ((currentNum + i + 1) > cl.pageNum || cl.pageNum < 2) break;
                    buffer.append(
                            " <a href='JavaScript:tunePage(" + (currentNum + i + 1) + strPage + ")'>" + (currentNum + i + 1 == cl.pageNo ? "<font color='#FF0000'><b>" + (currentNum + i + 1) + "</b></font>" : (currentNum + i + 1) + "") + "</a>");
                }

                //---------------------------------
                // 如果还未到达最后一版，
                // 则还要加入快速向下翻的标签(标签是：...)
                //---------------------------------
                if (cl.pageNum > (currentNum + pageNum))
                    buffer.append(
                            " <a href='JavaScript:tunePage(" + (currentNum + 1 + pageNum) + strPage + ")'>...</a>");

                //---------------------------------
                // 如果当前页不是最后一页，
                // 则要加入下一页和最后一页标筌
                //---------------------------------
                if (cl.pageNo < cl.pageNum) {
                    buffer.append(
                            " <a href='JavaScript:tunePage(" + (cl.pageNo + 1) + strPage + ")'>&gt;</a> <a href='JavaScript:tunePage(" + cl.pageNum + strPage + ")'>&gt;|</a>");
                }
                rValue = buffer.toString();
                //---------------------------------
                // 显式释放资源
                //---------------------------------
                buffer.setLength(0);
                buffer = null;
            } else {
                rValue = "";
            }
        } catch (Exception e) {
            rValue = "";
        }
        cl = null;
        return rValue;
    }

    public int getRecNum() {
        return recNum;
    }

    /**
     * 格式化当前对象的内容<br>
     * <p/>
     * --------------------------------------------------------------------------
     *
     * @return 当前的对象的内容
     */
    public String toString() {
        return "com.wanmei.system.security.tool.paging.CommonList{" +
                "pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", pageNum=" + pageNum +
                ", recNum=" + recNum +
                ", startPos=" + startPos +
                ", endPos=" + endPos +
                "}";
    }
    /**
     * 请保留下面的注释
     *
     *
     * js 翻页代码
     * function tunePage(toPageNo,pageNo) {
     * try {
     * var topage = 1;
     * if(typeof(toPageNo) != "number" || toPageNo < 1) topage = 1;
     * else topage = toPageNo;
     * var olds = window.location.searchSubject;
     * if(typeof(pageNo) == "undefined" || pageNo == "") pageNo = "pageNo";
     * var news = "";
     * if(olds.length > 1) {
     * olds = olds.substring(1,olds.length);
     * var arrays = olds.split("&");
     * for (var i = 0; i < arrays.length ; i++)
     * {
     * if(arrays[i].indexOf(pageNo + "=") < 0 && arrays[i].length > 1) {
     * news += "&" + arrays[i];
     * }
     * }
     * if(news.length > 1) {
     * news = "?" + news.substring(1,news.length) + "&" + pageNo + "=" + topage;
     * }
     * else {
     * news = "?" + pageNo + "=" + topage;
     * }
     * }
     * else {
     * news = "?" + pageNo + "=" + topage;
     * }
     * window.location = window.location.pathname + news;
     * }
     * catch(e) {
     * window.location = window.location.pathname + window.location.searchSubject;
     * }
     * }
     * function sAll(thisObj,dObj) {
     * try {
     * var l = eval(dObj + ".length");
     * if(typeof(l) == "undefined") {
     * eval(dObj).checked = thisObj.checked;
     * }
     * else {
     * for(var i = 0; i < l; i++) {
     * if(!eval(dObj + "[" + i + "]").disabled) eval(dObj + "[" + i + "]").checked = thisObj.checked;
     * }
     * }
     * }
     * catch(e){}
     * }
     */


	public int getPageNo() {
		return pageNo;
	}


	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	public int getPageNum() {
		return pageNum;
	}


	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}


	public int getStartPos() {
		return startPos;
	}


	public void setStartPos(int startPos) {
		this.startPos = startPos;
	}


	public int getEndPos() {
		return endPos;
	}


	public void setEndPos(int endPos) {
		this.endPos = endPos;
	}


	public String getSearchStr() {
		return searchStr;
	}


	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}


	public void setRecNum(int recNum) {
		this.recNum = recNum;
	}


	public String getUri() {
		return uri;
	}


	public void setUri(String uri) {
		this.uri = uri;
	}


	public String getTarget() {
		return target;
	}


	public void setTarget(String target) {
		this.target = target;
	}
}
