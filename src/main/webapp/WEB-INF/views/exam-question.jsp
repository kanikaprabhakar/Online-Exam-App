<!-- filepath: c:\Users\DELL\eclipse-workspace\OnlineExamApp2\src\main\webapp\WEB-INF\views\exam-question.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Question ${currentIndex + 1} - ${config.examTitle}</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 0; background: #f5f5f5; }
        .header { background: #007bff; color: white; padding: 15px 0; position: fixed; top: 0; width: 100%; z-index: 1000; }
        .header-content { max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; }
        .progress-bar { background: #e9ecef; height: 10px; border-radius: 5px; margin: 10px 0; }
        .progress { background: #28a745; height: 100%; border-radius: 5px; transition: width 0.3s; }
        .container { max-width: 800px; margin: 80px auto 20px; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        .question-header { background: #f8f9fa; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .question-text { font-size: 18px; font-weight: bold; margin-bottom: 20px; line-height: 1.6; }
        .options { margin: 20px 0; }
        .option { background: #fff; border: 2px solid #e9ecef; padding: 15px; margin: 10px 0; border-radius: 8px; cursor: pointer; transition: all 0.3s; }
        .option:hover { border-color: #007bff; background: #f8f9fa; }
        .option.selected { border-color: #007bff; background: #e7f3ff; }
        .option-text { font-size: 16px; }
        .navigation { text-align: center; margin-top: 30px; }
        .btn { padding: 12px 25px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; }
        .btn-primary { background: #007bff; color: white; }
        .btn-success { background: #28a745; color: white; }
        .btn:disabled { background: #6c757d; cursor: not-allowed; }
        .student-info { font-size: 14px; }
        .saving { color: #ffc107; font-weight: bold; }
        .saved { color: #28a745; font-weight: bold; }
        .error { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-content">
            <div class="student-info">
                <strong>${student.name}</strong> (${student.rollNumber})
            </div>
            <div>
                <strong>Question ${currentIndex + 1} of ${totalQuestions}</strong>
            </div>
            <div>
                <span id="timer">Time: ${config.examDurationMinutes}:00</span>
            </div>
        </div>
        <div style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
            <div class="progress-bar">
                <div class="progress" id="progressBar" style="width: 0%"></div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="question-header">
            <h3>Question ${currentIndex + 1} of ${totalQuestions}</h3>
            <p>${questionsRemaining} questions remaining</p>
            <div id="saveStatus"></div>
        </div>

        <div class="question-text">
            ${question.question}
        </div>

        <div class="options">
            <div class="option" data-answer="<c:out value='${question.option1}' escapeXml='true'/>" onclick="selectOption(this)">
                <div class="option-text"><strong>A.</strong> ${question.option1}</div>
            </div>
            <div class="option" data-answer="<c:out value='${question.option2}' escapeXml='true'/>" onclick="selectOption(this)">
                <div class="option-text"><strong>B.</strong> ${question.option2}</div>
            </div>
            <div class="option" data-answer="<c:out value='${question.option3}' escapeXml='true'/>" onclick="selectOption(this)">
                <div class="option-text"><strong>C.</strong> ${question.option3}</div>
            </div>
            <div class="option" data-answer="<c:out value='${question.option4}' escapeXml='true'/>" onclick="selectOption(this)">
                <div class="option-text"><strong>D.</strong> ${question.option4}</div>
            </div>
        </div>

        <div class="navigation">
            <c:choose>
                <c:when test="${currentIndex + 1 >= totalQuestions}">
                    <button id="submitBtn" class="btn btn-success" onclick="nextQuestion()" disabled>
                        🏁 Submit Exam
                    </button>
                </c:when>
                <c:otherwise>
                    <button id="nextBtn" class="btn btn-primary" onclick="nextQuestion()" disabled>
                        Next Question ➡️
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <script type="text/javascript">
        var currentIndex = parseInt('${currentIndex}');
        var totalQuestions = parseInt('${totalQuestions}');
        var examDurationMinutes = parseInt('${config.examDurationMinutes}');
        var selectedAnswer = '';
        var isSubmitting = false; // ✅ ADD: Prevent multiple submissions
        
        // ✅ SET PROGRESS BAR
        document.addEventListener('DOMContentLoaded', function() {
            var progressPercent = ((currentIndex + 1) / totalQuestions) * 100;
            document.getElementById('progressBar').style.width = progressPercent + '%';
        });
        
        function selectOption(element) {
            var answer = element.getAttribute('data-answer');
            
            document.querySelectorAll('.option').forEach(function(opt) {
                opt.classList.remove('selected');
            });
            
            element.classList.add('selected');
            selectedAnswer = answer;
            
            var nextBtn = document.getElementById('nextBtn');
            var submitBtn = document.getElementById('submitBtn');
            
            if (nextBtn) nextBtn.removeAttribute('disabled');
            if (submitBtn) submitBtn.removeAttribute('disabled');
            
            console.log('Selected answer:', answer);
        }
        
        function nextQuestion() {
            if (isSubmitting) return; // ✅ PREVENT double submission
            
            if (!selectedAnswer) {
                alert('Please select an answer before proceeding.');
                return;
            }
            
            isSubmitting = true;
            
            // Show saving status
            document.getElementById('saveStatus').innerHTML = '<span class="saving">💾 Saving answer...</span>';
            
            // Disable buttons
            var nextBtn = document.getElementById('nextBtn');
            var submitBtn = document.getElementById('submitBtn');
            if (nextBtn) nextBtn.setAttribute('disabled', 'disabled');
            if (submitBtn) submitBtn.setAttribute('disabled', 'disabled');
            
            // ✅ REMOVE onbeforeunload temporarily during navigation
            window.onbeforeunload = null;
            
            // Save answer
            fetch('/exam/answer', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'questionIndex=' + currentIndex + '&selectedAnswer=' + encodeURIComponent(selectedAnswer)
            })
            .then(function(response) {
                return response.text();
            })
            .then(function(data) {
                console.log('Answer saved:', data);
                document.getElementById('saveStatus').innerHTML = '<span class="saved">✅ Answer saved!</span>';
                
                // Navigate after short delay
                setTimeout(function() {
                    if ((currentIndex + 1) >= totalQuestions) {
                        window.location.href = '/exam/submit';
                    } else {
                        window.location.href = '/exam/question';
                    }
                }, 500);
            })
            .catch(function(error) {
                console.error('Error:', error);
                document.getElementById('saveStatus').innerHTML = '<span class="error">❌ Error saving answer!</span>';
                
                isSubmitting = false;
                // Re-enable buttons on error
                if (nextBtn) nextBtn.removeAttribute('disabled');
                if (submitBtn) submitBtn.removeAttribute('disabled');
                
                // ✅ RESTORE onbeforeunload on error
                window.onbeforeunload = function() {
                    return 'Are you sure you want to leave? Your exam progress will be lost.';
                };
                
                alert('Error saving answer. Please try again.');
            });
        }
        
        // Timer functionality
        var timeInSeconds = examDurationMinutes * 60;
        
        function updateTimer() {
            if (timeInSeconds <= 0) {
                alert('Time is up! Submitting exam...');
                window.onbeforeunload = null; // ✅ REMOVE warning before auto-submit
                window.location.href = '/exam/submit';
                return;
            }
            
            var minutes = Math.floor(timeInSeconds / 60);
            var seconds = timeInSeconds % 60;
            
            var minutesStr = (minutes < 10 ? '0' : '') + minutes;
            var secondsStr = (seconds < 10 ? '0' : '') + seconds;
            
            document.getElementById('timer').textContent = 'Time: ' + minutesStr + ':' + secondsStr;
            
            timeInSeconds--;
        }
        
        setInterval(updateTimer, 1000);
        
        // ✅ ONLY warn on accidental navigation, NOT on form submission
        window.onbeforeunload = function(e) {
            if (isSubmitting) return; // Don't warn during normal exam flow
            return 'Are you sure you want to leave? Your exam progress will be lost.';
        };
        
        // ✅ PREVENT browser back button (but allow normal navigation)
        window.history.pushState(null, null, window.location.href);
        window.onpopstate = function() {
            if (!isSubmitting) {
                alert('Navigation is disabled during the exam.');
                window.history.go(1);
            }
        };
    </script>
</body>
</html>