package orm.ormfirst.dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;
import Entity.ExamAttempt;
import java.util.List;

@Transactional
@Repository
public class ExamAttemptDao {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    public void saveAttempt(ExamAttempt attempt) {
        hibernateTemplate.save(attempt);
    }

    public List<ExamAttempt> getAllAttempts() {
        return (List<ExamAttempt>) hibernateTemplate.loadAll(ExamAttempt.class);
    }
}
