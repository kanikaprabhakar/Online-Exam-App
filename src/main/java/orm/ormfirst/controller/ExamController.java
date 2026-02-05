package orm.ormfirst.controller;

import Entity.ExamAttempt;
import Entity.Question;
import Entity.Student;
import Entity.ExamConfig;
import Entity.User; // ✅ ADD: Import User entity
import orm.ormfirst.repository.ExamAttemptRepository;
import orm.ormfirst.repository.QuestionRepository;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.ExamConfigRepository;
import orm.ormfirst.repository.UserRepository; // ✅ ADD: Import UserRepository
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/exam")
public class ExamController {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    @Autowired
    private ExamConfigRepository examConfigRepository;
    
    // ✅ ADD: UserRepository injection
    @Autowired
    private UserRepository userRepository;

    // Start exam
    @GetMapping("/start")
    public String startExam(Authentication auth, Model model) {
        // Get exam configuration
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        
        // Check if exam is enabled
        if (!config.isExamEnabled()) {
            model.addAttribute("error", "Exam is currently disabled. Please contact administrator.");
            return "student-dashboard";
        }
        
        // Get current student
        String currentStudentEmail = auth.getName();
        User currentStudent = userRepository.findByEmail(currentStudentEmail);
        
        // Add all necessary attributes
        model.addAttribute("student", currentStudent);
        model.addAttribute("config", config);
        model.addAttribute("examConfig", config); // Alias for compatibility
        
        return "exam-instructions";
    }

    @GetMapping("/instructions")
    public String examInstructions(Authentication auth, Model model) {
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        String currentStudentEmail = auth.getName();
        User currentStudent = userRepository.findByEmail(currentStudentEmail);
        
        model.addAttribute("student", currentStudent);
        model.addAttribute("config", config);
        model.addAttribute("examConfig", config);
        
        return "exam-instructions";
    }

    // Show current question
    @GetMapping("/question")
    @PreAuthorize("hasRole('STUDENT')")
    public String examQuestion(Authentication auth, HttpSession session, Model model) {
        // Get current student
        String email = auth.getName();
        Student student = studentRepository.findByEmail(email);
        
        if (student == null) {
            return "redirect:/login?error=student_not_found";
        }
        
        // Get exam configuration
        ExamConfig config = examConfigRepository.getOrCreateConfig();
        
        if (!config.isExamEnabled()) {
            model.addAttribute("error", "Exam has been disabled.");
            return "student-dashboard";
        }
        
        // Get or create exam questions for this session
        @SuppressWarnings("unchecked")
        List<Question> examQuestions = (List<Question>) session.getAttribute("examQuestions");
        
        if (examQuestions == null) {
            // First time - generate random questions
            List<Question> allQuestions = questionRepository.findAll();
            Collections.shuffle(allQuestions);
            examQuestions = allQuestions.stream()
                    .limit(config.getQuestionCount())
                    .collect(Collectors.toList());
            
            session.setAttribute("examQuestions", examQuestions);
            session.setAttribute("studentAnswers", new ArrayList<String>());
            session.setAttribute("currentQuestionIndex", 0);
            session.setAttribute("examStartTime", LocalDateTime.now());
            
            System.out.println("=== EXAM STARTED ===");
            System.out.println("Student: " + student.getName());
            System.out.println("Questions generated: " + examQuestions.size());
        }
        
        // Get current question index
        Integer currentIndex = (Integer) session.getAttribute("currentQuestionIndex");
        if (currentIndex == null) currentIndex = 0;
        
        // Check if exam is completed
        if (currentIndex >= examQuestions.size()) {
            return "redirect:/exam/submit";
        }
        
        Question currentQuestion = examQuestions.get(currentIndex);
        
        // Add all data to model
        model.addAttribute("student", student);
        model.addAttribute("config", config);
        model.addAttribute("question", currentQuestion);
        model.addAttribute("currentIndex", currentIndex);
        model.addAttribute("totalQuestions", examQuestions.size());
        model.addAttribute("questionsRemaining", examQuestions.size() - currentIndex);
        
        System.out.println("=== SHOWING QUESTION ===");
        System.out.println("Question " + (currentIndex + 1) + ": " + currentQuestion.getQuestion());
        System.out.println("Options: " + currentQuestion.getOption1() + ", " + currentQuestion.getOption2() + 
                          ", " + currentQuestion.getOption3() + ", " + currentQuestion.getOption4());
        
        return "exam-question";
    }

