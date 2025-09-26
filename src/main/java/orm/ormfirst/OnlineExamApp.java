package orm.ormfirst;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EntityScan("entity")
@EnableJpaRepositories("orm.ormfirst.repository")
public class OnlineExamApp {
    public static void main(String[] args) {
        SpringApplication.run(OnlineExamApp.class, args);
    }
}
