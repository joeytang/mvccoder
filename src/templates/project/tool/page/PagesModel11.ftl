package ${project.org}.tool.paging;


/**
 * 完美在线站内信分页
 * User: joeytang
 * Date: ${project.currentTime}
 */
public class PagesModel11 implements PagesModel {

	@Override
	public String genPageHtml(CommonList cl, int pageNum,String op) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("<div class='viciao'>");
		 //buffer.append("共[" + cl.pageNo + "/" + cl.pageNum + "]页" + "&nbsp;");
        //---------------------------------
		// 当前页不是第一页，
		// 还要加入第一页和上一页标签
		//---------------------------------
         if (cl.pageNo > 1) {
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo - 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" ><&nbsp;prev</a>");
         }else{
        	 buffer.append(" <a href=\"javascript:;\"  class=\"disabled\"><&nbsp;prev</a>");
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
             if(currentNum + i + 1 == cl.pageNo){
            	// buffer.append("<span class=\"current\">");
            	 buffer.append((currentNum + i + 1) + "");
            	// buffer.append("</span>");
             }else{
            	 buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (currentNum + i + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >");
            	 buffer.append((currentNum + i + 1) + "");
            	 buffer.append("</a>");
             }
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
             buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >next&nbsp;></a>");
         }else{
        	 buffer.append(" <a href=\"javascript:;\"  class=\"disabled\">next&nbsp;></a>");
         }
         buffer.append("</div>");
         return buffer.toString();
	}
    
}
