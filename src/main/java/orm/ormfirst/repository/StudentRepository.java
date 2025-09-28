package orm.ormfirst.repository;

import entity.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StudentRepository extends JpaRepository<Student, Integer> {
    
    // ✅ Find student by email
    Student findByEmail(String email);
    
    // ✅ Check if student exists by email
    boolean existsByEmail(String email);
    
    // ✅ Find by student ID
    Student findByStudentId(Integer studentId);
}
