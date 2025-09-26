package orm.ormfirst.controller;

import entity.ExamAttempt;
import entity.Question;
import entity.Student;
import orm.ormfirst.repository.ExamAttemptRepository;
import orm.ormfirst.repository.QuestionRepository;
import orm.ormfirst.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/exam")
public class ExamController {

    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    // Start exam
    @GetMapping("/start")
    public String startExam(Authentication auth, HttpSession session, Model model) {
        String studentEmail = auth.getName();
        Student student = studentRepository.findByEmail(studentEmail);

        // Get all questions and shuffle them
        List<Question> allQuestions = questionRepository.findAll();
        if (allQuestions.isEmpty()) {
            model.addAttribute("error", "No questions available for the exam.");
            return "redirect:/student-dashboard";
        }

        Collections.shuffle(allQuestions); // Randomize question order

        // Store exam session data
        session.setAttribute("examQuestions", allQuestions);
        session.setAttribute("examStartTime", LocalDateTime.now());
        session.setAttribute("currentQuestionIndex", 0);
        session.setAttribute("studentAnswers", new Integer[allQuestions.size()]);

        model.addAttribute("student", student);
        model.addAttribute("totalQuestions", allQuestions.size());

        return "exam-instructions";
    }

    // Show current question
    @GetMapping("/question")
    public String showQuestion(HttpSession session, Model model) {
        List<Question> examQuestions = (List<Question>) session.getAttribute("examQuestions");
        Integer currentIndex = (Integer) session.getAttribute("currentQuestionIndex");
        Integer[] studentAnswers = (Integer[]) session.getAttribute("studentAnswers");

        if (examQuestions == null || currentIndex == null) {
            return "redirect:/exam/start";
        }

        if (currentIndex >= examQuestions.size()) {
            return "redirect:/exam/submit";
        }

        Question currentQuestion = examQuestions.get(currentIndex);
        model.addAttribute("question", currentQuestion);
        model.addAttribute("currentIndex", currentIndex);
        model.addAttribute("totalQuestions", examQuestions.size());
        model.addAttribute("selectedAnswer", studentAnswers[currentIndex]);

        return "exam-question";
    }

    // Save answer and go to next question
    @PostMapping("/answer")
    public String saveAnswer(@RequestParam(required = false) Integer answer,
                           @RequestParam String action,
                           HttpSession session) {
        Integer currentIndex = (Integer) session.getAttribute("currentQuestionIndex");
        Integer[] studentAnswers = (Integer[]) session.getAttribute("studentAnswers");

        if (currentIndex != null && studentAnswers != null) {
            // Handle unmarked answers - store null instead of causing error
            studentAnswers[currentIndex] = answer; // This can be null, which is fine
            session.setAttribute("studentAnswers", studentAnswers);

            if ("next".equals(action) && currentIndex < studentAnswers.length - 1) {
                session.setAttribute("currentQuestionIndex", currentIndex + 1);
                return "redirect:/exam/question";
            } else if ("previous".equals(action) && currentIndex > 0) {
                session.setAttribute("currentQuestionIndex", currentIndex - 1);
                return "redirect:/exam/question";
            }
        }

        return "redirect:/exam/submit";
    }

    // Submit exam
    @GetMapping("/submit")
    public String submitExam(Authentication auth, HttpSession session, Model model) {
        List<Question> examQuestions = (List<Question>) session.getAttribute("examQuestions");
        Integer[] studentAnswers = (Integer[]) session.getAttribute("studentAnswers");
        LocalDateTime startTime = (LocalDateTime) session.getAttribute("examStartTime");

        if (examQuestions == null || studentAnswers == null || startTime == null) {
            model.addAttribute("error", "Invalid exam session. Please start the exam again.");
            return "redirect:/student-dashboard";
        }

        // Calculate results with null-safe checking
        int correctAnswers = 0;
        int answeredQuestions = 0;
        
        for (int i = 0; i < examQuestions.size(); i++) {
            Question question = examQuestions.get(i);
            Integer studentAnswer = studentAnswers[i];
            
            if (studentAnswer != null) {
                answeredQuestions++;
                if (studentAnswer.equals(question.getCorrectAnswer())) {
                    correctAnswers++;
                }
            }
        }

        // Calculate score and time taken properly
        double score = examQuestions.size() > 0 ? ((double) correctAnswers / examQuestions.size()) * 100 : 0;
        LocalDateTime endTime = LocalDateTime.now();
        
        // Fix time calculation - convert to minutes properly
        long timeTakenMinutes = java.time.Duration.between(startTime, endTime).toMinutes();
        if (timeTakenMinutes < 1) {
            timeTakenMinutes = 1; // Minimum 1 minute
        }

        // Get student info
        String studentEmail = auth.getName();
        Student student = studentRepository.findByEmail(studentEmail);

        if (student == null) {
            model.addAttribute("error", "Student not found. Please login again.");
            return "redirect:/login";
        }

        // Create exam attempt record
        ExamAttempt attempt = new ExamAttempt();
        attempt.setStudentId(student.getStudentId());
        attempt.setStudentName(student.getName());
        attempt.setStudentEmail(student.getEmail());
        attempt.setTotalQuestions(examQuestions.size());
        attempt.setCorrectAnswers(correctAnswers);
        attempt.setScore(score);
        attempt.setStartTime(startTime);
        attempt.setEndTime(endTime);
        attempt.setTimeTaken((int) timeTakenMinutes);
        attempt.setStatus("COMPLETED");

        try {
            examAttemptRepository.save(attempt);
        } catch (Exception e) {
            model.addAttribute("error", "Failed to save exam results. Please contact administrator.");
            return "redirect:/student-dashboard";
        }

        // Clear session
        session.removeAttribute("examQuestions");
        session.removeAttribute("studentAnswers");
        session.removeAttribute("examStartTime");
        session.removeAttribute("currentQuestionIndex");

        // Add statistics for display
        model.addAttribute("attempt", attempt);
        model.addAttribute("student", student);
        model.addAttribute("answeredQuestions", answeredQuestions);
        model.addAttribute("unansweredQuestions", examQuestions.size() - answeredQuestions);

        return "exam-result";
    }

    // View all results for student
    @GetMapping("/results")
    public String viewResults(Authentication auth, Model model) {
        String studentEmail = auth.getName();
        Student student = studentRepository.findByEmail(studentEmail);
        
        List<ExamAttempt> attempts = examAttemptRepository.findByStudentEmailOrderByStartTimeDesc(studentEmail);
        
        model.addAttribute("student", student);
        model.addAttribute("attempts", attempts);
        
        return "student-results";
    }
}
