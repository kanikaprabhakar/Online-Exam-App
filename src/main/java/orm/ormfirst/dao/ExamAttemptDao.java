package orm.ormfirst.dao;

import orm.ormfirst.repository.ExamAttemptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import entity.ExamAttempt;

import java.util.List;
import java.util.Optional;

@Transactional
//@Repository
public class ExamAttemptDao {
    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    public void saveAttempt(ExamAttempt attempt) {
        examAttemptRepository.save(attempt);
    }

    public List<ExamAttempt> getAllAttempts() {
        return (List<ExamAttempt>) examAttemptRepository.findAll();
    }

    public ExamAttempt getAttemptById(int id) {
        Optional<ExamAttempt> attempt = examAttemptRepository.findById(id);
        return attempt.orElse(null);
    }

    public void deleteAttempt(int id) {
        examAttemptRepository.deleteById(id);
    }
}
