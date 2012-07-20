package com.wanmei.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.wanmei.common.dao.SqlFilter;
import com.wanmei.common.dao.SqlSort;
import com.wanmei.common.service.impl.BaseServiceImpl;
import com.wanmei.dao.DomainDao;
import com.wanmei.domain.Button;
import com.wanmei.domain.Controller;
import com.wanmei.domain.Domain;
import com.wanmei.domain.DomainButton;
import com.wanmei.domain.DomainController;
import com.wanmei.domain.DomainField;
import com.wanmei.domain.Field;
import com.wanmei.domain.FieldHelper;
import com.wanmei.service.DomainButtonService;
import com.wanmei.service.DomainControllerService;
import com.wanmei.service.DomainFieldService;
import com.wanmei.service.DomainService;
import com.wanmei.util.BeanHelper;

/**
 * @author joeytang  
 * Date: 2012-03-20 18:17
 * 模块模块service
 */
@Service("domainService")
public class DomainServiceImpl  extends BaseServiceImpl<Domain,Integer,DomainDao>  implements DomainService {
	
	@Autowired
	private DomainFieldService domainFieldService;
	@Autowired
	private DomainControllerService domainControllerService;
	@Autowired
	private DomainButtonService domainButtonService;
	@Override
	public Domain weirDomain(Integer id){
		Domain d = super.get(id);
		if(null == d){
			return null;
		}
//		Field fid =  d.getId();
//		if(null != fid){
//			fid.setDomain(d);
//			d.setId(fid);
//		}
		d.setFields(weirFields(d,id));
		d.setControllers(weirControllers(d,id));
		d.setButtons(weirButtons(d,id));
		return d;
	}
	private List<Field> weirFields(Domain domain,Integer id){
		SqlFilter filter = new SqlFilter();
		filter.addFilter("domain.idkey", id);
		SqlSort sort = new SqlSort();
		sort.addSort("createTime", "asc");
		List<DomainField> dfs = domainFieldService.list(filter, sort, -1, -1);
		List<Field> fs = null;
		if(null != dfs){
			fs = new ArrayList<Field>();
			for(DomainField df:dfs){
				Field f = df.getField();
//				f.setDomain(d);
//				f.setEditable(df.getEditable());
//				f.setEditOrder(df.getEditOrder());
//				f.setHbmable(df.getHbmable());
//				f.setListable(df.getListable());
//				f.setListOrder(df.getListOrder());
//				f.setNullable(df.getNullable());
//				f.setSearchable(df.getSearchable());
//				f.setSearchOrder(df.getSearchOrder());
//				f.setViewable(df.getViewable());
//				f.setViewOrder(df.getViewOrder());
//				
				df.setId(null);
				BeanHelper.copyNotNullProperties(df,f);
				f.setDomain(domain);
				if(f.getCategory() != null && f.getCategory().equals(FieldHelper.CATEGORY_ID)){
					domain.setId(f);
				}else{
					fs.add(f);
				}
			}
		}
		return fs;
	}
	private List<Controller> weirControllers(Domain domain,Integer id){
		SqlFilter filter = new SqlFilter();
		filter.addFilter("domain.idkey", id);
		SqlSort sort = new SqlSort();
		sort.addSort("createTime", "asc");
		List<DomainController> dfs = domainControllerService.list(filter, sort, -1, -1);
		List<Controller> fs = null;
		if(null != dfs){
			fs = new ArrayList<Controller>();
			for(DomainController df:dfs){
				Controller c = df.getController();
				c.setDomain(domain);
				fs.add(c);
			}
		}
		return fs;
	}
	private List<Button> weirButtons(Domain domain,Integer id){
		SqlFilter filter = new SqlFilter();
		filter.addFilter("domain.idkey", id);
		SqlSort sort = new SqlSort();
		sort.addSort("createTime", "asc");
		List<DomainButton> dfs = domainButtonService.list(filter, sort, -1, -1);
		List<Button> fs = null;
		if(null != dfs){
			fs = new ArrayList<Button>();
			for(DomainButton df:dfs){
				Button c = df.getButton();
				c.setDomain(domain);
				fs.add(c);
			}
		}
		return fs;
	}
	
}
