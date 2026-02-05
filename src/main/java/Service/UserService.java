package Service;

import Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import orm.ormfirst.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;

    public boolean register(String name, String email, String pass) {
        // Default to student role for backward compatibility
        return registerWithRole(name, email, pass, "student");
    }

    public boolean registerWithRole(String name, String email, String pass, String role) {
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(pass);
        user.setRole(role);
        userRepository.save(user);
        return true;
    }

    public String getRoleByLogin(String email, String pass) {
        List<User> users = userRepository.findAll();
        for (User user : users) {
            if (user.getEmail().equalsIgnoreCase(email) && user.getPassword().equals(pass)) {
                return user.getRole();
            }
        }
        return null;
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
}
