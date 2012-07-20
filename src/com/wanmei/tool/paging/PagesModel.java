package com.wanmei.tool.paging;


/**
 * User: joeytang
 * Date: 2012-03-23 14:32
 * 分页标签接口
 */
public interface PagesModel {
	
	/**
	 * 根据 commonlist和pagenum生成分页html代码
	 * @param cl 包含分页需要的信息
	 * @param pageNum 限制每屏显示的页码个数 ，如：上一页  1 2 3 4 5 下一页该值表示中间显示多少个页码
	 * @param op 得到数据列表后的操作
	 * @return
	 */
	public String genPageHtml(CommonList cl,int pageNum,String op);
    
}
