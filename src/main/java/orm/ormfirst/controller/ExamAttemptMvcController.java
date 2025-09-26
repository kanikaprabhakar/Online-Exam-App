package orm.ormfirst.controller;

import entity.ExamAttempt;
import orm.ormfirst.repository.ExamAttemptRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/exam-attempts")
public class ExamAttemptMvcController {

    @Autowired
    private ExamAttemptRepository examAttemptRepository;

    @GetMapping
    public String listExamAttempts(Model model, @RequestParam(required = false) String email) {
        if (email != null && !email.isEmpty()) {
            model.addAttribute("examAttempts", examAttemptRepository.findByStudentEmail(email));
            model.addAttribute("searchEmail", email);
        } else {
            model.addAttribute("examAttempts", examAttemptRepository.findAll());
        }
        model.addAttribute("examAttempt", new ExamAttempt());
        return "exam-attempts";
    }

    @PostMapping("/add")
    public String addExamAttempt(@ModelAttribute ExamAttempt examAttempt) {
        examAttemptRepository.save(examAttempt);
        return "redirect:/exam-attempts";
    }

    @GetMapping("/delete/{id}")
    public String deleteExamAttempt(@PathVariable Integer id) {
        examAttemptRepository.deleteById(id);
        return "redirect:/exam-attempts";
    }
}
