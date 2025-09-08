package orm.ormfirst.controller;

import orm.ormfirst.dao.ExamAttemptDao;
import orm.ormfirst.dao.UserDao;
import Entity.ExamAttempt;
import Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class ExamApiController {
    @Autowired
    private ExamAttemptDao examAttemptDao;
    @Autowired
    private UserDao userDao;

    // 1. View all exam attempts
    @GetMapping("/exam-attempts")
    public List<ExamAttempt> getAllExamAttempts() {
        return examAttemptDao.getAllAttempts();
    }

    // 2. List all students
    @GetMapping("/students")
    public List<User> getAllStudents() {
        return userDao.getAllUsers().stream()
                .filter(u -> "student".equalsIgnoreCase(u.getRole()))
                .collect(Collectors.toList());
    }

    // 3. View personal exam attempts by email
    @GetMapping("/exam-attempts/{email}")
    public List<ExamAttempt> getExamAttemptsByEmail(@PathVariable String email) {
        return examAttemptDao.getAllAttempts().stream()
                .filter(a -> a.getStudentEmail().equalsIgnoreCase(email))
                .collect(Collectors.toList());
    }
}
