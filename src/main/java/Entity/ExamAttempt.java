package entity;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import java.util.Date;

@Entity
@Table(name = "exam_attempt")
public class ExamAttempt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank(message = "Student email is required")
    @Email(message = "Email should be valid")
    private String studentEmail;

    @NotNull(message = "Score is required")
    private Integer score;

    @NotNull(message = "Total questions is required")
    private Integer totalQuestions;

    @Temporal(TemporalType.TIMESTAMP)
    private Date attemptTime;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getStudentEmail() { return studentEmail; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }
    public Date getAttemptTime() { return attemptTime; }
    public void setAttemptTime(Date attemptTime) { this.attemptTime = attemptTime; }
}
