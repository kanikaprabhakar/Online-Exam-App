package Dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Transactional;
import Entity.ExamAttempt;
import java.util.List;

@Transactional
public class ExamAttemptDao {
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
