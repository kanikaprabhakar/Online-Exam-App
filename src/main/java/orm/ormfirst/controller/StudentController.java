package orm.ormfirst.controller;

import entity.User;
import entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.repository.StudentRepository;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private StudentRepository studentRepository;

    @GetMapping("")
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    // DTO for registration
    static class RegistrationRequest {
        public String name;
        public String email;
        public String password;
        public String rollNumber;
        public String phone;
        public String address;
        public String role; // "admin" or "student"
    }

    // Student registration
    @PostMapping("/register-student")
    public ResponseEntity<?> registerStudent(@RequestBody RegistrationRequest req) {
        if (!"student".equalsIgnoreCase(req.role)) {
            return ResponseEntity.badRequest().body(Map.of("error", "Role must be 'student'"));
        }
        Student student = new Student();
        student.setName(req.name);
        student.setEmail(req.email);
        student.setRollNumber(req.rollNumber);
        student.setPhone(req.phone);
        student.setAddress(req.address);
        studentRepository.save(student);
        return ResponseEntity.ok(Map.of("message", "Student registered successfully"));
    }

    // Admin registration
    @PostMapping("/register-admin")
    public ResponseEntity<?> registerAdmin(@RequestBody RegistrationRequest req) {
        if (!"admin".equalsIgnoreCase(req.role)) {
            return ResponseEntity.badRequest().body(Map.of("error", "Role must be 'admin'"));
        }
        User user = new User();
        user.setName(req.name);
        user.setEmail(req.email);
        user.setPassword(req.password);
        user.setRole("admin");
        userRepository.save(user);
        return ResponseEntity.ok(Map.of("message", "Admin registered successfully"));
    }
}
