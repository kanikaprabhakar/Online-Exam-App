package orm.ormfirst.dao;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entity.Student;

import java.util.List;

//@Repository
@Transactional
public class StudentDao {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    public void save(Student student) {
        hibernateTemplate.save(student);
    }

    public void update(Student student) {
        hibernateTemplate.update(student);
    }

    public void delete(Student student) {
        hibernateTemplate.delete(student);
    }

    public Student getById(int id) {
        return hibernateTemplate.get(Student.class, id);
    }

    public List<Student> getAll() {
        return (List<Student>) hibernateTemplate.loadAll(Student.class);
    }
}
