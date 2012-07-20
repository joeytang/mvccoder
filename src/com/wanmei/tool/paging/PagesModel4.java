package com.wanmei.tool.paging;


/**
 * User: joeytang
 * Date: 2012-03-23 14:32
 * 
 *  上一页  下一页
 */
public class PagesModel4 implements PagesModel {

    /**
	 * 根据 commonlist和pagenum生成分页html代码
	 * @param cl 包含分页需要的信息
	 * @param pageNum 限制每屏显示的页码个数 ，如：上一页  1 2 3 4 5 下一页该值表示中间显示多少个页码
	 * @return
	 */
	@Override
	public String genPageHtml(CommonList cl, int pageNum,String op) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
		//---------------------------------
		// 上一页，
		//---------------------------------
        if (cl.pageNo == 1) {
            buffer.append("上一页" + "&nbsp;");
        } else if (cl.pageNo > 1) {
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo - 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >上一页</a>");
        }
      //---------------------------------
        // 下一页
        //---------------------------------
        if (cl.pageNo == cl.pageNum) {
            buffer.append("下一页" + "&nbsp;");
        } else if (cl.pageNo < cl.pageNum) {
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >下一页</a>");
        }
		return buffer.toString();
	}
    
}
