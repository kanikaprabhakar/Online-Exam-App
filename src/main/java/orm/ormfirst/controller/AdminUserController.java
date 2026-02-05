
package orm.ormfirst.controller;

import Entity.User;
import orm.ormfirst.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin/users")
public class AdminUserController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("")
    public List<User> getAllAdmins() {
        return userRepository.findAll().stream()
            .filter(u -> "admin".equalsIgnoreCase(u.getRole()))
            .toList();
    }

    // Admin registration
    @PostMapping("/register-admin")
    public ResponseEntity<?> registerAdmin(@RequestBody RegistrationRequest req) {
        if (!"admin".equalsIgnoreCase(req.role)) {
            return ResponseEntity.badRequest().body(Map.of("error", "Role must be 'admin'"));
        }
        User user = new User();
        user.setName(req.name);
        user.setEmail(req.email);
        user.setPassword(req.password);
        user.setRole("admin");
        userRepository.save(user);
        return ResponseEntity.ok(Map.of("message", "Admin registered successfully"));
    }

    static class RegistrationRequest {
        public String name;
        public String email;
        public String password;
        public String role;
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getAdminById(@PathVariable Integer id) {
        return userRepository.findById(id)
            .filter(u -> "admin".equalsIgnoreCase(u.getRole()))
            .map(ResponseEntity::ok)
            .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateAdmin(@PathVariable Integer id, @RequestBody User req) {
        return userRepository.findById(id)
            .filter(u -> "admin".equalsIgnoreCase(u.getRole()))
            .map(admin -> {
                admin.setName(req.getName());
                admin.setEmail(req.getEmail());
                admin.setPassword(req.getPassword());
                userRepository.save(admin);
                return ResponseEntity.ok(Map.of("message", "Admin updated successfully"));
            })
            .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAdmin(@PathVariable Integer id) {
        return userRepository.findById(id)
            .filter(u -> "admin".equalsIgnoreCase(u.getRole()))
            .map(admin -> {
                userRepository.deleteById(id);
                return ResponseEntity.ok(Map.of("message", "Admin deleted successfully"));
            })
            .orElseGet(() -> ResponseEntity.notFound().build());
    }


}
