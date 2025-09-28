package orm.ormfirst.controller;

import entity.Student;
import entity.User;
import entity.ExamAttempt;
import entity.ExamConfig;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.repository.ExamAttemptRepository;
import orm.ormfirst.repository.ExamConfigRepository;
import orm.ormfirst.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminMvcController {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private ExamAttemptRepository examAttemptRepository;
    
    @Autowired
    private ExamConfigRepository examConfigRepository;
    
    @Autowired
    private QuestionRepository questionRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private RestTemplate restTemplate;

    @GetMapping("")
    public String adminDashboard(Authentication auth, Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        model.addAttribute("currentAdmin", currentAdmin);

        // Get statistics from microservices
        try {
            Long totalStudents = (long) studentRepository.count();
            model.addAttribute("totalStudents", totalStudents);
            
            // USE LOCAL QUESTION REPO INSTEAD OF REST CALL
            Long totalQuestions = questionRepository.count();
            model.addAttribute("totalQuestions", totalQuestions);
            
            // Call Exam Service
            Integer totalAttempts = restTemplate.getForObject("http://exam-service/api/exams/attempts/count", Integer.class);
            model.addAttribute("totalAttempts", totalAttempts != null ? totalAttempts : 0);
            
        } catch (Exception e) {
            model.addAttribute("totalStudents", studentRepository.count());
            model.addAttribute("totalQuestions", questionRepository.count()); // FIX THIS
            model.addAttribute("totalAttempts", examAttemptRepository.count());  // ADD LOCAL FALLBACK
        }

        return "admin";
    }

    // Self-update profile page
    @GetMapping("/profile")
    public String adminProfile(Authentication auth, Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-profile";
    }

    // Update own profile
    @PostMapping("/update-profile")
    public String updateAdminProfile(Authentication auth,
                                   @RequestParam String name,
                                   @RequestParam String email,
                                   @RequestParam(required = false) String password,
                                   Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        if (currentAdmin != null) {
            // Safer email check - compare by email instead of ID
            User existingUser = userRepository.findByEmail(email);
            if (existingUser != null && !currentAdminEmail.equals(email)) {
                model.addAttribute("currentAdmin", currentAdmin);
                model.addAttribute("error", "Email already exists!");
                return "admin-profile";
            }
            
            currentAdmin.setName(name);
            currentAdmin.setEmail(email);
            if (password != null && !password.trim().isEmpty()) {
                currentAdmin.setPassword(passwordEncoder.encode(password));
            }
            userRepository.save(currentAdmin);
            model.addAttribute("success", "Profile updated successfully!");
        }
        
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-profile";
    }

    @PostMapping("/register")
    public String registerAdmin(@ModelAttribute User user) {
        user.setRole("admin");
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        userRepository.save(user);
        return "redirect:/admin";
    }

    @GetMapping("/edit-admin/{id}")
    public String editAdmin(@PathVariable Integer id, Authentication auth, Model model) {
        User admin = userRepository.findById(id).orElse(new User());
        
        // Get current admin for display
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        model.addAttribute("user", admin);
        model.addAttribute("admins", userRepository.findByRoleIgnoreCase("admin"));
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin";
    }

    @PostMapping("/update-admin")
    public String updateAdmin(@ModelAttribute User user) {
        User existingUser = userRepository.findById(user.getId()).orElse(null);
        if (existingUser != null) {
            existingUser.setName(user.getName());
            existingUser.setEmail(user.getEmail());
            if (!user.getPassword().isEmpty()) {
                existingUser.setPassword(passwordEncoder.encode(user.getPassword()));
            }
            existingUser.setRole("admin");
            userRepository.save(existingUser);
        }
        return "redirect:/admin";
    }

    @GetMapping("/delete-admin/{id}")
    public String deleteAdmin(@PathVariable Integer id, Authentication auth) {
        // Prevent admin from deleting themselves
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        // Use ID comparison with proper null check
        if (currentAdmin != null && id.equals(currentAdmin.getId())) {
            return "redirect:/admin?error=cannot-delete-self";
        }
        
        // Additional safety check - only delete if user is admin
        User user = userRepository.findById(id).orElse(null);
        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            userRepository.deleteById(id);
        }
        return "redirect:/admin";
    }

    // Student management by admin
    @GetMapping("/students")
    public String adminStudentManagement(Authentication auth, Model model) {
        // Get current admin for display
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        model.addAttribute("students", studentRepository.findAll());
        model.addAttribute("student", new Student());
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-students";
    }

    @PostMapping("/students/add")
    public String addStudent(@ModelAttribute Student student) {
        student.setRole("STUDENT");
        student.setPassword(passwordEncoder.encode(student.getPassword()));
        studentRepository.save(student);
        return "redirect:/admin/students";
    }

    @GetMapping("/students/edit/{id}")
    public String editStudent(@PathVariable Integer id, Authentication auth, Model model) {
        Student student = studentRepository.findById(id).orElse(new Student());
        
        // Get current admin for display
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        model.addAttribute("student", student);
        model.addAttribute("students", studentRepository.findAll());
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-students";
    }

    @PostMapping("/students/update")
    public String updateStudent(@ModelAttribute Student student) {
        Student existingStudent = studentRepository.findById(student.getStudentId()).orElse(null);
        if (existingStudent != null) {
            existingStudent.setName(student.getName());
            existingStudent.setEmail(student.getEmail());
            existingStudent.setRollNumber(student.getRollNumber());
            existingStudent.setPhone(student.getPhone());
            existingStudent.setAddress(student.getAddress());
            if (!student.getPassword().isEmpty()) {
                existingStudent.setPassword(passwordEncoder.encode(student.getPassword()));
            }
            studentRepository.save(existingStudent);
        }
        return "redirect:/admin/students";
    }

    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Integer id) {
        studentRepository.deleteById(id);
        return "redirect:/admin/students";
    }

    @GetMapping("/exam-attempts")
    public String viewAllExamAttempts(Authentication auth, Model model) {
        // Get current admin for display
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        // ✅ FIX: Use correct method name with attemptTime
        List<ExamAttempt> allAttempts = examAttemptRepository.findAllByOrderByAttemptTimeDesc();
        
        model.addAttribute("attempts", allAttempts);
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-exam-attempts";
    }

    @GetMapping("/exam-config")
    public String examConfig(Model model) {
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        model.addAttribute("config", config);
        
        // Also get total questions available
        long totalQuestions = questionRepository.count();
        model.addAttribute("totalQuestions", totalQuestions);
        
        return "exam-config";
    }

    @PostMapping("/exam-config")
    public String updateExamConfig(@RequestParam boolean examEnabled,
                                  @RequestParam int questionCount,
                                  @RequestParam String examTitle,
                                  @RequestParam int examDurationMinutes,
                                  Model model) {
        
        System.out.println("=== UPDATE EXAM CONFIG ===");
        System.out.println("Exam Enabled: " + examEnabled);
        System.out.println("Question Count: " + questionCount);
        System.out.println("Exam Title: " + examTitle);
        System.out.println("Duration: " + examDurationMinutes + " minutes");
        
        // Validate question count
        long totalQuestions = questionRepository.count();
        if (questionCount > totalQuestions) {
            model.addAttribute("error", "Cannot set " + questionCount + " questions. Only " + totalQuestions + " questions available in database.");
            ExamConfig config = examConfigRepository.getOrCreateConfig();
            model.addAttribute("config", config);
            model.addAttribute("totalQuestions", totalQuestions);
            return "exam-config";
        }
        
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        config.setExamEnabled(examEnabled);
        config.setQuestionCount(Math.min(questionCount, (int)totalQuestions));
        config.setExamTitle(examTitle);
        config.setExamDurationMinutes(examDurationMinutes);
        
        examConfigRepository.save(config);
        
        model.addAttribute("success", "Exam configuration updated successfully!");
        model.addAttribute("config", config);
        model.addAttribute("totalQuestions", totalQuestions);
        
        return "exam-config";
    }
}
