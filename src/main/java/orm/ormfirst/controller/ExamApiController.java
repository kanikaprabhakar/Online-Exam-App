package orm.ormfirst.controller;

import orm.ormfirst.repository.ExamAttemptRepository;
import orm.ormfirst.repository.UserRepository;
import orm.ormfirst.repository.QuestionRepository;
import orm.ormfirst.repository.ExamRepository;
import entity.ExamAttempt;
import entity.User;
import entity.Question;
import entity.Exam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.http.ResponseEntity;
import java.time.Instant;
import java.util.Date;
import java.util.Map;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Collections;
import orm.ormfirst.dto.ExamAttemptRequest;
import orm.ormfirst.dto.AnswerSubmission;

@RestController
@RequestMapping("/api")
public class ExamApiController {
    @Autowired
    private ExamAttemptRepository examAttemptRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private QuestionRepository questionRepository;
    @Autowired
    private ExamRepository examRepository;

    // 1. View all exam attempts
    @GetMapping("/exam-attempts")
    public List<ExamAttempt> getAllExamAttempts() {
        return examAttemptRepository.findAll();
    }

    // 2. List all students
    @GetMapping("/all-students")
    public List<User> getAllStudents() {
        return userRepository.findAll().stream()
                .filter(u -> "student".equalsIgnoreCase(u.getRole()))
                .collect(Collectors.toList());
    }

    // 3. View personal exam attempts by email
    @GetMapping("/exam-attempts/{email}")
    public List<ExamAttempt> getExamAttemptsByEmail(@PathVariable String email) {
        return examAttemptRepository.findAll().stream()
                .filter(a -> a.getStudentEmail().equalsIgnoreCase(email))
                .collect(Collectors.toList());
    }

    // Endpoint: Take Exam
    @PostMapping("/exam-attempts/take")
    public ResponseEntity<?> takeExam(@RequestBody ExamAttemptRequest request) {
        int score = 0;
        int totalQuestions = request.answers.size();
        for (AnswerSubmission ans : request.answers) {
            Question q = questionRepository.findById(ans.questionId).orElse(null);
            if (q != null && q.getCorrectAnswer() != null && ans.selectedOption != null) {
                if (q.getCorrectAnswer().equals(ans.selectedOption)) {
                    score++;
                }
            }
        }
        ExamAttempt attempt = new ExamAttempt();
        attempt.setStudentEmail(request.studentEmail);
        attempt.setScore(score);
        attempt.setTotalQuestions(totalQuestions);
        attempt.setAttemptTime(new Date());
        examAttemptRepository.save(attempt);
        return ResponseEntity.ok(Map.of(
            "score", score,
            "totalQuestions", totalQuestions,
            "attemptTime", attempt.getAttemptTime()
        ));
    }


    // DTO for student question view
    class StudentQuestionDTO {
        public Integer id;
        public String question;
        public String option1;
        public String option2;
        public String option3;
        public String option4;
        public StudentQuestionDTO(Question q) {
            this.id = q.getId();
            this.question = q.getQuestion();
            this.option1 = q.getOption1();
            this.option2 = q.getOption2();
            this.option3 = q.getOption3();
            this.option4 = q.getOption4();
        }
    }


    // Admin endpoint: Get all questions (with answers)
    @GetMapping("/admin/questions")
    public List<Question> getAdminQuestions() {
        return questionRepository.findAll();
    }

}
