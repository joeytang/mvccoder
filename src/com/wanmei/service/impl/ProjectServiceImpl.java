package com.wanmei.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.common.service.impl.BaseServiceImpl;
import com.wanmei.dao.ProjectDao;
import com.wanmei.domain.Action;
import com.wanmei.domain.Dao;
import com.wanmei.domain.Db;
import com.wanmei.domain.Domain;
import com.wanmei.domain.Field;
import com.wanmei.domain.Project;
import com.wanmei.domain.ProjectDomain;
import com.wanmei.domain.Security;
import com.wanmei.service.DomainService;
import com.wanmei.service.ProjectDomainService;
import com.wanmei.service.ProjectService;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 项目模块service
 */
@Service("projectService")
public class ProjectServiceImpl  extends BaseServiceImpl<Project,Integer,ProjectDao>  implements ProjectService {
	@Autowired
	private ProjectDomainService projectDomainService;
	@Autowired
	private DomainService domainService;
	@Override
	public Project wireProject(Integer id){
		Project p = this.baseDao.get(id);
		if(null == p){
			return null;
		}
		p.setDomains(wireDomains(p,id));
		
		Action a = p.getAction();
		if(null != a){
			a.setProject(p);
			p.setAction(a);
		}
		Dao d = p.getDao();
		if(null != d){
			d.setProject(p);
			p.setDao(d);
		}
		Security s = p.getSecurity();
		if(null != s){
			s.setProject(p);
			p.setSecurity(s);
		}
		Db db = p.getDb();
		if(null != db){
			db.setProject(p);
			p.setDb(db);
		}
		
		return p;
	}
	private List<Domain> wireDomains(Project project ,Integer id){
		SqlFilter filter = new SqlFilter();
		filter.addFilter("project.id", id);
		SqlSort sort = new SqlSort();
		sort.addSort("menuOrder", "asc");
		sort.addSort("createTime", "asc");
		List<ProjectDomain> dfs = projectDomainService.list(filter, sort, -1, -1);
		List<Domain> fs = null;
		Map<String,Domain> domainMap = new HashMap<String, Domain>();
		List<Field> manyOneEditFields = new ArrayList<Field>();
		List<Field> oneManyRelationFields = new ArrayList<Field>();
		List<Field> manyManyRelationFields = new ArrayList<Field>();
		if(null != dfs){
			fs = new ArrayList<Domain>();
			for(ProjectDomain df:dfs){
				Domain c = domainService.weirDomain(df.getDomain().getIdkey());
				c.setProject(project);
				fs.add(c);
				List<Field> tempFs = c.getMany2OneEditSelectFields();
				List<Field> tempOneManyFs = c.getOne2ManyRelationFields();
				List<Field> tempManyManyFs = c.getMany2ManyRelationFields();
				if(tempFs != null && tempFs.size() > 0){
					manyOneEditFields.addAll(tempFs);
				}
				if(tempOneManyFs != null && tempOneManyFs.size() > 0){
					oneManyRelationFields.addAll(tempOneManyFs);
				}
				if(tempManyManyFs != null && tempManyManyFs.size() > 0){
					manyManyRelationFields.addAll(tempManyManyFs);
				}
				domainMap.put(c.getName(), c);
			}
		}
		for(Field f:manyOneEditFields){
			String eName = f.getEntityName();
			Domain c = domainMap.get(eName);
			if(c != null){
				c.setIsMany2OneRelationBean(true);
				c.setMany2OneRelationBeanFieldName(f.getMany2OneName());
			}
			domainMap.put(eName, c);
		}
		for(Field f:oneManyRelationFields){
			String eName = f.getEntityName();
			Domain c = domainMap.get(eName);
			if(c != null){
				c.setIsOne2ManyRelationBean(true);
				c.setOne2ManyRelationField(f);
			}
			domainMap.put(eName, c);
		}
		for(Field f:manyManyRelationFields){
			String eName = f.getEntityName();
			Domain c = domainMap.get(eName);
			if(c != null){
				c.setIsMany2ManyRelationBean(true);
				c.setMany2ManyRelationField(f);
			}
			domainMap.put(eName, c);
		}
		project.setDomainMap(domainMap);
		return fs;
	}
}
