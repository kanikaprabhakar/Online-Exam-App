package orm.ormfirst.dao;

import java.sql.*;
import java.util.List;

import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Repository;

import entity.User;

//@Repository
public class UserDao {
    private final String url = "jdbc:mysql://localhost:3306/EXAM_APP";
    private final String username = "root";
    private final String password = "root";
    @Autowired
    private HibernateTemplate hibernateTemplate;

    public boolean register(String name, String email, String pass) {
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean login(String email, String pass) {
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        return (List<User>) hibernateTemplate.loadAll(User.class);
    }

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }
}
