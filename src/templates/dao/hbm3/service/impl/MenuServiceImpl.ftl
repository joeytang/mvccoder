package ${project.org}.service.impl;

import java.util.Set;

import ${project.org}.dao.MenuDao;
import ${project.org}.domain.Menu;
import ${project.org}.domain.Role;
import ${project.org}.service.MenuService;
import ${project.org}.common.service.impl.BaseServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 菜单业务逻辑实现
 */
@Service("menuService")
public class MenuServiceImpl extends BaseServiceImpl<Menu,${project.security.idType2ShortJavaType}> implements MenuService {
  @SuppressWarnings("unused")
	@Autowired
	private void setDao(MenuDao baseDao){
		this.baseDao = baseDao;
	}

   /**
    * 删除菜单
    * @param id
 * @throws Exception 
    */
   @Transactional
   @Override
   public void removeById(${project.security.idType2ShortJavaType} id) throws Exception {
	   Menu menu = this.baseDao.get(id);
	   Set<Role> roles = menu.getRoles();
	   for (Role r : roles) {
		   r.getMenus().remove(menu);
	   }
	   this.baseDao.remove(menu);
   }
    /**
     * 删除菜单
     * @param id
     */
    @Transactional
    @Override
    public void remove(Menu menu)  throws Exception {
        Set<Role> roles = menu.getRoles();
        for (Role r : roles) {
            r.getMenus().remove(menu);
        }
        this.baseDao.remove(menu);
    }
}

