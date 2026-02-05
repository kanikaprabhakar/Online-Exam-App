package orm.ormfirst.controller;

import Entity.Student;
import Entity.User;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.security.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @Autowired 
    private StudentRepository studentRepository;  // ✅ ADD THIS

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private JwtUtil jwtUtil;

    @GetMapping("/login")
    public String showLogin(@RequestParam(required = false) String error,
                       @RequestParam(required = false) String logout,
                       HttpServletRequest request,
                       HttpServletResponse response,
                       Model model) {
    
        System.out.println("=== LOGIN GET ==="); // ✅ DEBUG
        System.out.println("Error param: " + error); // ✅ DEBUG
        System.out.println("Logout param: " + logout); // ✅ DEBUG
    
        // Clear any existing JWT cookie
        Cookie jwtCookie = new Cookie("authToken", "");
        jwtCookie.setHttpOnly(true);
        jwtCookie.setMaxAge(0);
        jwtCookie.setPath("/");
        response.addCookie(jwtCookie);
    
        SecurityContextHolder.clearContext();
    
        if (error != null) {
            if ("authentication_required".equals(error)) {
                model.addAttribute("error", "Please login to continue");
            } else if ("access_denied".equals(error)) {
                model.addAttribute("error", "Access denied. Please check your permissions.");
            } else {
                model.addAttribute("error", "Invalid username or password");
            }
        }
    
        if (logout != null) {
            model.addAttribute("message", "You have been logged out successfully");
        }
    
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
    public String loginPost(@RequestParam String email, 
                       @RequestParam String password,
                       HttpServletResponse response, 
                       Model model) {
    
        System.out.println("=== LOGIN POST CALLED ===");
        System.out.println("Email: " + email);
    
        try {
            // ✅ CHECK BOTH TABLES
            User user = userRepository.findByEmail(email);
            Student student = studentRepository.findByEmail(email);
            
            String userRole = null;
            String hashedPassword = null;
            
            if (user != null) {
                // Admin/User login
                userRole = user.getRole();
                hashedPassword = user.getPassword();
                System.out.println("Found in users table - Role: " + userRole);
            } else if (student != null) {
                // Student login
                userRole = "STUDENT";  // Students always have STUDENT role
                hashedPassword = student.getPassword();
                System.out.println("Found in students table - Role: STUDENT");
            }
            
            if (userRole != null && passwordEncoder.matches(password, hashedPassword)) {
                System.out.println("Login successful for: " + email);
                
                String token = jwtUtil.generateToken(email, userRole);
                
                Cookie jwtCookie = new Cookie("authToken", token);
                jwtCookie.setHttpOnly(true);
                jwtCookie.setMaxAge(24 * 60 * 60);
                jwtCookie.setPath("/");
                response.addCookie(jwtCookie);
                
                if ("ADMIN".equalsIgnoreCase(userRole)) {
                    System.out.println("=== ADMIN LOGIN SUCCESS ===");
                    System.out.println("User role: " + userRole);
                    System.out.println("JWT token role: " + jwtUtil.getRoleFromToken(token));
                    System.out.println("Redirecting to admin dashboard");
                    return "redirect:/admin";
                } else {
                    System.out.println("Redirecting to student dashboard");
                    return "redirect:/student-dashboard";
                }
            } else {
                System.out.println("Login failed for: " + email);
                model.addAttribute("error", "Invalid email or password");
                return "login";
            }
        } catch (Exception e) {
            System.out.println("Login error: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Login failed");
            return "login";
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
        
        return "redirect:/student/dashboard";
    }

    // NEW: Admin signup
    @PostMapping("/admin-signup")
    public String adminSignup(@RequestParam String name,
                             @RequestParam String email,
                             @RequestParam String password,
                             @RequestParam String adminCode,
                             HttpServletResponse response,
                             Model model) {
        
        String SECRET_ADMIN_CODE = "ADMIN2024";
        
        if (!SECRET_ADMIN_CODE.equals(adminCode)) {
            model.addAttribute("error", "Invalid admin registration code");
            return "admin-signup";
        }
        
        if (studentRepository.findByEmail(email) != null || userRepository.findByEmail(email) != null) {
            model.addAttribute("error", "Email already exists");
            return "admin-signup";
        }

        User admin = new User();
        admin.setName(name);
        admin.setEmail(email);
        admin.setPassword(passwordEncoder.encode(password));
        admin.setRole("ADMIN");  // ✅ CHANGE FROM "admin" TO "ADMIN"

        userRepository.save(admin);
        
        // Auto-login after admin signup
        String token = jwtUtil.generateToken(email, "ADMIN");
        Cookie cookie = new Cookie("authToken", token);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(24 * 60 * 60); // 24 hours
        response.addCookie(cookie);
        
        return "redirect:/admin/dashboard";
    }

    @GetMapping("/logout")  // ✅ Changed from /auth/logout to /logout
    public String logout(HttpServletResponse response) {
        Cookie jwtCookie = new Cookie("authToken", "");
        jwtCookie.setHttpOnly(true);
        jwtCookie.setMaxAge(0);
        jwtCookie.setPath("/");
        response.addCookie(jwtCookie);
        SecurityContextHolder.clearContext();
        return "redirect:/login?logout=success";
    }

    @PostMapping("/logout")  // ✅ Changed from /auth/logout to /logout
    public String logoutPost(HttpServletResponse response) {
        return logout(response);
    }

    private void addTokenCookie(HttpServletResponse response, String token) {
        Cookie cookie = new Cookie("authToken", token);
        cookie.setHttpOnly(true);
        cookie.setMaxAge(24 * 60 * 60); // 24 hours
        cookie.setPath("/");
        response.addCookie(cookie);
    }

    @GetMapping("/test-auth")
    @ResponseBody
    public String testAuth() {
        return "Auth controller is working!";
    }
}
