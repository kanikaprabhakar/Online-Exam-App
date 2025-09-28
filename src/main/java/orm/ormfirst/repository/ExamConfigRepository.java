package orm.ormfirst.repository;

import entity.ExamConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface ExamConfigRepository extends JpaRepository<ExamConfig, Long> {
    
    @Query("SELECT e FROM ExamConfig e ORDER BY e.id DESC")
    ExamConfig findLatestConfig();
    
    default ExamConfig getOrCreateConfig() {
        ExamConfig config = findLatestConfig();
        if (config == null) {
            config = new ExamConfig(false, 10, "Online Exam", 30);
            save(config);
        }
        return config;
    }
}
