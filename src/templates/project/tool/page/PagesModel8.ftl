package ${project.org}.tool.paging;


/**
 * 完美在线站内信分页
 * User: joeytang
 * Date: ${project.currentTime}
 * 
 *  <li><a href="#" class="a_start">上一页</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">4</a></li>
                <li><a href="#">5</a></li>
                <li><a href="#" class="a_start">下一页</a></li>
                <li><a href="#" class="a_start">尾 页</a></li>
 *  
	上一页 1 2 3 4 5 下一页 尾 页
 */
public class PagesModel8 implements PagesModel {

    /**
	 * 根据 commonlist和pagenum生成分页html代码
	 * @param cl 包含分页需要的信息
	 * @param pageNum 限制每屏显示的页码个数 ，如：上一页  1 2 3 4 5 下一页该值表示中间显示多少个页码
	 * @return
	 */
	@Override
	public String genPageHtml(CommonList cl, int pageNum,String op) {
		if(cl == null || cl.recNum < 1){
			return "";
		}
		StringBuffer buffer = new StringBuffer();
		//---------------------------------
		// 当前页不是第一页，
		// 还要加入第一页和上一页标签
		//---------------------------------
        if (cl.pageNo == 1) {
            buffer.append("<li> <a class='a_start' href='javascript:void(0);'>上一页</a></li>" + "&nbsp;");
        } else if (cl.pageNo > 1) {
            buffer.append(" <li><a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo - 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >上一页</a></li>" + "&nbsp;");
        }
        //---------------------------------
        // 如果当前页大于每页显示页码数。
        // 则要显示快速向上翻的标签(标签是：...)
        //---------------------------------
        int currentNum = (cl.pageNo % pageNum == 0 ? (cl.pageNo / pageNum) - 1 : (int) (cl.pageNo / pageNum)) * pageNum;
        if (currentNum < 0) currentNum = 0;

        //---------------------------------
        // 显示中间可用的翻页码
        //---------------------------------
        for (int i = 0; i < pageNum; i++) {
            if ((currentNum + i + 1) > cl.pageNum || cl.pageNum < 2) break;
            buffer.append("<li>");
            if(currentNum + i + 1 == cl.pageNo){
           	 buffer.append("<b>" + (currentNum + i + 1) + "</b>");
            }else{
           	 buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (currentNum + i + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >");
           	 buffer.append("<b>" + (currentNum + i + 1) + "</b>");
           	 buffer.append("</a>");
            }
            buffer.append("</li>");
        }

        if (cl.pageNo == cl.pageNum) {
            buffer.append("<li><a class='a_start' href='javascript:void(0);'>下一页</a></li>" + "&nbsp;");
            buffer.append("<li><a class='a_start' href='javascript:void(0);'>尾页</a></li>" + "&nbsp;");
        } else if (cl.pageNo < cl.pageNum) {
            buffer.append(" <li><a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >下一页</a></li>" + "&nbsp;");
            buffer.append(" <li><a href=\"javascript:;\" onclick=\"_tunePage(" + cl.pageNum + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >尾页</a></li>" + "&nbsp;");
        }
		return buffer.toString();
	}
    
}
