package entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "exam_attempts")
public class ExamAttempt {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "student_email")
    private String studentEmail;
    
    @Column(name = "score")
    private Integer score;
    
    @Column(name = "total_questions")
    private Integer totalQuestions;
    
    @Column(name = "percentage")
    private Double percentage;
    
    @Column(name = "attempt_time")
    private LocalDateTime attemptTime;
    
    // Constructors
    public ExamAttempt() {}
    
    public ExamAttempt(String studentEmail, Integer score, Integer totalQuestions, Double percentage, LocalDateTime attemptTime) {
        this.studentEmail = studentEmail;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.percentage = percentage;
        this.attemptTime = attemptTime;
    }
    
    // Getters
    public Long getId() { return id; }
    public String getStudentEmail() { return studentEmail; }
    public Integer getScore() { return score; }
    public Integer getTotalQuestions() { return totalQuestions; }
    public Double getPercentage() { return percentage; }
    public LocalDateTime getAttemptTime() { return attemptTime; }
    
    // Setters
    public void setId(Long id) { this.id = id; }
    public void setStudentEmail(String studentEmail) { this.studentEmail = studentEmail; }
    public void setScore(Integer score) { this.score = score; }
    public void setTotalQuestions(Integer totalQuestions) { this.totalQuestions = totalQuestions; }
    public void setPercentage(Double percentage) { this.percentage = percentage; }
    public void setAttemptTime(LocalDateTime attemptTime) { this.attemptTime = attemptTime; }
}
