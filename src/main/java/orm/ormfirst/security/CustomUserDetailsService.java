package orm.ormfirst.security;

import entity.Student;
import entity.User;
import orm.ormfirst.repository.StudentRepository;
import orm.ormfirst.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.function.Function;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private StudentRepository studentRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // Check in User table first (admins)
        User user = userRepository.findByEmail(email);
        Student student = studentRepository.findByEmail(email);

        if (user != null) {
            // Admin/User found
            return org.springframework.security.core.userdetails.User.builder()
                    .username(user.getEmail())
                    .password(user.getPassword())
                    .authorities("ROLE_" + user.getRole())
                    .build();
        } else if (student != null) {
            // Student found
            return org.springframework.security.core.userdetails.User.builder()
                    .username(student.getEmail())
                    .password(student.getPassword())
                    .authorities("ROLE_STUDENT")
                    .build();
        } else {
            throw new UsernameNotFoundException("User not found: " + email);
        }
    }
}
