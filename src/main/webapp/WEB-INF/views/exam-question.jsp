<!-- filepath: c:\Users\DELL\eclipse-workspace\OnlineExamApp2\src\main\webapp\WEB-INF\views\exam-question.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Question ${currentIndex + 1} - ${config.examTitle}</title>
    <link rel="icon" type="image/png" href="/document-file.png">
    <link href="https://fonts.googleapis.com/css2?family=Aileron:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Aileron', sans-serif;
            background: linear-gradient(135deg, #1a1a1a 0%, #0f0f0f 100%);
            color: #ddd;
            margin: 0;
        }
        .header {
            background: linear-gradient(135deg, #2a2a2a 0%, #252525 100%);
            color: white;
            padding: 15px 0;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
            border-bottom: 2px solid #444;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
        }
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .student-info { font-size: 14px; color: #ddd; }
        .timer {
            font-weight: 700;
            font-size: 1.1rem;
            color: #88ff88;
        }
        .progress-bar {
            background: #1a1a1a;
            height: 10px;
            border-radius: 5px;
            margin: 10px 0;
        }
        .progress {
            background: linear-gradient(90deg, #4a90e2 0%, #357abd 100%);
            height: 100%;
            border-radius: 5px;
            transition: width 0.3s;
        }
        .container {
            max-width: 900px;
            margin: 80px auto 20px;
            background: linear-gradient(135deg, #252525 0%, #1f1f1f 100%);
            padding: 40px;
            border-radius: 12px;
            border: 1px solid #333;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
        }
        .question-header {
            background: linear-gradient(135deg, #2a2a2a 0%, #252525 100%);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #444;
        }
        .question-header h3 { color: #fff; font-weight: 700; margin-bottom: 8px; }
        .question-header p { color: #888; font-size: 0.9rem; }
        .question-text {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 25px;
            line-height: 1.8;
            color: #fff;
        }
        .options { margin: 25px 0; }
        .option {
            background: linear-gradient(135deg, #2a2a2a 0%, #252525 100%);
            border: 2px solid #444;
            padding: 18px 20px;
            margin: 12px 0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .option:hover {
            border-color: #5a9fe9;
            background: linear-gradient(135deg, #2f2f2f 0%, #2a2a2a 100%);
            transform: translateX(5px);
        }
        .option.selected {
            border-color: #4a90e2;
            background: linear-gradient(135deg, #1a3a5a 0%, #15314a 100%);
            box-shadow: 0 5px 20px rgba(74, 144, 226, 0.3);
        }
        .option-text {
            font-size: 16px;
            color: #ddd;
        }
        .option.selected .option-text { color: #fff; font-weight: 600; }
        .navigation {
            text-align: center;
            margin-top: 35px;
        }
        .btn {
            padding: 14px 32px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            font-family: 'Aileron', sans-serif;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .btn-primary {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            color: white;
            border: 1px solid #5a9fe9;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a9fe9 0%, #4682d4 100%);
            border-color: #6aaff0;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(74, 144, 226, 0.4);
        }
        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #218838 100%);
            color: white;
            border: 1px solid #34b75a;
        }
        .btn-success:hover {
            background: linear-gradient(135deg, #34b75a 0%, #28a745 100%);
            border-color: #4ac76e;
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(40, 167, 69, 0.4);
        }
        .btn:disabled {
            background: #555;
            border-color: #666;
            cursor: not-allowed;
            opacity: 0.5;
        }
        .saving { color: #ffc107; font-weight: bold; }
        .saved { color: #88ff88; font-weight: bold; }
        .error { color: #ff8888; font-weight: bold; }
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