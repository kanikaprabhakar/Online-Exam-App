package Entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "exam_attempt")
public class ExamAttempt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String studentEmail;
    private int score;
    private int totalQuestions;
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
