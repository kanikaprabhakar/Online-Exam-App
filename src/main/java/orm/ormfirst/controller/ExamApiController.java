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
