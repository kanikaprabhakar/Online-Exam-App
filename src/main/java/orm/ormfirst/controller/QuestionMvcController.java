package orm.ormfirst.controller;

import entity.Question;
import orm.ormfirst.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class QuestionMvcController {

    @Autowired
    private QuestionRepository questionRepository;

    @GetMapping("/questions")
    public String listQuestions(Model model) {
        model.addAttribute("questions", questionRepository.findAll());
        model.addAttribute("question", new Question());
        return "questions";
    }

    @PostMapping("/questions/add")  // ✅ CLEAN PATH
    public String addQuestion(@RequestParam String question,
                             @RequestParam String option1,
                             @RequestParam String option2,
                             @RequestParam String option3,
                             @RequestParam String option4,
                             @RequestParam String correctAnswer) {
        
        System.out.println("=== ADD QUESTION ===");
        System.out.println("Question: " + question);
        System.out.println("Correct Answer: " + correctAnswer);
        
        Question q = new Question();
        q.setQuestion(question);
        q.setOption1(option1);
        q.setOption2(option2);
        q.setOption3(option3);
        q.setOption4(option4);
        q.setCorrectAnswer(correctAnswer);
        
        questionRepository.save(q);
        System.out.println("Question added successfully!");
        
        return "redirect:/questions";
    }

    @PostMapping("/questions/update")  // ✅ CLEAN PATH - REMOVE DUPLICATE
    public String updateQuestion(@RequestParam int id,
                               @RequestParam String question,
                               @RequestParam String option1,
                               @RequestParam String option2,
                               @RequestParam String option3,
                               @RequestParam String option4,
                               @RequestParam String correctAnswer) {
        
        System.out.println("=== UPDATE QUESTION ===");
        System.out.println("ID: " + id);
        System.out.println("Question: " + question);
        System.out.println("Correct Answer: " + correctAnswer);
        
        Question q = questionRepository.findById(id).orElse(null);
        if (q != null) {
            q.setQuestion(question);
            q.setOption1(option1);
            q.setOption2(option2);
            q.setOption3(option3);
            q.setOption4(option4);
            q.setCorrectAnswer(correctAnswer);
            questionRepository.save(q);
            System.out.println("Question updated successfully!");
        } else {
            System.out.println("Question not found with ID: " + id);
        }
        
        return "redirect:/questions";
    }

    @GetMapping("/questions/edit/{id}")
    public String editQuestion(@PathVariable Integer id, Model model) {
        Question question = questionRepository.findById(id).orElse(null);
        model.addAttribute("question", question);
        model.addAttribute("questions", questionRepository.findAll());
        return "questions";
    }

    @GetMapping("/questions/delete/{id}")
    public String deleteQuestion(@PathVariable Integer id) {
        questionRepository.deleteById(id);
        return "redirect:/questions";
    }

    // ✅ REMOVE ALL DUPLICATE MAPPINGS:
    // - /questions/questions/add
    // - /questions/questions/update
}
