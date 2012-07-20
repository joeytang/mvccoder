SET FOREIGN_KEY_CHECKS=0;

<#list project.domains as domain>
<#if domain.name=='User'>
INSERT INTO ${domain.table}
   (`username`, `password`, `nickname`, `status`, `role`)
VALUES
   ('admin','1','管理员' ,0, 'ROLE_ADMIN');
INSERT INTO ${domain.table}
   (`username`, `password`, `nickname`, `status`, `role`)
VALUES
   ('user','1','普通用户', 0, 'ROLE_USER');
</#if>
</#list>