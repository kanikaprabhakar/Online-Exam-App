package entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "exam")
public class Exam {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int examId;
    private String title;
    private int duration;
    @Column(name = "enabled")
    private boolean enabled;
    @Column(name = "num_questions")
    private int numQuestions;

    @OneToMany(mappedBy = "exam", cascade = CascadeType.ALL)
    private java.util.List<Question> questions;
    // getters and setters
    public int getExamId() { return examId; }
    public void setExamId(int examId) { this.examId = examId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    public boolean isEnabled() { return enabled; }
    public void setEnabled(boolean enabled) { this.enabled = enabled; }
    public int getNumQuestions() { return numQuestions; }
    public void setNumQuestions(int numQuestions) { this.numQuestions = numQuestions; }
    public List<Question> getQuestions() { return questions; }
    public void setQuestions(List<Question> questions) { this.questions = questions; }
}
