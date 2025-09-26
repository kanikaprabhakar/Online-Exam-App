package orm.ormfirst.controller;

import entity.Student;
import entity.User;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminMvcController {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private StudentRepository studentRepository;

    @GetMapping
    public String adminDashboard(Model model) {
        model.addAttribute("admins", userRepository.findAll());
        model.addAttribute("students", studentRepository.findAll());
        model.addAttribute("user", new User());
        model.addAttribute("student", new Student());
        return "admin";
    }

    @PostMapping("/register")
    public String registerAdmin(@ModelAttribute User user) {
        user.setRole("admin");
        userRepository.save(user);
        return "redirect:/admin";
    }

    @GetMapping("/edit-admin/{id}")
    public String editAdmin(@PathVariable Integer id, Model model) {
        User admin = userRepository.findById(id).orElse(new User());
        model.addAttribute("user", admin);
        model.addAttribute("admins", userRepository.findAll());
        model.addAttribute("students", studentRepository.findAll());
        model.addAttribute("student", new Student());
        return "admin";
    }

    @PostMapping("/update-admin")
    public String updateAdmin(@ModelAttribute User user) {
        user.setRole("admin");
        userRepository.save(user);
        return "redirect:/admin";
    }

    @GetMapping("/delete-admin/{id}")
    public String deleteAdmin(@PathVariable Integer id) {
        userRepository.deleteById(id);
        return "redirect:/admin";
    }
}
