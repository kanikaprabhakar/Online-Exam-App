package orm.ormfirst.controller;

import Entity.Question;
import orm.ormfirst.repository.QuestionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/public/questions") // ✅ FIX: Change base path to avoid conflicts
public class QuestionMvcController {

    @Autowired
    private QuestionRepository questionRepository;

    @GetMapping("")
    public String listQuestions(Model model) {
        model.addAttribute("questions", questionRepository.findAll());
        model.addAttribute("question", new Question());
        return "questions";
    }

    // ✅ REMOVE: All these mappings to avoid conflicts with AdminMvcController
    // The admin should use /admin/questions/* paths
    // This controller can be used for public question viewing only
}
