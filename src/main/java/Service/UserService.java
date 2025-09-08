
package Service;

import orm.ormfirst.dao.UserDao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserService {
    private UserDao userDao = new UserDao();

    public boolean register(String name, String email, String pass) {
        // Default to student role for backward compatibility
        return registerWithRole(name, email, pass, "student");
    }

    public boolean registerWithRole(String name, String email, String pass, String role) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EXAM_APP", "root", "root")) {
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, role);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getRoleByLogin(String email, String pass) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EXAM_APP", "root", "root")) {
            String sql = "SELECT role FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("role");
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
