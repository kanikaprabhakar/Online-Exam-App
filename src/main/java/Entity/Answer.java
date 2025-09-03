package Entity;

import javax.persistence.*;

@Entity
@Table(name = "answer") // optional
public class Answer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

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
