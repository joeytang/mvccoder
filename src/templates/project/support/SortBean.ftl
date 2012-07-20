package ${project.org}.support;


/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 用于查询排序的bean
 */
public class SortBean {
	public final static String ASC = "asc";
	public final static String DESC = "desc";
	private String sortProperty;
	private String sortOrder = DESC;
	
	public SortBean() {
	}
	
	public SortBean(String sortProperty, String sortOrder) {
		this.sortProperty = sortProperty;
		this.sortOrder = sortOrder;
	}
	public String getSortProperty() {
		return sortProperty;
	}
	public void setSortProperty(String sortProperty) {
		this.sortProperty = sortProperty;
	}
	public String getSortOrder() {
		return sortOrder;
	}
	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}
	
}
