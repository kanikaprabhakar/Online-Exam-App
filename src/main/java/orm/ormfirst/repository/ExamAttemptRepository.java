package orm.ormfirst.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import entity.ExamAttempt;

@Repository
public interface ExamAttemptRepository extends JpaRepository<ExamAttempt, Integer> {
}
