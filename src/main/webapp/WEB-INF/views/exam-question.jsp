<!-- filepath: src/main/webapp/WEB-INF/views/exam-question.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exam - Question ${currentIndex + 1}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .progress-bar {
            width: 100%;
            background-color: #e0e0e0;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .progress {
            height: 20px;
            background-color: #4CAF50;
            border-radius: 10px;
            text-align: center;
            line-height: 20px;
            color: white;
            font-weight: bold;
        }
        .question-header {
            background-color: #e8f5e8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .question-box {
            background-color: #f9f9f9;
            padding: 25px;
            border-radius: 5px;
            margin: 20px 0;
            border-left: 4px solid #4CAF50;
        }
        .options {
            margin: 20px 0;
        }
        .option {
            margin: 15px 0;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .option:hover {
            border-color: #4CAF50;
            background-color: #f0f8ff;
        }
        .option.selected {
            border-color: #4CAF50;
            background-color: #e8f5e8;
        }
        .option input[type="radio"] {
            margin-right: 10px;
            transform: scale(1.2);
        }
        .navigation {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e0e0e0;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .btn-danger {
            background-color: #f44336;
            color: white;
        }
        .btn-danger:hover {
            background-color: #da190b;
        }
        .question-text {
            font-size: 18px;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        .unanswered-warning {
            background-color: #fff3cd;
            color: #856404;
            padding: 15px 20px;
            border-radius: 8px;
            margin: 15px 0;
            border: 2px solid #ffc107;
            display: none;
            font-weight: bold;
            text-align: center;
        }

        @keyframes pulse {
            0% { 
                background-color: #fff3cd;
                border-color: #ffc107;
            }
            50% { 
                background-color: #ffe69c;
                border-color: #ffb300;
            }
            100% { 
                background-color: #fff3cd;
                border-color: #ffc107;
            }
        }
    </style>
    <script>
        function selectOption(optionNumber) {
            // Remove selected class from all options
            const options = document.querySelectorAll('.option');
            options.forEach(opt => opt.classList.remove('selected'));
            
            // Add selected class to clicked option
            const selectedOption = document.getElementById('option' + optionNumber);
            selectedOption.classList.add('selected');
            
            // Check the radio button
            document.getElementById('answer' + optionNumber).checked = true;
            
            // Hide warning
            const warning = document.getElementById('unansweredWarning');
            if (warning) {
                warning.style.display = 'none';
            }
        }

        function handleNext(event) {
            const selectedAnswer = document.querySelector('input[name="answer"]:checked');
            
            if (!selectedAnswer) {
                // PREVENT the form from submitting
                event.preventDefault();
                
                // Show the warning
                const warning = document.getElementById('unansweredWarning');
                warning.style.display = 'block';
                warning.style.animation = 'pulse 1.5s infinite';
                warning.innerHTML = '⚠️ <strong>You haven\'t selected an answer!</strong> Select an option below, or click "Skip & Next" to continue without answering.';
                
                // Show the skip button
                const nextBtn = document.getElementById('nextBtn');
                const skipBtn = document.getElementById('skipBtn');
                nextBtn.style.display = 'none';
                skipBtn.style.display = 'inline-block';
                
                return false; // Prevent form submission
            }
            
            return true; // Allow form submission
        }

        function skipQuestion() {
            // Allow skipping - just submit the form with next action
            document.getElementById('skipBtn').name = 'action';
            document.getElementById('skipBtn').value = 'next';
            return true;
        }

        function confirmSubmit() {
            const selectedAnswer = document.querySelector('input[name="answer"]:checked');
            if (!selectedAnswer) {
                return confirm('⚠️ You haven\'t answered this question.\n\nAre you sure you want to submit the exam? Unanswered questions will be marked incorrect.');
            }
            return confirm('Are you sure you want to submit the exam?\n\nYou cannot change your answers after submission.');
        }

        // Progress bar
        document.addEventListener('DOMContentLoaded', function() {
            // Check if there's already an answer selected
            const selectedAnswer = document.querySelector('input[name="answer"]:checked');
            if (selectedAnswer) {
                const optionNumber = selectedAnswer.value;
                document.getElementById('option' + optionNumber).classList.add('selected');
            }

            // Progress bar
            var currentIndex = parseInt('${currentIndex}') || 0;
            var totalQuestions = parseInt('${totalQuestions}') || 1;
            
            if (totalQuestions > 0) {
                var progressWidth = ((currentIndex + 1) * 100) / totalQuestions;
                const progressBars = document.querySelectorAll('.progress');
                progressBars.forEach(bar => {
                    bar.style.width = progressWidth + '%';
                });
            }
        });
    </script>
</head>
<body>
    <div class="container">
        <!-- Progress Bar -->
        <div class="progress-bar">
            <div class="progress">
                Question ${currentIndex + 1} of ${totalQuestions}
            </div>
        </div>

        <!-- Question Header -->
        <div class="question-header">
            <h2>Question ${currentIndex + 1}</h2>
            <div>
                <span style="background: #2196F3; color: white; padding: 5px 10px; border-radius: 3px;">
                    ID: ${question.id}
                </span>
            </div>
        </div>

        <!-- Question -->
        <div class="question-box">
            <div class="question-text">
                ${question.question}
            </div>
        </div>

        <!-- Unanswered Warning -->
        <div id="unansweredWarning" class="unanswered-warning">
            ⚠️ <strong>Warning:</strong> You haven't selected an answer for this question.
        </div>

        <!-- Answer Form -->
        <form action="/exam/answer" method="post" id="answerForm">
            <div class="options">
                <div class="option ${selectedAnswer == 1 ? 'selected' : ''}" id="option1" onclick="selectOption(1)">
                    <input type="radio" id="answer1" name="answer" value="1" ${selectedAnswer == 1 ? 'checked' : ''}>
                    <label for="answer1"><strong>A.</strong> ${question.option1}</label>
                </div>

                <div class="option ${selectedAnswer == 2 ? 'selected' : ''}" id="option2" onclick="selectOption(2)">
                    <input type="radio" id="answer2" name="answer" value="2" ${selectedAnswer == 2 ? 'checked' : ''}>
                    <label for="answer2"><strong>B.</strong> ${question.option2}</label>
                </div>

                <div class="option ${selectedAnswer == 3 ? 'selected' : ''}" id="option3" onclick="selectOption(3)">
                    <input type="radio" id="answer3" name="answer" value="3" ${selectedAnswer == 3 ? 'checked' : ''}>
                    <label for="answer3"><strong>C.</strong> ${question.option3}</label>
                </div>

                <div class="option ${selectedAnswer == 4 ? 'selected' : ''}" id="option4" onclick="selectOption(4)">
                    <input type="radio" id="answer4" name="answer" value="4" ${selectedAnswer == 4 ? 'checked' : ''}>
                    <label for="answer4"><strong>D.</strong> ${question.option4}</label>
                </div>
            </div>

            <!-- Navigation -->
            <div class="navigation">
                <div>
                    <c:if test="${currentIndex > 0}">
                        <button type="submit" name="action" value="previous" class="btn btn-secondary">⬅️ Previous</button>
                    </c:if>
                </div>

                <div>
                    <a href="/student-dashboard" class="btn btn-danger" 
                       onclick="return confirm('Are you sure you want to exit the exam? Your progress will be lost.')">
                        Exit Exam
                    </a>
                </div>

                <div>
                    <c:choose>
                        <c:when test="${currentIndex < totalQuestions - 1}">
                            <!-- Normal Next Button -->
                            <button type="submit" name="action" value="next" id="nextBtn" class="btn btn-primary" onclick="return handleNext(event)">
                                Next ➡️
                            </button>
                            
                            <!-- Skip Button (hidden by default) -->
                            <button type="submit" name="action" value="next" id="skipBtn" class="btn" 
                                    style="background-color: #ff9800; color: white; display: none;" onclick="return skipQuestion()">
                                Skip & Next ➡️
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" name="action" value="submit" class="btn btn-primary" onclick="return confirmSubmit()">
                                🏁 Submit Exam
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </form>
    </div>
</body>
</html>