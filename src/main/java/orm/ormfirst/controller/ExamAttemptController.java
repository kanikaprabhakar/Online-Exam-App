package orm.ormfirst.controller;

import entity.ExamAttempt;
import orm.ormfirst.repository.ExamAttemptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/exam-attempts")
public class ExamAttemptController {
    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    // Add a new exam attempt (static info)
    @PostMapping
    public ResponseEntity<ExamAttempt> addExamAttempt(@RequestBody ExamAttempt attempt) {
        ExamAttempt saved = examAttemptRepository.save(attempt);
        return ResponseEntity.ok(saved);
    }

    // Get exam attempts by student email
    @GetMapping
    public List<ExamAttempt> getAttemptsByEmail(@RequestParam(required = false) String email) {
        if (email != null && !email.isEmpty()) {
            return examAttemptRepository.findByStudentEmail(email);
        } else {
            return examAttemptRepository.findAll();
        }
    }
}