package orm.ormfirst.controller;

import entity.ExamAttempt;
import orm.ormfirst.repository.ExamAttemptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

import java.util.List;

@RestController
@RequestMapping("/api/exams")
@CrossOrigin(origins = "*")
@ConditionalOnProperty(name = "spring.profiles.active", havingValue = "exam-service")
public class ExamServiceController {

    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    @GetMapping("/attempts")
    public ResponseEntity<List<ExamAttempt>> getAllAttempts() {
        // ✅ FIX: Use correct method name with attemptTime
        return ResponseEntity.ok(examAttemptRepository.findAllByOrderByAttemptTimeDesc());
    }

    @GetMapping("/attempts/{studentEmail}")
    public ResponseEntity<List<ExamAttempt>> getStudentAttempts(@PathVariable String studentEmail) {
        // ✅ FIX: Use correct method name with attemptTime
        List<ExamAttempt> attempts = examAttemptRepository.findByStudentEmailOrderByAttemptTimeDesc(studentEmail);
        return ResponseEntity.ok(attempts);
    }

    @GetMapping("/attempts/count")
    public ResponseEntity<Integer> getAttemptsCount() {
        return ResponseEntity.ok((int) examAttemptRepository.count());
    }

    @PostMapping("/attempts")
    public ResponseEntity<ExamAttempt> saveAttempt(@RequestBody ExamAttempt attempt) {
        ExamAttempt saved = examAttemptRepository.save(attempt);
        return ResponseEntity.ok(saved);
    }

    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("Exam Service is running on port 8083");
    }
}
