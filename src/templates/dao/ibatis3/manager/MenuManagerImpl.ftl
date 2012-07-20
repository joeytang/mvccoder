package ${project.org}.security.manager.impl;

import java.util.HashSet;
import java.util.List;

import ${project.org}.security.dao.MenuDao;
import ${project.org}.security.dao.MenuRoleDao;
import ${project.org}.security.domain.Menu;
import ${project.org}.security.domain.MenuRole;
import ${project.org}.security.domain.Role;
import ${project.org}.security.manager.MenuManager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 菜单业务逻辑实现
 */
@Service("menuManager")
public class MenuManagerImpl extends BaseManagerImpl<Menu,Long> implements MenuManager {
  @SuppressWarnings("unused")
	@Autowired
	private void setDao(MenuDao baseDao){
		this.baseDao = baseDao;
	}
  @Autowired
  private MenuRoleDao menuRoleDao;

   /**
    * 删除菜单
    * @param id
 * @throws Exception 
    */
   @Transactional
   @Override
   public int removeById(Long id) throws Exception {
	   menuRoleDao.removeById(new MenuRole(id,null));
	   return this.baseDao.removeById(id);
   }
   /**
    * 删除菜单
    * @param id
    * @throws Exception 
    */
   @Transactional
   @Override
   public int remove(Menu menu) throws Exception {
	   menuRoleDao.removeById(new MenuRole(menu.getId(),null));
	   return this.baseDao.remove(menu);
   }
   /**
    * 列出所有menu，并将每个menu的role设置进去
    * @param id
    * @throws Exception 
    */
   @Override
   public List<Menu> listAll(int pageNo,int pageSize ) throws Exception {
   	List<Menu> menus = super.listAll(pageNo, pageSize);
   	if(null != menus){
   		for(Menu m:menus){
   			m.setRoles(new HashSet<Role>(menuRoleDao.listRoleByMenuId(m.getId())));
   		}
   	}
       return menus;
   }
}

