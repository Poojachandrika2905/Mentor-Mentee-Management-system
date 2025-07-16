<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mentor-Mentee Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            font-family: 'Poppins', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff7e6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .header {
            background-color: #ffcc66;
            height: 300px;
            width: 100%;
            border-bottom-left-radius: 100px;
            border-bottom-right-radius: 100px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            position: relative;
        }

        .home-container {
            position: absolute;
            left: 400px;
            top: 30px;
            text-align: right;
        }

        .home-container1 {
            position: absolute;
            left: 400px;
            top: 80px;
            text-align: right;
        }

        .home-container2 {
            position: absolute;
            left: 400px;
            top: 45px;
            text-align: right;
        }

        .home-link {
            font-size: 20px;
            font-weight: bold;
            text-decoration: none;
            color: black;
            display: block;
        }

        .status-message {
            font-size: 18px;
            margin-top: 10px;
        }

        .profile-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            text-align: left;
            margin-left: 20px;
        }

        .profile-pic {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            border: 3px solid #fff;
        }

        .user-name {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 2px;
        }

        .user-role {
            font-size: 16px;
            color: gray;
            margin-top: 0;
        }

        .main-section {
            display: flex;
            align-items: flex-start;
            padding: 40px;
            gap: 40px;
        }

       .button-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            width: 200px;
            padding-left :40px;
        }
        .btn {
    display: flex;
    align-items: center;
    gap: 15px;
    width: 100%;
    padding: 12px 15px;
    background-color: #ffcc66;
    text-decoration: none;
    color: black;
    font-size: 18px;
    border-radius: 35px;
    margin-bottom: 14px;
    transition: background-color 0.3s;
    right : 100px;
    text-align : center;
}



.btn:hover {
    background-color: #ffd98a;
}
.btn-icon {
    width: 50px;
    height: 30px;
    border-radius: 50%;
    object-fit: cover;
}
        .dashboard-card {
    background: #ffffffcc;
    backdrop-filter: saturate(180%) blur(20px);
    border-radius: 20px;
    box-shadow: 0 12px 28px rgba(0,0,0,0.15);
    display: flex;
    align-items: center;
    padding: 36px 48px;
    max-width: 520px;
    width: 100%;
    gap: 32px;
    user-select: none;
    margin-left: 80px; /* Added to move the container right */
}


        .animated-bird {
            flex-shrink: 0;
            width: 140px;
            height: 140px;
            cursor: default;
            animation: float 4s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .wing {
            transform-origin: top center;
            animation: wingFlap 1.2s ease-in-out infinite;
        }

        .wing.right {
            animation-delay: 0.3s;
        }

        @keyframes wingFlap {
            0%, 100% { transform: rotate(0deg); }
            50% { transform: rotate(-20deg); }
        }

        .message {
            flex: 1;
            font-weight: 700;
            font-size: 2rem;
            line-height: 1.3;
            color: #14213d;
            letter-spacing: 0.02em;
            user-select: none;
            font-style: italic;
        }

        .message span {
            color: #fca311;
            text-shadow: 0 2px 6px rgba(252, 163, 17, 0.3);
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="profile-container">
            <img src="logo.jpg" alt="Profile" class="profile-pic">
            <p class="user-name"><%= userName %></p>
            <p class="user-role"><%= userRole %></p>
        </div>
        <div class="home-container">
            <a href="#" class="home-link">Home</a>
        </div>
        <div class="home-container1">
            <p class="status-message">How are you doing today?</p>
        </div>
        <div class="home-container2">
            <p>----------------------------------------------------------------------------------------------------------------------</p>
        </div>
    </div>

    <!-- Main Section with Buttons + Animated Bird -->
    <div class="main-section">
        <div class="button-container">
    <a href="http://localhost:8080/MMS/mentordashboard.jsp#" class="btn">
        <img src="home.webp" alt="Home" class="btn-icon"> Home
    </a>
    
    <a href="http://localhost:8080/MMS/coursesMentor.jsp" class="btn">
        <img src="courses.jpg" alt="Course" class="btn-icon"> Course
    </a>
   
    <a href="http://localhost:8080/MMS/mentees.jsp" class="btn">
        <img src="mentor.webp" alt="Mentees" class="btn-icon"> Mentees
    </a>
    <a href="http://localhost:8080/MMS/Mprofile.jsp" class="btn">
        <img src="logo.jpg" alt="Mentees" class="btn-icon"> Profile
    </a>
     <a href="login2.jsp" class="btn">
        <img src="logout.jpg" alt="My Mentee" class="btn-icon"> log out
    </a>
</div>


        <div class="dashboard-card" role="region" aria-label="Motivational quote to study with animated bird character">
            <svg class="animated-bird" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" focusable="false">
                <!-- Body -->
                <ellipse cx="32" cy="40" rx="18" ry="20" fill="#264653" />
                <!-- Tail feathers -->
                <path d="M14 48c4 4 12 4 16 0" stroke="#2a9d8f" stroke-width="4" stroke-linecap="round" />
                <!-- Wings -->
                <path class="wing left" d="M14 38c8-8 18-8 22 4" stroke="#2a9d8f" stroke-width="7" stroke-linecap="round" fill="none" />
                <path class="wing right" d="M50 40c-8-8-18-8-22 4" stroke="#2a9d8f" stroke-width="7" stroke-linecap="round" fill="none" />
                <!-- Head -->
                <circle cx="38" cy="22" r="10" fill="#e9c46a" />
                <!-- Eye -->
                <circle cx="42" cy="18" r="3" fill="#1d3557" />
                <!-- Beak -->
                <polygon points="48,24 54,20 48,18" fill="#f4a261"/>
                <!-- Neck -->
                <path d="M32 33c8 2 10 8 6 11" stroke="#e9c46a" stroke-width="6" fill="none" stroke-linecap="round" />
            </svg>
            <div class="message" aria-live="polite">
                <span>"Guide. Teach. Empower. Repeat!"</span>
            </div>
        </div>
    </div>
</body>
</html>







