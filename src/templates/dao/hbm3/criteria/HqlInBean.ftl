package ${project.org}.common.dao.criteria;

 /**
 * @author joeytang
 * Date: ${project.currentTime}
 * hql中调用in语句时传入的参数
 */
public class HqlInBean {
	private String inName;
	private Object[] inParam;
	public HqlInBean(String inName, Object[] inParam) {
		super();
		this.inName = inName;
		this.inParam = inParam.clone();
	}
	public String getInName() {
		return inName;
	}
	public void setInName(String inName) {
		this.inName = inName;
	}
	public Object[] getInParam() {
		return inParam.clone();
	}
	public void setInParam(Object[] inParam) {
		this.inParam = inParam.clone();
	}
}
