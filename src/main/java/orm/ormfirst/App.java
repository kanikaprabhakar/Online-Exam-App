package orm.ormfirst;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import Dao.QuestionDao;
import Entity.Question;
import Entity.Answer;
import java.util.*;

public class App {
    public static void main(String[] args) {
        System.out.println("APP STARTED ULULALALALALAL");
        Scanner sc = new Scanner(System.in);
    ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    Service.UserService userService = new Service.UserService();
        boolean running = true;
        while (running) {
            System.out.println("\nWelcome to Online Exam System");
            System.out.println("1. Register\n2. Login\n3. Exit");
            System.out.print("Choose option: ");
            int mainChoice = sc.nextInt();
            sc.nextLine();
            switch (mainChoice) {
                case 1:
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
                    System.out.print("Email: ");
                    String email = sc.nextLine();
                    System.out.print("Password: ");
                    String pass = sc.nextLine();
                    String userRole = userService.getRoleByLogin(email, pass);
                    if (userRole == null) {
                        System.out.println("Login failed!");
                        break;
                    }
                    System.out.println("Login successful! Welcome " + userRole.substring(0,1).toUpperCase() + userRole.substring(1) + ".");
                    boolean sessionActive = true;
                    while (sessionActive) {
                        if (userRole.equals("admin")) {
                            System.out.println("Admin Menu:");
                            System.out.println("1. Add Question\n2. Add Answer\n3. Logout");
                            int adminChoice = sc.nextInt();
                            sc.nextLine();
                            if (adminChoice == 1) {
                                System.out.print("Enter question: ");
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
                                System.out.println("Objective question added!");
                            } else if (adminChoice == 2) {
                                System.out.print("Enter answer: ");
                                String answerText = sc.nextLine();
                                System.out.print("Enter question ID for this answer: ");
                                int qid = sc.nextInt();
                                sc.nextLine();
                                QuestionDao dao = (QuestionDao) context.getBean("questionDao");
                                Question q = new Question();
                                q.setId(qid); // This assumes you have a method to fetch by ID
                                Answer a = new Answer();
                                a.setAnswer(answerText);
                                a.setQuestion(q);
                                q.setAnswers(Arrays.asList(a));
                                dao.insert(q);
                                System.out.println("Answer added!");
                            } else if (adminChoice == 3) {
                                sessionActive = false;
                                System.out.println("Logged out.");
                            } else {
                                System.out.println("Invalid choice!");
                            }
                        } else if (userRole.equals("student")) {
                            System.out.println("Student Menu:");
                            System.out.println("1. Take Exam\n2. Logout");
                            int studentChoice = sc.nextInt();
                            sc.nextLine();
                            if (studentChoice == 1) {
                                // Fetch all questions
                                QuestionDao dao = (QuestionDao) context.getBean("questionDao");
                                List<Question> questions = dao.getAllQuestions();
                                int score = 0;
                                int qNum = 1;
                                for (Question q : questions) {
                                    System.out.println("Q" + qNum + ": " + q.getQuestion());
                                    System.out.println("1. " + q.getOption1());
                                    System.out.println("2. " + q.getOption2());
                                    System.out.println("3. " + q.getOption3());
                                    System.out.println("4. " + q.getOption4());
                                    System.out.print("Your answer (1-4): ");
                                    int ans = sc.nextInt();
                                    sc.nextLine();
                                    if (ans == q.getCorrectAnswer()) {
                                        score++;
                                    }
                                    qNum++;
                                }
                                System.out.println("Exam finished! Your score: " + score + "/" + questions.size());
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
