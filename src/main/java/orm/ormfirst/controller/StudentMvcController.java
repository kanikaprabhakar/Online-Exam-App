package orm.ormfirst.controller;

import entity.Student;
import orm.ormfirst.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class StudentMvcController {
    
    @Autowired
    private StudentRepository studentRepository;
    
    // ✅ KEEP ONLY STUDENT CRUD OPERATIONS - NO DASHBOARD
    
    @GetMapping("/students")
    public String listStudents(Model model) {
        model.addAttribute("students", studentRepository.findAll());
        model.addAttribute("student", new Student());
        return "students";
    }

    @PostMapping("/students/register")
    public String registerStudent(@ModelAttribute Student student) {
        studentRepository.save(student);
        return "redirect:/students";
    }

    @GetMapping("/students/edit/{id}")
    public String editStudent(@PathVariable Integer id, Model model) {
        Student student = studentRepository.findById(id).orElse(new Student());
        model.addAttribute("student", student);
        model.addAttribute("students", studentRepository.findAll());
        return "students";
    }

    @PostMapping("/students/update")
    public String updateStudent(@ModelAttribute Student student) {
        studentRepository.save(student);
        return "redirect:/students";
    }

    @GetMapping("/students/delete/{id}")
    public String deleteStudent(@PathVariable Integer id) {
        studentRepository.deleteById(id);
        return "redirect:/students";
    }
    
    // ✅ REMOVED studentDashboard() method - it's already in StudentDashboardController
}
