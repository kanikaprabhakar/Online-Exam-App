package orm.ormfirst.controller;

import Entity.ExamConfig;
import Entity.User;
import Entity.Student;
import Entity.ExamAttempt;
import orm.ormfirst.repository.ExamConfigRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.ExamAttemptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/student-dashboard")
public class StudentDashboardController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private ExamConfigRepository examConfigRepository;
    
    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    @GetMapping("")
    public String studentDashboard(Authentication auth, Model model, 
                                  @RequestParam(required = false) String success,
                                  @RequestParam(required = false) String error) {
        String currentStudentEmail = auth.getName();
        User currentUser = userRepository.findByEmail(currentStudentEmail);
        
        // ✅ FIX: Get the actual Student object by email
        Student currentStudent = studentRepository.findByEmail(currentStudentEmail);
        
        // If no Student record exists, create a basic one from User
        if (currentStudent == null && currentUser != null) {
            currentStudent = new Student();
            currentStudent.setName(currentUser.getName());
            currentStudent.setEmail(currentUser.getEmail());
            // Set other fields to defaults or empty
            currentStudent.setRollNumber("N/A");
            currentStudent.setPhone("N/A");
            currentStudent.setAddress("N/A");
        }
        
        // Get all exam configurations for multi-exam support
        List<ExamConfig> allExams = examConfigRepository.findAll();
        
        // Build exam status for each exam
        List<Map<String, Object>> examStatusList = new ArrayList<>();
        for (ExamConfig exam : allExams) {
            Map<String, Object> examStatus = new HashMap<>();
            examStatus.put("exam", exam);
            
            // Check if student has taken this specific exam
            List<ExamAttempt> attempts = examAttemptRepository.findByStudentEmailAndExamConfigId(
                currentStudentEmail, exam.getId()
            );
            boolean hasTaken = !attempts.isEmpty();
            examStatus.put("hasTaken", hasTaken);
            
            // Determine if exam is available (enabled and not yet taken)
            boolean isAvailable = exam.isExamEnabled() && !hasTaken;
            examStatus.put("isAvailable", isAvailable);
            
            examStatusList.add(examStatus);
        }
        
        model.addAttribute("student", currentStudent);
        model.addAttribute("user", currentUser);
        model.addAttribute("examStatusList", examStatusList);
        
        if (success != null) {
            model.addAttribute("success", success);
        }
        
        if (error != null) {
            model.addAttribute("error", error);
        }
        
        return "student-dashboard";
    }
    
    // ✅ MAKE SURE: Profile page mapping exists
    @GetMapping("/profile")
    public String studentProfile(Authentication auth, Model model) {
        String currentStudentEmail = auth.getName();
        User currentUser = userRepository.findByEmail(currentStudentEmail);
        Student currentStudent = studentRepository.findByEmail(currentStudentEmail);
        
        if (currentStudent == null && currentUser != null) {
            currentStudent = new Student();
            currentStudent.setName(currentUser.getName());
            currentStudent.setEmail(currentUser.getEmail());
            currentStudent.setRollNumber("");
            currentStudent.setPhone("");
            currentStudent.setAddress("");
        }
        
        model.addAttribute("student", currentStudent);
        model.addAttribute("user", currentUser);
        
        return "student-profile";
    }
    
    // ✅ MAKE SURE: Profile update mapping exists - only phone and address
    @PostMapping("/profile/update")
    public String updateStudentProfile(@ModelAttribute Student student, Authentication auth, Model model) {
        String currentStudentEmail = auth.getName();
        
        try {
            Student existingStudent = studentRepository.findByEmail(currentStudentEmail);
            if (existingStudent != null) {
                // Only update phone and address
                existingStudent.setPhone(student.getPhone());
                existingStudent.setAddress(student.getAddress());
                studentRepository.save(existingStudent);
            }
            model.addAttribute("success", "Profile updated successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating profile: " + e.getMessage());
        }
        
        // Redirect to dashboard with success message
        return "redirect:/student-dashboard?success=Profile+updated+successfully";
    }
}
