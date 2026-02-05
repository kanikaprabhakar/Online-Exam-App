package orm.ormfirst.repository;

import Entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {
    
    // ✅ SIMPLEST: Get all questions, randomize in Java
    @Query("SELECT q FROM Question q")
    List<Question> findAllQuestions();
    
    @Query("SELECT COUNT(q) FROM Question q")
    long countTotalQuestions();
}