    // Save answer and go to next question
    @PostMapping("/answer")
    @PreAuthorize("hasRole('STUDENT')")
    @ResponseBody
    public String saveAnswer(@RequestParam Integer questionIndex, 
                           @RequestParam String selectedAnswer, 
                           HttpSession session) {
        
        @SuppressWarnings("unchecked")
        List<String> studentAnswers = (List<String>) session.getAttribute("studentAnswers");
        
        if (studentAnswers == null) {
            studentAnswers = new ArrayList<>();
            session.setAttribute("studentAnswers", studentAnswers);
        }
        
        // Ensure list is large enough
        while (studentAnswers.size() <= questionIndex) {
            studentAnswers.add("");
        }
        
        // Save the answer
        studentAnswers.set(questionIndex, selectedAnswer);
        
        // Move to next question
        session.setAttribute("currentQuestionIndex", questionIndex + 1);
        
        System.out.println("=== ANSWER SAVED ===");
        System.out.println("Question " + (questionIndex + 1) + " Answer: " + selectedAnswer);
        
        return "Answer saved successfully";
    }

    // Submit exam
    @GetMapping("/submit")
    @PreAuthorize("hasRole('STUDENT')")
    public String submitExam(Authentication auth, HttpSession session, Model model) {
        // Get current student
        String email = auth.getName();
        Student student = studentRepository.findByEmail(email);
        
        @SuppressWarnings("unchecked")
        List<Question> examQuestions = (List<Question>) session.getAttribute("examQuestions");
        @SuppressWarnings("unchecked")
        List<String> studentAnswers = (List<String>) session.getAttribute("studentAnswers");
        LocalDateTime examStartTime = (LocalDateTime) session.getAttribute("examStartTime");
        
        if (examQuestions == null || studentAnswers == null) {
            model.addAttribute("error", "No exam data found. Please start the exam again.");
            return "student-dashboard";
        }
        
        // Calculate score
        int correctAnswers = 0;
        for (int i = 0; i < examQuestions.size() && i < studentAnswers.size(); i++) {
            Question q = examQuestions.get(i);
            String studentAnswer = studentAnswers.get(i);
            if (q.getCorrectAnswer().equals(studentAnswer)) {
                correctAnswers++;
            }
        }
        
        int totalQuestions = examQuestions.size();
        double percentage = (double) correctAnswers / totalQuestions * 100;
        
        // Save exam attempt
        ExamAttempt attempt = new ExamAttempt();
        attempt.setStudentEmail(student.getEmail());
        attempt.setScore(correctAnswers);
        attempt.setTotalQuestions(totalQuestions);
        attempt.setPercentage(percentage);
        attempt.setAttemptTime(examStartTime != null ? examStartTime : LocalDateTime.now());
        examAttemptRepository.save(attempt);
        
        // Clear session data
        session.removeAttribute("examQuestions");
        session.removeAttribute("studentAnswers");
        session.removeAttribute("currentQuestionIndex");
        session.removeAttribute("examStartTime");
        
        // Add results to model
        model.addAttribute("student", student);
        model.addAttribute("correctAnswers", correctAnswers);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("percentage", Math.round(percentage * 100.0) / 100.0);
        model.addAttribute("passed", percentage >= 60);
        
        System.out.println("=== EXAM SUBMITTED ===");
        System.out.println("Student: " + student.getName());
        System.out.println("Score: " + correctAnswers + "/" + totalQuestions + " (" + percentage + "%)");
        
        return "exam-result";
    }

    // View all results for student
    @GetMapping("/results")
    @PreAuthorize("hasRole('STUDENT')")
    public String viewResults(Authentication auth, Model model) {
        String email = auth.getName();
        Student student = studentRepository.findByEmail(email);
        
        List<ExamAttempt> attempts = examAttemptRepository.findByStudentEmailOrderByAttemptTimeDesc(email);
        
        model.addAttribute("student", student);
        model.addAttribute("attempts", attempts);
        
        return "exam-results-history";
    }
}
