package orm.ormfirst.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import entity.Question;

@Repository
public interface QuestionRepository extends JpaRepository<Question, Integer> {
    // You can add custom query methods here if needed
}
