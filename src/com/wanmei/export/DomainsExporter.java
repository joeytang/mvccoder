package com.wanmei.export;

import java.util.ArrayList;
import java.util.List;

import com.wanmei.domain.Domain;
import com.wanmei.domain.Field;
import com.wanmei.domain.FieldHelper;
import com.wanmei.domain.IdField;
import com.wanmei.domain.Project;

public class DomainsExporter extends AbstractExporter {
	private List<Domain> domains;
	public DomainsExporter( List<Domain> domains){
		this.domains = domains;
	}
	@Override
	public void configTasks() {
		List<Domain> keyDomains = new ArrayList<Domain>();
		if(null != domains){
			for(Domain domain:domains){
				List<Field> many2ManyRelationFields = domain.getMany2ManyRelationFields();
				if(null != many2ManyRelationFields && many2ManyRelationFields.size() > 0){
					for(Field field : many2ManyRelationFields){
						Domain keyDomain = new Domain();
						keyDomain.setName(domain.getName()+field.getEntityName()+"Key");
						keyDomain.setPackageName(domain.getPackageName());
						keyDomain.setIsMany2ManyKey(true);
						keyDomain.setTable(field.getTable());
						keyDomain.setProject(domain.getProject());
						keyDomain.setLabel(domain.getLabel()+field.getLabel()+"关联");
						
						Field field1 = new Field();
						field1.setType(domain.getId().getType());
						field1.setColumn(field.getColumn());
						field1.setName(domain.getLowerFirstName()+"Id");
						field1.setDomain(keyDomain);
						Domain domain2 = domain.getProject().getDomainMap().get(field.getEntityName());
						Field field2 = new Field();
						field2.setType(domain2.getId().getType());
						field2.setColumn(field.getManyColumn());
						field2.setName(domain2.getLowerFirstName()+"Id");
						field2.setDomain(keyDomain);
						
						List<Field> keyDomainFields = new ArrayList<Field>();
						keyDomainFields.add(field1);
						keyDomainFields.add(field2);
						keyDomain.setFields(keyDomainFields);
						
						keyDomains.add(keyDomain);
					}
				}
				tasks.addExport(new DomainExporter(domain));
			}
		}
		if(null != keyDomains){
			for(Domain domain:keyDomains){
				tasks.addExport(new DomainExporter(domain));
			}
		}
	}
	@Override
	public void doExecute() {
		
	}
	
	@Override
	public Project getProject() {
		return null;
	}
}
