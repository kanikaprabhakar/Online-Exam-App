package orm.ormfirst.dto;

public class StudentQuestionDTO {
    public Integer id;
    public String question;
    public String option1;
    public String option2;
    public String option3;
    public String option4;

    public StudentQuestionDTO(Integer id, String question, String option1, String option2, String option3, String option4) {
        this.id = id;
        this.question = question;
        this.option1 = option1;
        this.option2 = option2;
        this.option3 = option3;
        this.option4 = option4;
    }

    public StudentQuestionDTO(entity.Question q) {
        this(q.getId(), q.getQuestion(), q.getOption1(), q.getOption2(), q.getOption3(), q.getOption4());
    }
}
