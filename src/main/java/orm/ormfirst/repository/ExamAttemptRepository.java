package orm.ormfirst.repository;

import Entity.ExamAttempt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamAttemptRepository extends JpaRepository<ExamAttempt, Long> {
    
    // ✅ FIX: Ensure this method exists
    List<ExamAttempt> findAllByOrderByAttemptTimeDesc();
    
    // ✅ FIX: Find by student email
    List<ExamAttempt> findByStudentEmailOrderByAttemptTimeDesc(String studentEmail);
    
    // ✅ NEW: Find by student email and exam config id
    List<ExamAttempt> findByStudentEmailAndExamConfigId(String studentEmail, Integer examConfigId);
    
    // ✅ ADD: Custom query if needed
    @Query("SELECT e FROM ExamAttempt e ORDER BY e.attemptTime DESC")
    List<ExamAttempt> findAllOrderedByAttemptTime();
    
    // ✅ ADD: Count methods
    long count();
}
