package orm.ormfirst;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import Dao.QuestionDao;
import Entity.Question;
import Entity.Answer;
import Entity.Exam;
import java.util.*;

public class App {
    public static void main(String[] args) {
    System.out.println("==============================");
    System.out.println("   Welcome to Online Exam App  ");
    System.out.println("==============================");
        Scanner sc = new Scanner(System.in);
    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    Service.UserService userService = new Service.UserService();
        boolean running = true;
        while (running) {
            System.out.println("\n--- Main Menu ---");
            System.out.println("1. Register");
            System.out.println("2. Login");
            System.out.println("3. Exit");
            System.out.print("Select an option (1-3): ");
            int mainChoice = sc.nextInt();
            sc.nextLine();
            switch (mainChoice) {
                case 1:
                    System.out.println("\n--- Registration ---");
                    System.out.print("Name: ");
                    String name = sc.nextLine();
                    System.out.print("Email: ");
                    String regEmail = sc.nextLine();
                    System.out.print("Password: ");
                    String regPass = sc.nextLine();
                    System.out.print("Role (admin/student): ");
                    String regRole = sc.nextLine().trim().toLowerCase();
                    boolean registered = userService.registerWithRole(name, regEmail, regPass, regRole);
                    if (registered) {
                        System.out.println("Registration successful!");
                    } else {
                        System.out.println("Registration failed!");
                    }
                    break;
                case 2:
                    System.out.println("\n--- Login ---");
                    System.out.print("Email: ");
                    String email = sc.nextLine();
                    System.out.print("Password: ");
                    String pass = sc.nextLine();
                    String userRole = userService.getRoleByLogin(email, pass);
                    if (userRole == null) {
                        System.out.println("Login failed!");
                        break;
                    }
                    System.out.println("\nLogin successful! Welcome " + userRole.substring(0,1).toUpperCase() + userRole.substring(1) + ".");
                    boolean sessionActive = true;
                    while (sessionActive) {
                        if (userRole.equals("admin")) {
                            System.out.println("\n--- Admin Menu ---");
                            Dao.ExamDao examDao = (Dao.ExamDao) context.getBean("examDao");
                            Exam exam = examDao.getCurrentExam();
                            if (exam != null && exam.isEnabled()) {
                                System.out.println("Exam Status: ENABLED | Questions: " + exam.getNumQuestions());
                            } else {
                                System.out.println("Exam Status: DISABLED");
                            }
                            System.out.println("1. Add Question");
                            System.out.println("2. Enable Exam");
                            System.out.println("3. Disable Exam");
                            System.out.println("4. Set Number of Questions");
                            System.out.println("5. View Exam Attempts");
                            System.out.println("6. Logout");
                            System.out.print("Select an option (1-6): ");
                            int adminChoice = sc.nextInt();
                            sc.nextLine();
                            Dao.ExamAttemptDao attemptDao = (Dao.ExamAttemptDao) context.getBean("examAttemptDao");
                            switch (adminChoice) {
                                case 1:
                                    System.out.println("\n--- Add Objective Question ---");
                                    System.out.print("Question: ");
                                    String questionText = sc.nextLine();
                                    System.out.print("Option 1: ");
                                    String option1 = sc.nextLine();
                                    System.out.print("Option 2: ");
                                    String option2 = sc.nextLine();
                                    System.out.print("Option 3: ");
                                    String option3 = sc.nextLine();
                                    System.out.print("Option 4: ");
                                    String option4 = sc.nextLine();
                                    System.out.print("Correct answer (1-4): ");
                                    int correctAnswer = sc.nextInt();
                                    sc.nextLine();
                                    QuestionDao dao = (QuestionDao) context.getBean("questionDao");
                                    Question q = new Question();
                                    q.setQuestion(questionText);
                                    q.setOption1(option1);
                                    q.setOption2(option2);
                                    q.setOption3(option3);
                                    q.setOption4(option4);
                                    q.setCorrectAnswer(correctAnswer);
                                    dao.insert(q);
                                    System.out.println("Question added successfully!");
                                    break;
                                case 2:
                                    if (exam == null) {
                                        exam = new Entity.Exam();
                                        exam.setTitle("Main Exam");
                                        exam.setDuration(60);
                                    }
                                    exam.setEnabled(true);
                                    examDao.saveOrUpdate(exam);
                                    System.out.println("Exam enabled!");
                                    break;
                                case 3:
                                    examDao.disableAllExams();
                                    System.out.println("Exam disabled!");
                                    break;
                                case 4:
                                    if (exam == null) {
                                        System.out.println("Enable the exam first.");
                                    } else {
                                        System.out.print("Enter number of questions for exam: ");
                                        int numQ = sc.nextInt();
                                        sc.nextLine();
                                        exam.setNumQuestions(numQ);
                                        examDao.saveOrUpdate(exam);
                                        System.out.println("Number of questions set to " + numQ);
                                    }
                                    break;
                                case 5:
                                    System.out.println("\n--- Exam Attempt History ---");
                                    List<Entity.ExamAttempt> attempts = attemptDao.getAllAttempts();
                                    if (attempts.isEmpty()) {
                                        System.out.println("No exam attempts found.");
                                    } else {
                                        for (Entity.ExamAttempt a : attempts) {
                                            System.out.println("Student: " + a.getStudentEmail() + " | Score: " + a.getScore() + "/" + a.getTotalQuestions() + " | Time: " + a.getAttemptTime());
                                        }
                                    }
                                    break;
                                case 6:
                                    sessionActive = false;
                                    System.out.println("Logged out.");
                                    break;
                                default:
                                    System.out.println("Invalid choice!");
                            }
                                // ...existing code removed, only switch block remains...
                        } else if (userRole.equals("student")) {
                            System.out.println("\n--- Student Menu ---");
                            System.out.println("1. Take Exam");
                            System.out.println("2. Logout");
                            System.out.print("Select an option (1-2): ");
                            int studentChoice = sc.nextInt();
                            sc.nextLine();
                            if (studentChoice == 1) {
                                Dao.ExamDao examDao = (Dao.ExamDao) context.getBean("examDao");
                                Exam exam = examDao.getCurrentExam();
                                if (exam == null || !exam.isEnabled()) {
                                    System.out.println("No exam available. Please try later.");
                                } else {
                                    QuestionDao dao = (QuestionDao) context.getBean("questionDao");
                                    List<Question> allQuestions = dao.getAllQuestions();
                                    int numQ = exam.getNumQuestions();
                                    if (allQuestions.size() < numQ || numQ <= 0) {
                                        System.out.println("Not enough questions in database or exam not configured. Exam cannot start.");
                                    } else {
                                        System.out.println("\n--- Exam Started ---");
                                        System.out.println("Total Questions: " + numQ);
                                        Collections.shuffle(allQuestions);
                                        List<Question> questions = allQuestions.subList(0, numQ);
                                        int score = 0;
                                        int qNum = 1;
                                        for (Question q : questions) {
                                            System.out.println("\nQ" + qNum + ": " + q.getQuestion());
                                            System.out.println("  1. " + q.getOption1());
                                            System.out.println("  2. " + q.getOption2());
                                            System.out.println("  3. " + q.getOption3());
                                            System.out.println("  4. " + q.getOption4());
                                            System.out.print("Your answer (1-4): ");
                                            int ans = sc.nextInt();
                                            sc.nextLine();
                                            if (ans == q.getCorrectAnswer()) {
                                                score++;
                                            }
                                            qNum++;
                                        }
                                        System.out.println("\nExam finished! Your score: " + score + "/" + questions.size());
                                        // Save exam attempt
                                        Dao.ExamAttemptDao attemptDao = (Dao.ExamAttemptDao) context.getBean("examAttemptDao");
                                        Entity.ExamAttempt attempt = new Entity.ExamAttempt();
                                        attempt.setStudentEmail(email);
                                        attempt.setScore(score);
                                        attempt.setTotalQuestions(questions.size());
                                        attempt.setAttemptTime(new java.util.Date());
                                        attemptDao.saveAttempt(attempt);
                                    }
                                }
                            } else if (studentChoice == 2) {
                                sessionActive = false;
                                System.out.println("Logged out.");
                            } else {
                                System.out.println("Invalid choice!");
                            }
                        } else {
                            System.out.println("Unknown role. Logging out.");
                            sessionActive = false;
                        }
                    }
                    break;
                case 3:
                    running = false;
                    System.out.println("Exiting...");
                    break;
                default:
                    System.out.println("Invalid choice!");
            }
        }
        sc.close();
    }
}
