package orm.ormfirst.controller;

import Entity.ExamConfig;
import Entity.User;
import Entity.Student;
import orm.ormfirst.repository.ExamConfigRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/student-dashboard")
public class StudentDashboardController {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private StudentRepository studentRepository;
    
    @Autowired
    private ExamConfigRepository examConfigRepository;

    @GetMapping("")
    public String studentDashboard(Authentication auth, Model model) {
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
        
        // Get exam configuration
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        
        model.addAttribute("student", currentStudent); // ✅ Now it's a Student object
        model.addAttribute("user", currentUser); // ✅ Also add User for other uses
        model.addAttribute("config", config);
        
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
    
    // ✅ MAKE SURE: Profile update mapping exists
    @PostMapping("/profile/update")
    public String updateStudentProfile(@ModelAttribute Student student, Authentication auth, Model model) {
        String currentStudentEmail = auth.getName();
        User currentUser = userRepository.findByEmail(currentStudentEmail);
        
        student.setEmail(currentStudentEmail);
        
        try {
            Student existingStudent = studentRepository.findByEmail(currentStudentEmail);
            if (existingStudent != null) {
                existingStudent.setName(student.getName());
                existingStudent.setRollNumber(student.getRollNumber());
                existingStudent.setPhone(student.getPhone());
                existingStudent.setAddress(student.getAddress());
                studentRepository.save(existingStudent);
                model.addAttribute("student", existingStudent);
            } else {
                Student savedStudent = studentRepository.save(student);
                model.addAttribute("student", savedStudent);
            }
            model.addAttribute("success", "Profile updated successfully!");
        } catch (Exception e) {
            model.addAttribute("error", "Error updating profile: " + e.getMessage());
            model.addAttribute("student", student);
        }
        
        model.addAttribute("user", currentUser);
        return "student-profile";
    }
}
