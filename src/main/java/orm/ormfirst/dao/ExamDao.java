package orm.ormfirst.dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Repository;
import Entity.Exam;
import java.util.List;

@Transactional
@Repository
public class ExamDao {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    public Exam getCurrentExam() {
        List<Exam> exams = (List<Exam>) hibernateTemplate.loadAll(Exam.class);
        return exams.isEmpty() ? null : exams.get(0);
    }

    public void saveOrUpdate(Exam exam) {
        hibernateTemplate.saveOrUpdate(exam);
    }

    public void disableAllExams() {
        List<Exam> exams = (List<Exam>) hibernateTemplate.loadAll(Exam.class);
        for (Exam exam : exams) {
            exam.setEnabled(false);
            hibernateTemplate.saveOrUpdate(exam);
        }
    }
}
