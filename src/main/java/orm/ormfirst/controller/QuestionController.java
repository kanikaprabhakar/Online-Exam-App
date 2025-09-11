package orm.ormfirst.controller;

import entity.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import orm.ormfirst.repository.QuestionRepository;

import org.springframework.beans.factory.annotation.Qualifier;
import orm.ormfirst.controller.QuestionLimitController;
import java.util.Random;

import java.util.List;
import orm.ormfirst.dto.StudentQuestionDTO;

@RestController
@RequestMapping("/api/questions")
public class QuestionController {
    @Autowired
    private QuestionRepository questionRepository;

    @Autowired
    private QuestionLimitController questionLimitController;
    // Student endpoint: get random questions up to the current limit
    @GetMapping("/student")
    public List<StudentQuestionDTO> getStudentQuestions() {
        List<Question> allQuestions = questionRepository.findAll();
        int limit = questionLimitController.getCurrentLimit();
        List<Question> selected;
        if (allQuestions.size() <= limit) {
            selected = allQuestions;
        } else {
            Random rand = new Random();
            selected = rand.ints(0, allQuestions.size())
                .distinct()
                .limit(limit)
                .mapToObj(allQuestions::get)
                .toList();
        }
        return selected.stream()
            .map(StudentQuestionDTO::new)
            .toList();
    }

    @GetMapping("")
    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

    @PostMapping("")
    public Question addQuestion(@RequestBody Question question) {
        return questionRepository.save(question);
    }

    @PutMapping("/{id}")
    public Question updateQuestion(@PathVariable Integer id, @RequestBody Question updated) {
        Question q = questionRepository.findById(id).orElse(null);
        if (q != null) {
            q.setQuestion(updated.getQuestion());
            q.setOption1(updated.getOption1());
            q.setOption2(updated.getOption2());
            q.setOption3(updated.getOption3());
            q.setOption4(updated.getOption4());
            q.setCorrectAnswer(updated.getCorrectAnswer());
            return questionRepository.save(q);
        }
        return null;
    }

    @DeleteMapping("/{id}")
    public void deleteQuestion(@PathVariable Integer id) {
        questionRepository.deleteById(id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getQuestionById(@PathVariable Integer id) {
        return questionRepository.findById(id)
            .map(ResponseEntity::ok)
            .orElseGet(() -> ResponseEntity.notFound().build());
    }
}
