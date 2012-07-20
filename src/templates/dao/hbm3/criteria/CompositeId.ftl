package ${project.org}.common.dao.criteria;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 是否为联合主键的某一个列
 */
public class CompositeId {
     private Object object;
     
	public CompositeId(){}
    public CompositeId(Object object){
    	this.object = object;
    }
    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
