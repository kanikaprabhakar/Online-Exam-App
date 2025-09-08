package orm.ormfirst;

import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"orm.ormfirst", "entity"})
    @EntityScan("entity")
public class OnlineExamApp {
    public static void main(String[] args) {
        SpringApplication.run(OnlineExamApp.class, args);
    }
}
