package orm.ormfirst.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
@RequestMapping("/api/admin/question-limit")
public class QuestionLimitController {
    private int questionLimit = 10; // default value

    @PostMapping("")
    public ResponseEntity<?> setLimit(@RequestBody LimitRequest req) {
        this.questionLimit = req.limit;
        return ResponseEntity.ok("Limit set to " + questionLimit);
    }

    @GetMapping("")
    public int getLimit() {
        return questionLimit;
    }

    public int getCurrentLimit() {
        return questionLimit;
    }

    static class LimitRequest {
        public int limit;
    }
}
