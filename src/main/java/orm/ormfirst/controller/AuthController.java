package orm.ormfirst.controller;

import entity.Student;
import entity.User;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/login")
    public String showLogin() {
        return "login";
    }

    @GetMapping("/signup")
    public String showSignup() {
        return "signup";
    }

    // NEW: Admin signup page
    @GetMapping("/admin-signup")
    public String showAdminSignup() {
        return "admin-signup";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, 
                       @RequestParam String password, 
                       HttpServletResponse response, 
                       Model model) {
        
        // Check admin login
        User admin = userRepository.findByEmail(email);
        if (admin != null && passwordEncoder.matches(password, admin.getPassword())) {
            String token = jwtUtil.generateToken(email, "ADMIN");
            addTokenCookie(response, token);
            return "redirect:/admin";
        }

        // Check student login
        Student student = studentRepository.findByEmail(email);
        if (student != null && passwordEncoder.matches(password, student.getPassword())) {
            String token = jwtUtil.generateToken(email, "STUDENT");
            addTokenCookie(response, token);
            return "redirect:/student-dashboard";
        }

        model.addAttribute("error", "Invalid email or password");
        return "login";
    }

    @PostMapping("/signup")
    public String signup(@RequestParam String name,
                        @RequestParam String email,
                        @RequestParam String password,
                        @RequestParam String rollNumber,
                        @RequestParam String phone,
                        @RequestParam String address,
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

        studentRepository.save(student);
        
        model.addAttribute("success", "Registration successful! Please login.");
        return "login";
    }

    // NEW: Admin signup
    @PostMapping("/admin-signup")
    public String adminSignup(@RequestParam String name,
                             @RequestParam String email,
                             @RequestParam String password,
                             @RequestParam String adminCode, // Secret code for admin registration
                             Model model) {
        
        // Secret admin registration code (you can change this)
        String SECRET_ADMIN_CODE = "ADMIN2024";
        
        if (!SECRET_ADMIN_CODE.equals(adminCode)) {
            model.addAttribute("error", "Invalid admin registration code");
            return "admin-signup";
        }
        
        // Check if email already exists
        if (studentRepository.findByEmail(email) != null || userRepository.findByEmail(email) != null) {
            model.addAttribute("error", "Email already exists");
            return "admin-signup";
        }

        // Create new admin
        User admin = new User();
        admin.setName(name);
        admin.setEmail(email);
        admin.setPassword(passwordEncoder.encode(password));
        admin.setRole("admin");

        userRepository.save(admin);
        
        model.addAttribute("success", "Admin registration successful! Please login.");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletResponse response) {
        // Clear the auth cookie
        Cookie cookie = new Cookie("authToken", null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
        return "redirect:/";
    }

    private void addTokenCookie(HttpServletResponse response, String token) {
        Cookie cookie = new Cookie("authToken", token);
        cookie.setHttpOnly(true);
        cookie.setMaxAge(24 * 60 * 60); // 24 hours
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}
