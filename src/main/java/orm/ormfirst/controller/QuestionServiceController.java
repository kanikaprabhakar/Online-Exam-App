package orm.ormfirst.controller;

import entity.Question;
import orm.ormfirst.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

import java.util.List;
import java.util.Collections;

@RestController
@RequestMapping("/api/questions-service")  // ✅ CHANGED FROM /api/questions
@CrossOrigin(origins = "*")
@ConditionalOnProperty(name = "spring.profiles.active", havingValue = "question-service")
public class QuestionServiceController {

    @Autowired
    private QuestionRepository questionRepository;

    @GetMapping
    public ResponseEntity<List<Question>> getAllQuestions() {
        return ResponseEntity.ok(questionRepository.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Question> getQuestion(@PathVariable Integer id) {
        Question question = questionRepository.findById(id).orElse(null);
        return question != null ? ResponseEntity.ok(question) : ResponseEntity.notFound().build();
    }

    @GetMapping("/exam")
    public ResponseEntity<List<Question>> getExamQuestions(@RequestParam(defaultValue = "10") int count) {
        List<Question> allQuestions = questionRepository.findAll();
        Collections.shuffle(allQuestions);
        
        int questionsToReturn = Math.min(count, allQuestions.size());
        List<Question> examQuestions = allQuestions.subList(0, questionsToReturn);
        
        return ResponseEntity.ok(examQuestions);
    }

    @GetMapping("/count")
    public ResponseEntity<Integer> getQuestionCount() {
        return ResponseEntity.ok((int) questionRepository.count());
    }

    @PostMapping
    public ResponseEntity<Question> createQuestion(@RequestBody Question question) {
        Question saved = questionRepository.save(question);
        return ResponseEntity.ok(saved);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Question> updateQuestion(@PathVariable Integer id, @RequestBody Question question) {
        if (questionRepository.existsById(id)) {
            question.setId(id);
            Question updated = questionRepository.save(question);
            return ResponseEntity.ok(updated);
        }
        return ResponseEntity.notFound().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteQuestion(@PathVariable Integer id) {
        if (questionRepository.existsById(id)) {
            questionRepository.deleteById(id);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }

    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("Question Service is running on port 8082");
    }
}
