<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");
%><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mentor-Mentee Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <style>
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
    .progress-bar-container {
            width: 80%;
            margin: 20px auto;
            background-color: #eee;
            border-radius: 20px;
            overflow: hidden;
            height: 25px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
        }
        .progress-bar-fill {
            height: 100%;
            width: 0%;
            background-color: #4caf50;
            text-align: center;
            line-height: 25px;
            color: white;
            font-weight: bold;
            transition: width 0.4s ease;
        }

        .task-box {
            cursor: pointer;
        }
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff7e6;
            display: flex;
            height: 100vh;
            flex-direction: column;
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
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin-top: 20px;
            width: 200px;
            margin-left: 20px;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 15px;
            background-color: #ffcc66;
            text-decoration: none;
            color: black;
            font-size: 18px;
            border-radius: 30px;
            text-align: center;
            margin-bottom: 10px;
        }
        .content {
            flex-grow: 1;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 60%;
            position: absolute;
            top: 50px;
            left: 50%;
            transform: translateX(-50%);
        }
        .module {
    margin-bottom: 1em;
    background-color: #ffcc66;
    color: white;
    padding: 1em;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: background-color 0.3s;
    position: relative;
}

.arrow {
    transition: transform 0.3s;
    font-weight: bold;
    font-size: 20px;
    color: black;
    margin-left: auto;
}

        .module:hover {
            background-color: #ff9900;
        }
        
        .module-details {
            display: none;
            margin-top: 0.5em;
            background-color: #f0f4f8;
            color: black;
            padding: 1em;
            border-radius: 8px;
        }
        .task-box {
            background-color: #fff;
            border: 1px solid #ddd;
            padding: 10px;
            margin: 5px 0;
            border-radius: 5px;
        }
        .video-container {
            width: 60%;
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            display: none;
            background: rgba(0, 0, 0, 0.8);
            padding: 10px;
            border-radius: 10px;
            z-index: 10;
        }
        .video-container video {
            width: 100%;
            border-radius: 10px;
        }
        .close-video {
            position: absolute;
            top: 5px;
            right: 10px;
            font-size: 20px;
            color: white;
            cursor: pointer;
            background: red;
            border-radius: 50%;
            padding: 5px;
        }
        .course-container {
    background-color: #fff1d6;
    border-radius: 20px;
    padding: 30px;
    margin: 40px 20px;
    max-width: 900px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
}

.course-title {
    font-size: 28px;
    color: #cc6600;
    margin-bottom: 10px;
}

.course-tagline {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    margin-bottom: 15px;
}

.course-description {
    font-size: 16px;
    line-height: 1.6;
    color: #444;
    margin-bottom: 15px;
}
        
    </style>
</head>
<body>
   <script>
    let completedTasks = new Set();

    function toggleModule(moduleId, arrowId) {
        const module = document.getElementById(moduleId);
        const arrow = document.getElementById(arrowId);
        module.style.display = (module.style.display === "block") ? "none" : "block";
        arrow.style.transform = (module.style.display === "block") ? "rotate(180deg)" : "rotate(0deg)";
    }

    function playVideoForTask(taskName) {
        const videoContainer = document.getElementById("video-container");
        const videoPlayer = document.getElementById("task-video");
        const videoSource = document.getElementById("video-source");

        // Assign different videos based on task name (ensure the files exist)
        videoSource.src = "videos/" + taskName.replace(/ /g, "_").toLowerCase() + ".mp4";
        videoPlayer.load();
        videoContainer.style.display = "block";

        // Track task as completed
        completedTasks.add(taskName);
        updateProgressBar();
    }

    function closeVideo() {
        document.getElementById("video-container").style.display = "none";
    }

    function updateProgressBar() {
        const totalTasks = document.querySelectorAll(".task-box").length;
        const completedCount = completedTasks.size;
        const percentage = Math.round((completedCount / totalTasks) * 100);
        document.getElementById("progress-fill").style.width = percentage + "%";
        document.getElementById("progress-fill").innerText = percentage + "%";
    }
</script>

<!-- Profile and header remains unchanged -->
<div class="header">
    <div class="profile-container">
        <img src="logo.jpg" alt="Profile" class="profile-pic">
        <p class="user-name"><%= userName %></p>
        <p class="user-role"><%= userRole %></p>
    </div>
</div>

<div class="main-section">
        <div class="button-container">
    <a href="dashboard.jsp" class="btn">
        <img src="home.webp" alt="Home" class="btn-icon"> Home
    </a>
    <a href="http://localhost:8080/MMS/learn.jsp" class="btn">
        <img src="learn.jpg" alt="Progress" class="btn-icon"> Learning
    </a>
    <a href="http://localhost:8080/MMS/Courses.jsp" class="btn">
        <img src="courses.jpg" alt="Course" class="btn-icon"> Course
    </a>
   
    <a href="http://localhost:8080/MMS/mentorprofiles.jsp" class="btn">
        <img src="mentor.webp" alt="Mentees" class="btn-icon"> Mentor
    </a>
     <a href="login2.jsp" class="btn">
        <img src="logout.jpg" alt="My Mentee" class="btn-icon"> log out
    </a>
