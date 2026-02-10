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
import org.springframework.ui.Model;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
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
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid email or password");
            }
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Login failed");
        }
    }

    @PostMapping("/signup")
    public String signup(@RequestParam String name,
                        @RequestParam String email,
                        @RequestParam String password,
                        @RequestParam String rollNumber,
                        @RequestParam String phone,
                        @RequestParam String address,
                        HttpServletResponse response,
                        Model model) {
        
        // Check if student already exists
        if (studentRepository.findByEmail(email) != null || userRepository.findByEmail(email) != null) {
            model.addAttribute("error", "Email already exists");
            return "signup";
        }

        // Create new student
        Student student = new Student();
        student.setName(name);
        student.setEmail(email);
        student.setPassword(passwordEncoder.encode(password));
        student.setRollNumber(rollNumber);
        student.setPhone(phone);
        student.setAddress(address);
        student.setRole("STUDENT");

        Student savedStudent = studentRepository.save(student);
        
        // Auto-login after signup
        String token = jwtUtil.generateToken(email, "STUDENT");
        Cookie cookie = new Cookie("authToken", token);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(24 * 60 * 60); // 24 hours
        response.addCookie(cookie);
        
        return "redirect:/student-dashboard";
    }

    @PostMapping("/admin-signup")
    public ResponseEntity<?> adminSignup(@RequestBody Map<String, String> signupData) {
        String email = signupData.get("email");
        
        if (studentRepository.findByEmail(email) != null || userRepository.findByEmail(email) != null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Email already exists");
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