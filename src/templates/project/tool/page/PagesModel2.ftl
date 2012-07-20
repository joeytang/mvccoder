package ${project.org}.tool.paging;


/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 
 * 共有[15]条记录，1/8页。 1 2 3 4 5 6 7 8 » ›
 */
public class PagesModel2 implements PagesModel {

    /**
	 * 根据 commonlist和pagenum生成分页html代码
	 * @param cl 包含分页需要的信息
	 * @param pageNum 限制每屏显示的页码个数 ，如：上一页  1 2 3 4 5 下一页该值表示中间显示多少个页码
	 * @return
	 */
	@Override
	public String genPageHtml(CommonList cl, int pageNum,String op) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("共有[" + cl.recNum + "]条记录，" + cl.pageNo + "/" + cl.pageNum + "页。");
        //---------------------------------
        // 当前页不是第一页，
        // 还要加入第一页和上一页标签
        //---------------------------------
        if (cl.pageNo > 1) {
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + 1 + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >&#8249;</a>");
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo - 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >&laquo;</a>");
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
           	 buffer.append((currentNum + i + 1) + "");
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
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >&raquo;</a>");
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + cl.pageNum + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >&#8250;</a>");
        }
		return buffer.toString();
	}
    
}
