package orm.ormfirst.controller;

import entity.ExamAttempt;
import orm.ormfirst.repository.ExamAttemptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/exam-attempts")
public class ExamAttemptController {

    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    // Add a new exam attempt (static info)
    @PostMapping
    public ResponseEntity<ExamAttempt> addExamAttempt(@RequestBody ExamAttempt attempt) {
        ExamAttempt saved = examAttemptRepository.save(attempt);
        return ResponseEntity.ok(saved);
    }

    // Get all exam attempts (admin)
    @GetMapping
    public List<ExamAttempt> getAllExamAttempts() {
        return examAttemptRepository.findAll();
    }

    // Get exam attempts by student email
    @GetMapping("/student/{email}")
    public List<ExamAttempt> getAttemptsByEmail(@PathVariable String email) {
        return examAttemptRepository.findByStudentEmail(email);
    }
}