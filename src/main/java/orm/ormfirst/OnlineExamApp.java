package orm.ormfirst;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;

@SpringBootApplication
@ImportResource("classpath:applicationContext.xml")
public class OnlineExamApp {
    public static void main(String[] args) {
        SpringApplication.run(OnlineExamApp.class, args);
    }
}
