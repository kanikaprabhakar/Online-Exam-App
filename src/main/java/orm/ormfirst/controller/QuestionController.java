package orm.ormfirst.controller;

import entity.Question;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import orm.ormfirst.repository.QuestionRepository;

import java.util.List;

@RestController
@RequestMapping("/api/questions")
public class QuestionController {
    @Autowired
    private QuestionRepository questionRepository;

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
}
