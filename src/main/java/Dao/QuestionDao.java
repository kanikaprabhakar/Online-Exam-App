package Dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Transactional;
import Entity.Question;
import java.util.List;

@Transactional
public class QuestionDao {
    private HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    public void insert(Question q) {
        hibernateTemplate.save(q);
    }

    public List<Question> getAllQuestions() {
        return (List<Question>) hibernateTemplate.loadAll(Question.class);
    }
}
