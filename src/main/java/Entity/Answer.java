package Entity;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

@Entity
@Table(name = "answer") // optional
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank(message = "Answer text is required")
    @Size(min = 1, max = 255)
    private String answer;

    @ManyToOne
    @JoinColumn(name = "question_id")
    private Question question;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getAnswer() { return answer; }
    public void setAnswer(String answer) { this.answer = answer; }

    public Question getQuestion() { return question; }
    public void setQuestion(Question question) { this.question = question; }
}
