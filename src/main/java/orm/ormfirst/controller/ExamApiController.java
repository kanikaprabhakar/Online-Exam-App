package orm.ormfirst.controller;

import orm.ormfirst.repository.ExamAttemptRepository;
import orm.ormfirst.repository.UserRepository;
import entity.ExamAttempt;
import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class ExamApiController {
    @Autowired
    private ExamAttemptRepository examAttemptRepository;
    @Autowired
    private UserRepository userRepository;

    // 1. View all exam attempts
    @GetMapping("/exam-attempts")
    public List<ExamAttempt> getAllExamAttempts() {
        return examAttemptRepository.findAll();
    }

    // 2. List all students
    @GetMapping("/all-students")
    public List<User> getAllStudents() {
        return userRepository.findAll().stream()
                .filter(u -> "student".equalsIgnoreCase(u.getRole()))
                .collect(Collectors.toList());
    }

    // 3. View personal exam attempts by email
    @GetMapping("/exam-attempts/{email}")
    public List<ExamAttempt> getExamAttemptsByEmail(@PathVariable String email) {
        return examAttemptRepository.findAll().stream()
                .filter(a -> a.getStudentEmail().equalsIgnoreCase(email))
                .collect(Collectors.toList());
    }
}
