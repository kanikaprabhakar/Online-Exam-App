package orm.ormfirst.controller;

import entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import orm.ormfirst.repository.StudentRepository;
import org.springframework.http.ResponseEntity;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/students")
public class StudentController {
    @Autowired
    private StudentRepository studentRepository;

    @GetMapping("")
    public List<Student> getAllStudents() {
        return studentRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Student> getStudentById(@PathVariable Integer id) {
        return studentRepository.findById(id)
            .map(ResponseEntity::ok)
            .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateStudent(@PathVariable Integer id, @RequestBody RegistrationRequest req) {
        return studentRepository.findById(id)
            .map(student -> {
                student.setName(req.name);
                student.setEmail(req.email);
                student.setRollNumber(req.rollNumber);
                student.setPhone(req.phone);
                student.setAddress(req.address);
                studentRepository.save(student);
                return ResponseEntity.ok(Map.of("message", "Student updated successfully"));
            })
            .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteStudent(@PathVariable Integer id) {
        if (!studentRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        studentRepository.deleteById(id);
        return ResponseEntity.ok(Map.of("message", "Student deleted successfully"));
    }

    // DTO for registration
    static class RegistrationRequest {
        public String name;
        public String email;
        public String password;
        public String rollNumber;
        public String phone;
        public String address;
        public String role; // "admin" or "student"
    }

    // Student registration
    @PostMapping("/register-student")
    public ResponseEntity<?> registerStudent(@RequestBody RegistrationRequest req) {
        if (!"student".equalsIgnoreCase(req.role)) {
            return ResponseEntity.badRequest().body(Map.of("error", "Role must be 'student'"));
        }
        Student student = new Student();
        student.setName(req.name);
        student.setEmail(req.email);
        student.setRollNumber(req.rollNumber);
        student.setPhone(req.phone);
        student.setAddress(req.address);
        studentRepository.save(student);
        return ResponseEntity.ok(Map.of("message", "Student registered successfully"));
    }

}