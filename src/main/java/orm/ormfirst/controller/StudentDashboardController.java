package orm.ormfirst.controller;

import entity.Student;
import entity.ExamConfig;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.ExamConfigRepository;
import orm.ormfirst.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class StudentDashboardController {

    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    private ExamConfigRepository examConfigRepository;
    
    @Autowired  
    private QuestionRepository questionRepository;

    @GetMapping("/student-dashboard")
    public String studentDashboard(Authentication auth, Model model) {
        String email = auth.getName();
        Student student = studentRepository.findByEmail(email);
        
        if (student == null) {
            return "redirect:/login?error=student_not_found";
        }
        
        model.addAttribute("student", student);
        
        // ✅ ADD EXAM CONFIG INFO
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        model.addAttribute("config", config);
        
        long totalQuestions = questionRepository.count();
        model.addAttribute("totalQuestionsInDb", totalQuestions);
        
        return "student-dashboard";
    }
    
    @GetMapping("/student-profile")
    public String studentProfile(Authentication auth, Model model) {
        String email = auth.getName();
        Student student = studentRepository.findByEmail(email);
        model.addAttribute("student", student);
        return "student-profile";
    }
    
    @PostMapping("/update-student-profile")
    public String updateStudentProfile(Authentication auth,
                                     @RequestParam String name,
                                     @RequestParam String email,
                                     @RequestParam String rollNumber,
                                     @RequestParam String phone,
                                     @RequestParam String address,
                                     @RequestParam(required = false) String password,
                                     Model model) {
        String currentEmail = auth.getName();
        Student currentStudent = studentRepository.findByEmail(currentEmail);
        
        if (currentStudent != null) {
            // Check if new email already exists (and it's not the current user's email)
            Student existingStudent = studentRepository.findByEmail(email);
            if (existingStudent != null && !existingStudent.getStudentId().equals(currentStudent.getStudentId())) {
                model.addAttribute("student", currentStudent);
                model.addAttribute("error", "Email already exists!");
                return "student-profile";
            }
            
            currentStudent.setName(name);
            currentStudent.setEmail(email);
            currentStudent.setRollNumber(rollNumber);
            currentStudent.setPhone(phone);
            currentStudent.setAddress(address);
            if (password != null && !password.trim().isEmpty()) {
                currentStudent.setPassword(passwordEncoder.encode(password));
            }
            studentRepository.save(currentStudent);
            model.addAttribute("success", "Profile updated successfully!");
        }
        
        model.addAttribute("student", currentStudent);
        return "student-profile";
    }
}
