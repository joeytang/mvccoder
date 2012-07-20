package ${project.org}.security.web.action;

import ${project.org}.tool.paging.CommonList;

/**
 * User:joeytang
 * Date: ${project.currentTime}
 * 分页相关action基类
 */
public class PageAction extends BaseAction {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    protected int page = 1; // 当前页
    protected int total; // 总记录数
    protected int rows = 20;// 分页记录
    protected String sortName;
    protected String order;
    protected String searchName;
    protected String searchValue;
    
    protected CommonList commonList;//自定义分页对象
	
    public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public CommonList getCommonList() {
		return commonList;
	}
	public void setCommonList(CommonList commonList) {
		this.commonList = commonList;
	}
	protected CommonList createCommonList(){
    	return new CommonList(total, page, rows);
    }
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getSearchName() {
		return searchName;
	}
	public void setSearchName(String searchName) {
		this.searchName = searchName;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
}
