package ${project.org}.tool.paging;


/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 第一页 上一页  下一页  最末页
 */
public class PagesModel6 implements PagesModel {

    /**
	 * 根据 commonlist和pagenum生成分页html代码
	 * @param cl 包含分页需要的信息
	 * @param pageNum 限制每屏显示的页码个数 ，如：上一页  1 2 3 4 5 下一页该值表示中间显示多少个页码
	 * @return
	 */
	@Override
	public String genPageHtml(CommonList cl, int pageNum,String op) {
		StringBuffer buffer = new StringBuffer();
		//---------------------------------
		// 当前页不是第一页，
		// 还要加入第一页和上一页标签
		//---------------------------------
        if (cl.pageNo == 1) {
            buffer.append("第一页" + "&nbsp;");
            buffer.append("上一页" + "&nbsp;");
        } else if (cl.pageNo > 1) {
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + 1 + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >第一页</a>");
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo - 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >上一页</a>");
        }
		//---------------------------------
        // 如果当前页不是最后一页，
        // 则要加入下一页和最后一页标筌
        //---------------------------------
        if (cl.pageNo == cl.pageNum) {
            buffer.append("下一页" + "&nbsp;");
            buffer.append("最末页" + "&nbsp;");
        } else if (cl.pageNo < cl.pageNum) {
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + (cl.pageNo + 1) + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >下一页</a>");
            buffer.append(" <a href=\"javascript:;\" onclick=\"_tunePage(" + cl.pageNum + ",'','"+ cl.uri+"','"+ cl.target +"','"+op+"','" + cl.searchStr + "')\" >最末页</a>");
        }
		return buffer.toString();
	}
    
}
