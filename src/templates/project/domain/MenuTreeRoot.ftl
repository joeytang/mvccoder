package ${project.org}.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * User: joeytang
 * Date: ${project.currentTime}
  * 菜单树
 */

public class MenuTreeRoot implements Serializable {
   /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Map<Long,Menu> menuMap = new HashMap<Long,Menu>();
	private List<Long> firstMenuIds = new ArrayList<Long>();
	
	public static final String MENU_TREE_ROOT_KEY = "menu_tree_root_key";
	public Menu getMenu(Long id){
		return menuMap.get(id);
	}
	public int size(){
		return menuMap.size();
	}
	public void addOrUpdateMenu(Menu m){
		menuMap.put(m.getId(), m);
		Menu p = m.getParent();
		if(null != p){
			Menu cp = this.getMenu(p.getId());
			if(cp == null){
				cp = p;
				cp.getChildren().add(m);
				addOrUpdateMenu(cp);
			}else{
				cp.getChildren().add(m);
				menuMap.put(cp.getId(), cp);
			}
		}else if(!firstMenuIds.contains(m.getId())){
			firstMenuIds.add(m.getId());
		}
	}
	public synchronized void deleteMenu(Long id) throws Exception{
		Menu m = menuMap.get(id);
		if(null == m || (m.getChildren() != null && m.getChildren().size() > 0)){
			throw new Exception("has child");
		}
		Menu p = m.getParent();
		if(p != null && p.getChildren() != null){
			p.getChildren().remove(m);
		}else if(firstMenuIds.contains(id)){
			firstMenuIds.remove(id);
		}
		menuMap.remove(id);
	}
	public List<Menu> listMenuTree(){
		List<Menu> tree = null;
		if(null != firstMenuIds && firstMenuIds.size() > 0){
			tree = new ArrayList<Menu>();
			for(Long id:firstMenuIds){
				Menu m = menuMap.get(id);
				if(null != m){
					tree.add(m);
				}
			}
		}
		return tree;
	}
	public List<Menu> getMenuTree(){
		return listMenuTree();
	}
	public List<Menu> listMenuTree(Long id){
		Menu cp = this.getMenu(id);
		Set<Menu> items = null;
		if(null != cp && (items = cp.getChildren()) != null && items.size() > 0){
			List<Menu> ms = new ArrayList<Menu>();
			ms.addAll(items);
			return ms;
		}
		return null;
	}
}

