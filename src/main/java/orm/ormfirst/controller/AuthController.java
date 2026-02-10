package orm.ormfirst.controller;

import Entity.Student;
import Entity.User;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired 
    private StudentRepository studentRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials) {
        String email = credentials.get("email");
        String password = credentials.get("password");
    
        System.out.println("=== LOGIN API CALLED ===");
        System.out.println("Email: " + email);
    
        try {
            User user = userRepository.findByEmail(email);
            Student student = studentRepository.findByEmail(email);
            
            String userRole = null;
            String hashedPassword = null;
            
            if (user != null) {
                userRole = user.getRole();
                hashedPassword = user.getPassword();
            } else if (student != null) {
                userRole = "STUDENT";
                hashedPassword = student.getPassword();
            }
            
            if (userRole != null && passwordEncoder.matches(password, hashedPassword)) {
                String token = jwtUtil.generateToken(email, userRole);
                
                Map<String, String> response = new HashMap<>();
                response.put("token", token);
                response.put("role", userRole);
                response.put("email", email);
                
                return ResponseEntity.ok(response);
            } else {
                Map<String, String> errorResponse = new HashMap<>();
                errorResponse.put("error", "Invalid email or password");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(errorResponse);
            }
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
            e.printStackTrace();
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Login failed");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@RequestBody Map<String, String> signupData) {
        String email = signupData.get("email");
        
        if (studentRepository.findByEmail(email) != null || userRepository.findByEmail(email) != null) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Email already exists");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }

        Student student = new Student();
        student.setName(signupData.get("name"));
        student.setEmail(email);
        student.setPassword(passwordEncoder.encode(signupData.get("password")));
        student.setRollNumber(signupData.get("rollNumber"));
        student.setPhone(signupData.get("phone"));
        student.setAddress(signupData.get("address"));
        student.setRole("STUDENT");

        studentRepository.save(student);
        
        String token = jwtUtil.generateToken(email, "STUDENT");
        
        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        response.put("role", "STUDENT");
        response.put("email", email);
        response.put("message", "Student registered successfully");
        
        return ResponseEntity.ok(response);
    }

    @PostMapping("/admin-signup")
    public ResponseEntity<?> adminSignup(@RequestBody Map<String, String> signupData) {
        String email = signupData.get("email");
        
        if (studentRepository.findByEmail(email) != null || userRepository.findByEmail(email) != null) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("error", "Email already exists");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorResponse);
        }

        User admin = new User();
        admin.setName(signupData.get("name"));
        admin.setEmail(email);
        admin.setPassword(passwordEncoder.encode(signupData.get("password")));
        admin.setRole("ADMIN");

        userRepository.save(admin);
        
        String token = jwtUtil.generateToken(email, "ADMIN");
        
        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        response.put("role", "ADMIN");
        response.put("email", email);
        response.put("message", "Admin registered successfully");
        
        return ResponseEntity.ok(response);
    }
}
