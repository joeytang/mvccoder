package ${project.org}.security.dao.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.InitializingBean;

/**
 * Created by IntelliJ IDEA.
 * User: joeytang
 * Date: 2009-2-23
 * Time: 12:03:31
 * To change this template use File | Settings | File Templates.
 */
public abstract class IbatisDaoSurpport implements InitializingBean{

	protected final Log logger = LogFactory.getLog(this.getClass());
    
	private SqlSessionFactory sqlSessionFactory;
    private SqlSessionTemplate sqlSessionTemplate;
	
    public final void afterPropertiesSet(){
    	
    }
    
    
	public SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}

	public void setSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
		if (this.sqlSessionTemplate == null || sqlSessionFactory != this.sqlSessionTemplate.getSqlSessionFactory()) {
			this.sqlSessionFactory = sqlSessionFactory;
			this.sqlSessionTemplate = new SqlSessionTemplate(sqlSessionFactory);
		}
	}
	
	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}
	
	public class SqlSessionTemplate {
		SqlSessionFactory sqlSessionFactory;
		
		public SqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
			this.sqlSessionFactory = sqlSessionFactory;
		}
		

		public SqlSessionFactory getSqlSessionFactory() {
			return sqlSessionFactory;
		}

		public Object execute(SqlSessionCallback action)  {
			SqlSession session = null;
			try {
				session = sqlSessionFactory.openSession();
				Object result = action.doInSession(session);
				return result;
			}finally {
				if(session != null) {
				    session.close();
				}
			}
		}
		
		public Object selectOne(final String statement) {
			return execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.selectOne(statement);
				}
			});
		}
		
		public Object selectOne(final String statement,final Object entity) {
			return execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.selectOne(statement, entity);
				}
			});
		}
		
		@SuppressWarnings("rawtypes")
		public List selectList(final String statement) {
			return (List)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.selectList(statement);
				}
			});
		}
		@SuppressWarnings("rawtypes")
		public List selectList(final String statement,final Object entity) {
			return (List)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.selectList(statement, entity);
				}
			});
		}
		
		@SuppressWarnings("rawtypes")
		public List selectList(final String statement,final Object entity,final int offset,final int limit) {
			return (List)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					
					return session.selectList(statement, entity, new RowBounds(offset,limit));
				}
			});
		}
		
		
		public int delete(final String statement) {
			return (Integer)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.delete(statement);
				}
			});
		}
		
		public int delete(final String statement,final Object entity) {
			return (Integer)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.delete(statement, entity);
				}
			});
		}
		
		public int update(final String statement) {
			return (Integer)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.update(statement);
				}
			});
		}
		
		public int update(final String statement,final Object entity) {
			return (Integer)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.update(statement, entity);
				}
			});
		}
		
		public int insert(final String statement) {
			return (Integer)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.insert(statement);
				}
			});
		}
		
		public int insert(final String statement,final Object entity) {
			return (Integer)execute(new SqlSessionCallback() {
				public Object doInSession(SqlSession session) {
					return session.insert(statement,entity);
				}
			});
		}
		
	} 
	public static interface SqlSessionCallback {
		public Object doInSession(SqlSession session);
	}
}
