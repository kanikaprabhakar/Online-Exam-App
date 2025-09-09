package entity;

import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "result")
public class Result {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int resultId;
    @NotNull(message = "Score is required")
    private Integer score;

    @ManyToOne
    @JoinColumn(name = "examId")
    private Exam exam;

    @ManyToOne
    @JoinColumn(name = "studentId")
    private Student student;
    // getters and setters
    public int getResultId() { return resultId; }
    public void setResultId(int resultId) { this.resultId = resultId; }
    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }
    public Exam getExam() { return exam; }
    public void setExam(Exam exam) { this.exam = exam; }
    public Student getStudent() { return student; }
    public void setStudent(Student student) { this.student = student; }
}
