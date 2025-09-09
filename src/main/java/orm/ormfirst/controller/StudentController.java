package orm.ormfirst.controller;

import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import orm.ormfirst.repository.UserRepository;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("")
    public List<User> getAllStudents() {
        return userRepository.findAll().stream()
            .filter(u -> "student".equalsIgnoreCase(u.getRole()))
            .collect(Collectors.toList());
    }

    // DTO for registration
    static class RegistrationRequest {
        public String name;
        public String email;
        public String password;
        public String role; // "admin" or "student"
    }

    // Student registration
    @PostMapping("/register-student")
    public ResponseEntity<?> registerStudent(@RequestBody RegistrationRequest req) {
        if (!"student".equalsIgnoreCase(req.role)) {
            return ResponseEntity.badRequest().body(Map.of("error", "Role must be 'student'"));
        }
        User user = new User();
        user.setName(req.name);
        user.setEmail(req.email);
        user.setPassword(req.password);
        user.setRole("student");
        userRepository.save(user);
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
