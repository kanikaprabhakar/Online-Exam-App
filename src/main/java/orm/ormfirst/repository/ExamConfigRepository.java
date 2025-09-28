package orm.ormfirst.repository;

import entity.ExamConfig;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ExamConfigRepository extends JpaRepository<ExamConfig, Integer> {
    
    // ✅ FIX: Correct syntax
    default ExamConfig getOrCreateConfig() {
        List<ExamConfig> configs = findAll();
        if (!configs.isEmpty()) {
            return configs.get(0);
        } else {
            // Create default config with proper values
            ExamConfig config = new ExamConfig();
            config.setExamTitle("Java Programming Exam");
            config.setExamDuration(60);
            config.setQuestionCount(20);
            config.setTotalMarks(100);
            config.setPassingMarks(60);
            config.setNegativeMarking(false);
            config.setExamEnabled(true);
            return save(config);
        }
    }
}
