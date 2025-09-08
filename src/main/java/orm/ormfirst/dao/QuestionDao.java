package orm.ormfirst.dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entity.Question;

import java.util.List;

//@Repository
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

    public void delete(Question q) {
        hibernateTemplate.delete(q);
    }
}
