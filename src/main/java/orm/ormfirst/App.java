package orm.ormfirst;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import Dao.QuestionDao;
import Entity.Question;
import Entity.Answer;
import java.util.*;

public class App {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        QuestionDao dao = (QuestionDao) context.getBean("questionDao");

        Question q = new Question();
        q.setQuestion("What is Hibernate?");

        Answer a1 = new Answer();
        a1.setAnswer("Hibernate is an ORM tool.");
        a1.setQuestion(q);

        Answer a2 = new Answer();
        a2.setAnswer("It maps Java objects to database tables.");
        a2.setQuestion(q);

        q.setAnswers(Arrays.asList(a1, a2));

        dao.insert(q);

        System.out.println("✅ Question and Answers inserted successfully!");
    }
}
