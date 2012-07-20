package ${project.org}.common.dao.criteria;

import org.hibernate.Criteria;

/**
 * User: joeytang
 * Date: ${project.currentTime}
 * 执行接口
 */
public interface CriteriaCommand {
    public Criteria execute(Criteria criteria);
}
