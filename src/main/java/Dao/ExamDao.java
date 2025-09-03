package Dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.transaction.annotation.Transactional;
import Entity.Exam;
import java.util.List;

@Transactional
public class ExamDao {
    private HibernateTemplate hibernateTemplate;

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    public void saveOrUpdate(Exam exam) {
        hibernateTemplate.saveOrUpdate(exam);
    }

    public Exam getCurrentExam() {
        List<Exam> exams = (List<Exam>) hibernateTemplate.loadAll(Exam.class);
        for (Exam e : exams) {
            if (e.isEnabled()) return e;
        }
        return null;
    }

    public void disableAllExams() {
        List<Exam> exams = (List<Exam>) hibernateTemplate.loadAll(Exam.class);
        for (Exam e : exams) {
            if (e.isEnabled()) {
                e.setEnabled(false);
                hibernateTemplate.saveOrUpdate(e);
            }
        }
    }
}