</div>
</div>

<!-- Video popup -->
<div class="video-container" id="video-container">
    <span class="close-video" onclick="closeVideo()">&times;</span>
    <video controls id="task-video">
        <source id="video-source" src="" type="video/mp4">
        Your browser does not support the video tag.
    </video>
</div>

<div class="content">
    <div class="course-container">
        <h2 class="course-title">Cybersecurity Course</h2>
        <p class="course-tagline">Step into the world of digital defense and launch your career in Cybersecurity!</p>
        <p class="course-description">Learn to secure digital environments and protect systems...</p>
    </div>

    <div class="progress-bar-container">
        <div class="progress-bar-fill" id="progress-fill">0%</div>
    </div>

    <h2>Modules in the Course</h2>

    <%-- Each module with tasks now triggers playVideoForTask --%>
    <div class="module" onclick="toggleModule('module1', 'arrow1')">Module 1: Introduction to Cybersecurity <span class="arrow" id="arrow1"> > </span></div>
    <div class="module-details" id="module1">
        <div class="task-box" onclick="playVideoForTask('Fundamentals of Cybersecurity')">Task 1: Fundamentals of Cybersecurity</div>
        <div class="task-box" onclick="playVideoForTask('Types of Cyber Threats')">Task 2: Types of Cyber Threats</div>
        <div class="task-box" onclick="playVideoForTask('CIA Triad')">Task 3: CIA Triad</div>
        <div class="task-box" onclick="playVideoForTask('Security Terminologies')">Task 4: Security Terminologies</div>
        <div class="task-box" onclick="playVideoForTask('Careers and Certifications')">Task 5: Careers and Certifications</div>
    </div>

    <%-- Repeat for other modules --%>
    <div class="module" onclick="toggleModule('module2', 'arrow2')">Module 2: Network Security <span class="arrow" id="arrow2"> > </span></div>
    <div class="module-details" id="module2">
        <div class="task-box" onclick="playVideoForTask('Networking Basics')">Task 1: Networking Basics</div>
        <div class="task-box" onclick="playVideoForTask('Firewalls and IDS/IPS')">Task 2: Firewalls and IDS/IPS</div>
        <div class="task-box" onclick="playVideoForTask('Network Attacks')">Task 3: Network Attacks</div>
        <div class="task-box" onclick="playVideoForTask('Wireshark and Packet Analysis')">Task 4: Wireshark and Packet Analysis</div>
        <div class="task-box" onclick="playVideoForTask('Secure Network Design')">Task 5: Secure Network Design</div>
    </div>

    <!-- Repeat similar structure for modules 3 to 5 -->

    <div class="module" onclick="toggleModule('module3', 'arrow3')">Module 3: Web Security <span class="arrow" id="arrow3"> > </span></div>
<div class="module-details" id="module3">
    <div class="task-box" onclick="playVideoForTask('Web Application Architecture')">Task 1: Web Application Architecture</div>
    <div class="task-box" onclick="playVideoForTask('Common Web Vulnerabilities')">Task 2: Common Web Vulnerabilities</div>
    <div class="task-box" onclick="playVideoForTask('Secure Coding Practices')">Task 3: Secure Coding Practices</div>
    <div class="task-box" onclick="playVideoForTask('Web Application Firewalls')">Task 4: Web Application Firewalls</div>
    <div class="task-box" onclick="playVideoForTask('Penetration Testing')">Task 5: Penetration Testing</div>
</div>
    <div class="module" onclick="toggleModule('module4', 'arrow4')">Module 4: Cryptography <span class="arrow" id="arrow4"> > </span></div>
<div class="module-details" id="module4">
    <div class="task-box" onclick="playVideoForTask('Introduction to Cryptography')">Task 1: Introduction to Cryptography</div>
    <div class="task-box" onclick="playVideoForTask('Symmetric Encryption')">Task 2: Symmetric Encryption</div>
    <div class="task-box" onclick="playVideoForTask('Asymmetric Encryption')">Task 3: Asymmetric Encryption</div>
    <div class="task-box" onclick="playVideoForTask('Digital Signatures')">Task 4: Digital Signatures</div>
    <div class="task-box" onclick="playVideoForTask('Cryptographic Protocols')">Task 5: Cryptographic Protocols</div>
</div>
    <div class="module" onclick="toggleModule('module5', 'arrow5')">Module 5: Cybersecurity Tools & Practices <span class="arrow" id="arrow5"> > </span></div>
<div class="module-details" id="module5">
    <div class="task-box" onclick="playVideoForTask('Cybersecurity Tools Overview')">Task 1: Cybersecurity Tools Overview</div>
    <div class="task-box" onclick="playVideoForTask('Antivirus and Endpoint Protection')">Task 2: Antivirus and Endpoint Protection</div>
    <div class="task-box" onclick="playVideoForTask('Security Information and Event Management')">Task 3: Security Information and Event Management</div>
    <div class="task-box" onclick="playVideoForTask('Incident Response Plan')">Task 4: Incident Response Plan</div>
    <div class="task-box" onclick="playVideoForTask('Security Best Practices')">Task 5: Security Best Practices</div>
</div>
    
</div>
</body>
</html>
