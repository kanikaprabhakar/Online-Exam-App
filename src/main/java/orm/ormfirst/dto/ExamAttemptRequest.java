package orm.ormfirst.dto;
import java.util.List;

public class ExamAttemptRequest {
    public String studentEmail;
    public List<AnswerSubmission> answers;
}
