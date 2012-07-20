package com.wanmei.tool.paging;


/**
 * User: joeytang
 * Date: 2012-03-23 14:32
 */
public class PagesModel10 implements PagesModel {

	@Override
	public String genPageHtml(CommonList cl, int pageNum,String op) {
		StringBuffer buffer = new StringBuffer();
		 //buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
         if (cl.pageNo > 1) {
             //---------------------------------
             // 当前页不是第一页，
             // 还要加入第一页和上一页标签
             //---------------------------------
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + 1 + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" class=\"long\">第一页</a>");
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo - 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" class=\"long\">上一页</a>");
         }

         //---------------------------------
         // 如果当前页大于每页显示页码数。
         // 则要显示快速向上翻的标签(标签是：...)
         //---------------------------------
         int currentNum = (cl.pageNo % pageNum == 0 ? (cl.pageNo / pageNum) - 1 : (int) (cl.pageNo / pageNum)) * pageNum;
         if (currentNum < 0) currentNum = 0;
         if (cl.pageNo > pageNum) {
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (currentNum - pageNum + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\">...</a>");
         }

         //---------------------------------
         // 显示中间可用的翻页码
         //---------------------------------
         for (int i = 0; i < pageNum; i++) {
             if ((currentNum + i + 1) > cl.pageNum || cl.pageNum < 2) break;
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (currentNum + i + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\"");
             buffer.append(currentNum + i + 1 == cl.pageNo ?" class=\"on\">" : ">");
             buffer.append((currentNum + i + 1) + "");
             buffer.append("</a>");
         }

         //---------------------------------
         // 如果还未到达最后一版，
         // 则还要加入快速向下翻的标签(标签是：...)
         //---------------------------------
         if (cl.pageNum > (currentNum + pageNum)) {
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (currentNum + 1 + pageNum) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\">...</a>");
         }

         //---------------------------------
         // 如果当前页不是最后一页，
         // 则要加入下一页和最后一页标筌
         //---------------------------------
         if (cl.pageNo < cl.pageNum) {
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" class=\"long\">下一页</a>");
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + cl.pageNum + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" class=\"long\">最后一页</a>");
         }
         buffer.append("&nbsp;&nbsp;&nbsp;&nbsp;到 <input type='text' id='_jump_page' onblur='if(!/^[1-9]+(\\d)*$/.test($(this).val()) || eval($(this).val()) < 1){$(this).val(1);}else if(eval($(this).val()) >"+cl.pageNum+" ){$(this).val("+cl.pageNum+");}' class='pager' value='");
         buffer.append(cl.pageNo);
         buffer.append("'/> 页");
         buffer.append("<input type='button' class='jump' onclick=\"_tunePage(document.getElementById('_jump_page').value,'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" value='确定'");
		return buffer.toString();
	}
}
