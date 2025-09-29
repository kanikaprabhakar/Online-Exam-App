package orm.ormfirst.controller;

import entity.Student;
import entity.User;
import entity.ExamAttempt;
import entity.ExamConfig;
import entity.Question;
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

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

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
        List<User> admins = userRepository.findByRoleIgnoreCase("admin");
        model.addAttribute("admins", admins);

        try {
            Long totalStudents = (long) studentRepository.count();
            model.addAttribute("totalStudents", totalStudents);
            
            Long totalQuestions = questionRepository.count();
            model.addAttribute("totalQuestions", totalQuestions);
            
            Integer totalAttempts = restTemplate.getForObject("http://exam-service/api/exams/attempts/count", Integer.class);
            model.addAttribute("totalAttempts", totalAttempts != null ? totalAttempts : 0);
            
        } catch (Exception e) {
            model.addAttribute("totalStudents", studentRepository.count());
            model.addAttribute("totalQuestions", questionRepository.count());
            model.addAttribute("totalAttempts", examAttemptRepository.count());
        }

        return "admin";
    }

    @GetMapping("/profile")
    public String adminProfile(Authentication auth, Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-profile";
    }

    @PostMapping("/update-profile")
    public String updateAdminProfile(Authentication auth,
                                   @RequestParam String name,
                                   @RequestParam String email,
                                   @RequestParam(required = false) String password,
                                   Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        if (currentAdmin != null) {
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
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        if (currentAdmin != null && id.equals(currentAdmin.getId())) {
            return "redirect:/admin?error=cannot-delete-self";
        }
        
        User user = userRepository.findById(id).orElse(null);
        if (user != null && "admin".equalsIgnoreCase(user.getRole())) {
            userRepository.deleteById(id);
        }
        return "redirect:/admin";
    }

    @GetMapping("/students")
    public String adminStudentManagement(Authentication auth, Model model) {
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
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        try {
            // ✅ FIX: Use correct method name and handle empty results
            List<ExamAttempt> allAttempts = examAttemptRepository.findAllByOrderByAttemptTimeDesc();
            
            System.out.println("=== EXAM ATTEMPTS DEBUG ===");
            System.out.println("Found attempts: " + allAttempts.size());
            for (ExamAttempt attempt : allAttempts) {
                System.out.println("Attempt: " + attempt.getStudentEmail() + 
                                 " - Score: " + attempt.getScore() + 
                                 "/" + attempt.getTotalQuestions() + 
                                 " (" + attempt.getPercentage() + "%)");
            }
            
            model.addAttribute("attempts", allAttempts);
            
        } catch (Exception e) {
            System.out.println("Error loading exam attempts: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("attempts", new ArrayList<>());
            model.addAttribute("error", "Error loading exam attempts: " + e.getMessage());
        }
        
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-exam-attempts";
    }

    @GetMapping("/questions")
    public String viewQuestions(Authentication auth, Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        List<Question> allQuestions = questionRepository.findAll();
        ExamConfig examConfig = examConfigRepository.getOrCreateConfig();
        
        model.addAttribute("questions", allQuestions);
        model.addAttribute("currentAdmin", currentAdmin);
        model.addAttribute("examConfig", examConfig); // ✅ ADD: For stats section
        
        // ✅ ADD: Success message handling
        String success = (String) model.asMap().get("success");
        if (success != null) {
            model.addAttribute("success", success);
        }
        
        return "questions";
    }

    @PostMapping("/questions/add")
    public String addQuestion(@RequestParam String question,
                         @RequestParam String option1,
                         @RequestParam String option2,
                         @RequestParam String option3,
                         @RequestParam String option4,
                         @RequestParam String correctAnswer,
                         Model model, Authentication auth) {
        try {
            // ✅ BEST: Create Question object manually for better control
            Question newQuestion = new Question();
            newQuestion.setQuestion(question.trim());
            newQuestion.setOption1(option1.trim());
            newQuestion.setOption2(option2.trim());
            newQuestion.setOption3(option3.trim());
            newQuestion.setOption4(option4.trim());
            newQuestion.setCorrectAnswer(correctAnswer.trim());
            
            // ✅ DEBUG: Log what we're saving
            System.out.println("=== ADDING QUESTION ===");
            System.out.println("Question: " + newQuestion.getQuestion());
            System.out.println("Option1: " + newQuestion.getOption1());
            System.out.println("Option2: " + newQuestion.getOption2());
            System.out.println("Option3: " + newQuestion.getOption3());
            System.out.println("Option4: " + newQuestion.getOption4());
            System.out.println("Correct: " + newQuestion.getCorrectAnswer());
            
            Question savedQuestion = questionRepository.save(newQuestion);
            System.out.println("✅ Question saved with ID: " + savedQuestion.getId());
            
            return "redirect:/admin/questions?success=Question added successfully";
            
        } catch (Exception e) {
            System.out.println("❌ Error saving question: " + e.getMessage());
            e.printStackTrace();
            
            // ✅ Return to form with error message
            String currentAdminEmail = auth.getName();
            User currentAdmin = userRepository.findByEmail(currentAdminEmail);
            
            model.addAttribute("error", "Failed to add question: " + e.getMessage());
            model.addAttribute("questions", questionRepository.findAll());
            model.addAttribute("currentAdmin", currentAdmin);
            model.addAttribute("examConfig", examConfigRepository.getOrCreateConfig());
            
            return "questions";
        }
    }

    @GetMapping("/questions/edit/{id}")
    public String editQuestion(@PathVariable Integer id, Authentication auth, Model model) {
        Question question = questionRepository.findById(id).orElse(new Question());
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        model.addAttribute("question", question);
        model.addAttribute("currentAdmin", currentAdmin);
        return "admin-question-edit";
    }

    @PostMapping("/questions/update")
    public String updateQuestion(@RequestParam Integer id,
                           @RequestParam String question,
                           @RequestParam String option1,
                           @RequestParam String option2,
                           @RequestParam String option3,
                           @RequestParam String option4,
                           @RequestParam String correctAnswer,
                           Model model, Authentication auth) {
    try {
        Question existingQuestion = questionRepository.findById(id).orElse(null);
        if (existingQuestion != null) {
            // ✅ DEBUG: Log the update
            System.out.println("=== UPDATING QUESTION ID: " + id + " ===");
            System.out.println("Old Question: " + existingQuestion.getQuestion());
            System.out.println("New Question: " + question);
            
            // ✅ Update with individual parameters
            existingQuestion.setQuestion(question.trim());
            existingQuestion.setOption1(option1.trim());
            existingQuestion.setOption2(option2.trim());
            existingQuestion.setOption3(option3.trim());
            existingQuestion.setOption4(option4.trim());
            existingQuestion.setCorrectAnswer(correctAnswer.trim());
            
            questionRepository.save(existingQuestion);
            
            System.out.println("✅ Question updated successfully!");
            
            return "redirect:/admin/questions?success=Question updated successfully";
        } else {
            System.out.println("❌ Question not found with ID: " + id);
            return "redirect:/admin/questions?error=Question not found";
        }
        
    } catch (Exception e) {
        System.out.println("❌ Error updating question: " + e.getMessage());
        e.printStackTrace();
        
        // ✅ Return to questions list with error
        return "redirect:/admin/questions?error=Failed to update question: " + e.getMessage();
    }
}

    @GetMapping("/questions/delete/{id}")
    public String deleteQuestion(@PathVariable Integer id) {
        questionRepository.deleteById(id);
        return "redirect:/admin/questions";
    }

    @GetMapping("/exam-config")
    public String examConfig(Authentication auth, Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        Long totalQuestions = questionRepository.count();
        
        model.addAttribute("currentAdmin", currentAdmin);
        model.addAttribute("examConfig", config);
        model.addAttribute("totalQuestions", totalQuestions);
        
        return "exam-config";
    }
    
    @PostMapping("/exam-config/update")
    public String updateExamConfig(@ModelAttribute ExamConfig config, Authentication auth, Model model) {
        String currentAdminEmail = auth.getName();
        User currentAdmin = userRepository.findByEmail(currentAdminEmail);
        
        try {
            ExamConfig existingConfig = examConfigRepository.getOrCreateConfig();
            
            existingConfig.setExamTitle(config.getExamTitle());
            existingConfig.setExamDuration(config.getExamDuration());
            existingConfig.setTotalMarks(config.getTotalMarks());
            existingConfig.setPassingMarks(config.getPassingMarks());
            existingConfig.setQuestionCount(config.getQuestionCount());
            existingConfig.setNegativeMarking(config.getNegativeMarking());
            existingConfig.setExamEnabled(config.getExamEnabled());
            
            examConfigRepository.save(existingConfig);
            model.addAttribute("success", "Exam configuration updated successfully!");
            model.addAttribute("examConfig", existingConfig);
        } catch (Exception e) {
            model.addAttribute("error", "Error updating configuration: " + e.getMessage());
            model.addAttribute("examConfig", config);
        }
        
        model.addAttribute("currentAdmin", currentAdmin);
        return "exam-config";
    }

    @PostMapping("/exam/enable")
    @ResponseBody
    public Map<String, Object> enableExam() {
        Map<String, Object> response = new HashMap<>();
        try {
            ExamConfig config = examConfigRepository.getOrCreateConfig();
            config.setExamEnabled(true);
            examConfigRepository.save(config);
            
            response.put("success", true);
            response.put("message", "Exam enabled successfully!");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error enabling exam: " + e.getMessage());
        }
        return response;
    }

    @PostMapping("/exam/disable")
    @ResponseBody
    public Map<String, Object> disableExam() {
        Map<String, Object> response = new HashMap<>();
        try {
            ExamConfig config = examConfigRepository.getOrCreateConfig();
            config.setExamEnabled(false);
            examConfigRepository.save(config);
            
            response.put("success", true);
            response.put("message", "Exam disabled successfully!");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error disabling exam: " + e.getMessage());
        }
        return response;
    }
}
