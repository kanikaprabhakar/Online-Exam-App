package orm.ormfirst.controller;

import entity.Question;
import orm.ormfirst.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/questions")
public class QuestionMvcController {

    @Autowired
    private QuestionRepository questionRepository;

    @GetMapping
    public String listQuestions(Model model) {
        model.addAttribute("questions", questionRepository.findAll());
        model.addAttribute("question", new Question());
        return "questions";
    }

    @PostMapping("/add")
    public String addQuestion(@ModelAttribute Question question) {
        System.out.println("=== ADD QUESTION ===");
        System.out.println("Question: " + question.getQuestion());
        questionRepository.save(question);
        return "redirect:/questions";
    }

    @GetMapping("/edit/{id}")
    public String editQuestion(@PathVariable Integer id, Model model) {
        Question question = questionRepository.findById(id).orElse(new Question());
        model.addAttribute("question", question);
        model.addAttribute("questions", questionRepository.findAll());
        return "questions";
    }

    @PostMapping("/update")
    public String updateQuestion(@ModelAttribute Question question) {
        System.out.println("=== UPDATE QUESTION ===");
        System.out.println("Question ID: " + question.getId());
        System.out.println("Question: " + question.getQuestion());
        questionRepository.save(question);
        return "redirect:/questions";
    }

    @GetMapping("/delete/{id}")
    public String deleteQuestion(@PathVariable Integer id) {
        questionRepository.deleteById(id);
        return "redirect:/questions";
    }
}
