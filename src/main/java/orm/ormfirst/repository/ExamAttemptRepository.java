package orm.ormfirst.repository;

import entity.ExamAttempt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamAttemptRepository extends JpaRepository<ExamAttempt, Long> {
    
    // ✅ ADD: Missing method
    List<ExamAttempt> findAllByOrderByAttemptTimeDesc();
    
    // ✅ ADD: Find by student email
    List<ExamAttempt> findByStudentEmailOrderByAttemptTimeDesc(String studentEmail);
    
    List<ExamAttempt> findByStudentEmail(String studentEmail);
    
    long countByStudentEmail(String studentEmail);
}
