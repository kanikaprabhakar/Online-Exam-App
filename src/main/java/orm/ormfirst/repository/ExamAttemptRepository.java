package orm.ormfirst.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import entity.ExamAttempt;

import java.util.List;

@Repository
public interface ExamAttemptRepository extends JpaRepository<ExamAttempt, Integer> {
	// Find all exam attempts by student email
	List<ExamAttempt> findByStudentEmail(String email);
}
