package entity;

import javax.persistence.*;

@Entity
@Table(name = "exam_config")
public class ExamConfig {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    @Column(name = "exam_title")
    private String examTitle = "Java Programming Exam";
    
    @Column(name = "exam_duration")
    private Integer examDuration = 60;
    
    @Column(name = "total_marks")
    private Integer totalMarks = 100;
    
    @Column(name = "passing_marks")
    private Integer passingMarks = 60;
    
    @Column(name = "negative_marking")
    private Boolean negativeMarking = false;
    
    @Column(name = "exam_enabled")
    private Boolean examEnabled = true;
    
    @Column(name = "question_count")
    private Integer questionCount = 20;
    
    // Default constructor
    public ExamConfig() {}
    
    // Standard getters and setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getExamTitle() { return examTitle; }
    public void setExamTitle(String examTitle) { this.examTitle = examTitle; }
    
    public Integer getExamDuration() { return examDuration; }
    public void setExamDuration(Integer examDuration) { this.examDuration = examDuration; }
    
    public Integer getTotalMarks() { return totalMarks; }
    public void setTotalMarks(Integer totalMarks) { this.totalMarks = totalMarks; }
    
    public Integer getPassingMarks() { return passingMarks; }
    public void setPassingMarks(Integer passingMarks) { this.passingMarks = passingMarks; }
    
    public Boolean getNegativeMarking() { return negativeMarking; }
    public void setNegativeMarking(Boolean negativeMarking) { this.negativeMarking = negativeMarking; }
    
    public Boolean getExamEnabled() { return examEnabled; }
    public void setExamEnabled(Boolean examEnabled) { this.examEnabled = examEnabled; }
    
    public Integer getQuestionCount() { return questionCount; }
    public void setQuestionCount(Integer questionCount) { this.questionCount = questionCount; }
    
    // ✅ ADD: All the alias getters for JSP compatibility
    public Integer getExamDurationMinutes() {
        return examDuration;
    }
    
    public void setExamDurationMinutes(Integer examDurationMinutes) {
        this.examDuration = examDurationMinutes;
    }
    
    public boolean isExamEnabled() {
        return examEnabled != null && examEnabled;
    }
    
    public boolean isNegativeMarking() {
        return negativeMarking != null && negativeMarking;
    }
}
