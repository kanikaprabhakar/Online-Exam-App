package orm.ormfirst.repository;

import Entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    User findByEmail(String email);
    
    // Add this method to find only admin users
    List<User> findByRoleIgnoreCase(String role);
    
    // Or more specific method
    List<User> findByRole(String role);
}
