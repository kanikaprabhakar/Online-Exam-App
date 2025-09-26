package orm.ormfirst.repository;

import entity.ExamAttempt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ExamAttemptRepository extends JpaRepository<ExamAttempt, Integer> {
    List<ExamAttempt> findByStudentIdOrderByStartTimeDesc(Integer studentId);
    List<ExamAttempt> findByStudentEmailOrderByStartTimeDesc(String studentEmail);
    List<ExamAttempt> findAllByOrderByStartTimeDesc();
}
