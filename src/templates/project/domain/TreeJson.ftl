package ${project.org}.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;


/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 树需要的属性
 */
public class TreeJson implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long id;
	private String text;
	private boolean checked;
	private Map<Object,Object> attributes;
	private String state;
	private String iconCls;
	private List<TreeJson> children;

    public Long getId() {
        return id;
    }

    public void setId(final Long id) {
        this.id = id;
    }

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public Map<Object, Object> getAttributes() {
		return attributes;
	}

	public void setAttributes(Map<Object, Object> attributes) {
		this.attributes = attributes;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<TreeJson> getChildren() {
		return children;
	}

	public void setChildren(List<TreeJson> children) {
		this.children = children;
	}
	
	
	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public static TreeJson fromMenu(Menu menu){
	    	TreeJson tree = new TreeJson();
	    	tree.setId(menu.getId());
	    	tree.setState("open");
	    	tree.setIconCls("icon "+menu.getIconCls());
	    	tree.setText(menu.getTitle());
	    	List<TreeJson> c = null;
	    	tree.setChecked(StringUtils.isNotBlank(menu.getAuthorize()) && menu.getAuthorize().equals("1")?true:false);
	    	if(null != menu.getChildren() && menu.getChildren().size() > 0){
	    		c = new ArrayList<TreeJson>();
	    		for(Menu m:menu.getChildren()){
	    			c.add(fromMenu(m));
	    		}
	    		tree.setChildren(c);
	    	}
	    	return tree;
	}

}
