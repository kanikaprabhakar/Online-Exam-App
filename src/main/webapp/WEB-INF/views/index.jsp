<!-- filepath: src/main/webapp/WEB-INF/views/index.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evalora - Assess. Secure. Excel.</title>
    <link rel="icon" type="image/png" href="/static/document-file.png">
    <link href="https://fonts.googleapis.com/css2?family=Aileron:wght@400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            font-family: 'Aileron', sans-serif;
            background: #1a1a1a;
            color: #fff;
            line-height: 1.6;
        }

        /* ============================================
           HERO SECTION
           ============================================ */
        .hero {
            background-image: url('/startupstockphotos-man-593333_1280%20-%20Edited.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: white;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 40px 20px;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.6);
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 600px;
        }

        .hero h1 {
            font-size: 4rem;
            font-weight: 900;
            margin-bottom: 20px;
            letter-spacing: -1px;
            text-shadow: 2px 2px 8px rgba(0, 0, 0, 0.7);
        }

        .hero .tagline {
            font-size: 1.3rem;
            font-weight: 400;
            margin-bottom: 40px;
            opacity: 0.9;
            letter-spacing: 3px;
            text-transform: uppercase;
            text-shadow: 1px 1px 4px rgba(0, 0, 0, 0.7);
        }

        .hero-cta {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 40px;
        }

        .btn {
            padding: 14px 35px;
            border: 2px solid transparent;
            border-radius: 4px;
            font-family: 'Aileron', sans-serif;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: transparent;
            color: white;
            border-color: white;
        }

        .btn-primary:hover {
            background: white;
            color: #1a1a1a;
            transform: translateY(-2px);
        }

        /* ============================================
           FEATURES SECTION
           ============================================ */
        .features {
            padding: 80px 40px;
            background: #1a1a1a;
            text-align: center;
        }

        .features h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 60px;
            color: #fff;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            padding: 30px;
            border-radius: 8px;
            background: #252525;
            transition: all 0.3s ease;
            border: 1px solid #333;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            border-color: #666;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4);
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 20px;
            font-weight: 700;
            color: #888;
        }

        .feature-card h3 {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 15px;
            color: #fff;
        }

        .feature-card p {
            color: #bbb;
            font-size: 0.95rem;
        }

        /* ============================================
           AUTH SECTIONS
           ============================================ */
        .auth-section {
            padding: 80px 40px;
            background: #0f0f0f;
        }

        .auth-section h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 20px;
            text-align: center;
            color: #fff;
        }

        .auth-section h2 small {
            display: block;
            font-size: 1rem;
            font-weight: 400;
            color: #888;
            margin-top: 10px;
        }

        .auth-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 50px;
            max-width: 1200px;
            margin: 50px auto 0;
        }

        .auth-box {
            background: #1a1a1a;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.4);
            transition: all 0.3s ease;
            border: 1px solid #333;
        }

        .auth-box:hover {
            border-color: #666;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .auth-box h3 {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: #fff;
        }

        .auth-box .description {
            color: #aaa;
            margin-bottom: 30px;
            font-size: 0.95rem;
            min-height: 50px;
        }

        .auth-box .btn {
            width: 100%;
            text-align: center;
            font-size: 1rem;
        }

        /* ============================================
           LOGIN BOX
           ============================================ */
        .login-box {
            border-left: 3px solid #777;
        }

        .login-box h3 {
            color: #fff;
        }

        .login-btn {
            background: #444;
            color: white;
            border: 2px solid #666;
        }

        .login-btn:hover {
            background: #555;
            border-color: #888;
        }

        /* ============================================
           STUDENT REG BOX
           ============================================ */
        .student-box {
            border-left: 3px solid #8b5a3c;
        }

        .student-box h3 {
            color: #fff;
        }

        .student-btn {
            background: #5a3d2a;
            color: white;
            border: 2px solid #8b5a3c;
        }

        .student-btn:hover {
            background: #6d4a35;
            border-color: #a86d49;
        }

        /* ============================================
           ADMIN REG BOX
           ============================================ */
        .admin-box {
            border-left: 3px solid #6b4444;
        }

        .admin-box h3 {
            color: #fff;
        }

        .admin-btn {
            background: #5a3842;
            color: white;
            border: 2px solid #8b5a63;
        }

        .admin-btn:hover {
            background: #6d4a54;
            border-color: #a87080;
        }

        /* ============================================
           FOOTER
           ============================================ */
        footer {
            background: #0a0a0a;
            color: #999;
            text-align: center;
            padding: 30px 20px;
            font-size: 0.9rem;
            border-top: 1px solid #333;
        }

        footer p {
            margin: 5px 0;
        }

        /* ============================================
           RESPONSIVE
           ============================================ */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2.5rem;
            }

            .hero .tagline {
                font-size: 1rem;
                letter-spacing: 2px;
            }

            .features h2,
            .auth-section h2 {
                font-size: 2rem;
            }

            .auth-container {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .feature-card {
                padding: 20px;
            }

            .auth-box {
                padding: 30px;
            }

            .features,
            .auth-section {
                padding: 50px 20px;
            }
        }

        @media (max-width: 480px) {
            .hero h1 {
                font-size: 2rem;
            }

            .hero .tagline {
                font-size: 0.9rem;
                letter-spacing: 1px;
            }

            .hero-cta {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <!-- ============================================
         HERO SECTION
         ============================================ -->
    <section class="hero">
        <div class="hero-content">
            <h1>Evalora</h1>
            <p class="tagline">Assess. Secure. Excel.</p>
            
            <p style="font-size: 1.05rem; margin-top: 30px; max-width: 500px; margin-left: auto; margin-right: auto; opacity: 0.95;">
                A comprehensive platform for creating, managing, and taking secure online exams. 
                Built for professionals who demand reliability and excellence.
            </p>

            <div class="hero-cta">
                <a href="#login" class="btn btn-primary">Get Started</a>
            </div>
        </div>
    </section>

    <!-- ============================================
         FEATURES SECTION
         ============================================ -->
    <section class="features">
        <h2>Why Choose Evalora?</h2>
        
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">⬤</div>
                <h3>Secure & Reliable</h3>
                <p>Enterprise-grade security with JWT authentication and encrypted communications to protect your exam integrity.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">⬈</div>
                <h3>Smart Analytics</h3>
                <p>Detailed performance tracking and result analytics to help students improve and track their progress over time.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">⚡</div>
                <h3>Lightning Fast</h3>
                <p>Optimized performance ensures smooth exam taking experience with instant result calculations and feedback.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">✓</div>
                <h3>Flexible Questions</h3>
                <p>Support for multiple question formats with randomized question selection for fair and consistent assessments.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">◊</div>
                <h3>Responsive Design</h3>
                <p>Seamlessly works across all devices and screen sizes for a consistent experience anywhere, anytime.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">⬘</div>
                <h3>Multi-User Support</h3>
                <p>Dedicated roles for students and administrators with intuitive dashboards tailored to each user type.</p>
            </div>
        </div>
    </section>

    <!-- ============================================
         AUTHENTICATION SECTION
         ============================================ -->
    <section class="auth-section" id="login">
        <h2>Get Started
            <small>Choose your role and access the platform</small>
        </h2>

        <div class="auth-container">
            <!-- LOGIN BOX -->
            <div class="auth-box login-box">
                <h3>Existing User?</h3>
                <p class="description">
                    Sign in to your account to access your dashboard, take exams, and view your results.
                </p>
                <a href="/login" class="btn login-btn">Sign In</a>
            </div>

            <!-- STUDENT REGISTRATION BOX -->
            <div class="auth-box student-box">
                <h3>Student Sign Up</h3>
                <p class="description">
                    Create a new student account to start taking exams and practice with our learning tools.
                </p>
                <a href="/signup" class="btn student-btn">Register as Student</a>
            </div>

            <!-- ADMIN REGISTRATION BOX -->
            <div class="auth-box admin-box">
                <h3>Admin Sign Up</h3>
                <p class="description">
                    Create an administrator account to manage exams, questions, and student performance.
                </p>
                <a href="/admin-signup" class="btn admin-btn">Register as Admin</a>
            </div>
        </div>
    </section>

    <!-- ============================================
         FOOTER
         ============================================ -->
    <footer>
        <p>&copy; 2026 Evalora - Assess. Secure. Excel.</p>
        <p>A comprehensive online examination platform for modern education.</p>
    </footer>
</body>
</html>