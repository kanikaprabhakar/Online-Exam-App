package orm.ormfirst.controller;

import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import orm.ormfirst.repository.UserRepository;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("")
    public List<User> getAllStudents() {
        return userRepository.findAll().stream()
            .filter(u -> "student".equalsIgnoreCase(u.getRole()))
            .collect(Collectors.toList());
    }
}
