package entity;

import javax.persistence.*;

@Entity
@Table(name = "exam_config")
public class ExamConfig {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "exam_enabled")
    private boolean examEnabled = false;
    
    @Column(name = "question_count")
    private int questionCount = 10;
    
    @Column(name = "exam_title")
    private String examTitle = "Online Exam";
    
    @Column(name = "exam_duration_minutes") 
    private int examDurationMinutes = 30;
    
    // Constructors
    public ExamConfig() {}
    
    public ExamConfig(boolean examEnabled, int questionCount, String examTitle, int examDurationMinutes) {
        this.examEnabled = examEnabled;
        this.questionCount = questionCount;
        this.examTitle = examTitle;
        this.examDurationMinutes = examDurationMinutes;
    }
    
    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public boolean isExamEnabled() { return examEnabled; }
    public void setExamEnabled(boolean examEnabled) { this.examEnabled = examEnabled; }
    
    public int getQuestionCount() { return questionCount; }
    public void setQuestionCount(int questionCount) { this.questionCount = questionCount; }
    
    public String getExamTitle() { return examTitle; }
    public void setExamTitle(String examTitle) { this.examTitle = examTitle; }
    
    public int getExamDurationMinutes() { return examDurationMinutes; }
    public void setExamDurationMinutes(int examDurationMinutes) { this.examDurationMinutes = examDurationMinutes; }
}
