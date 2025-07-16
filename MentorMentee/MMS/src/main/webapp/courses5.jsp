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
        body {
            font-family: Arial, sans-serif;
            margin: 0; padding: 0;
            background-color: #fff7e6;
            display: flex; height: 100vh;
            flex-direction: column; overflow-x: hidden;
        }
        .header {
            background-color: #ffcc66;
            height: 300px; width: 100%;
            border-bottom-left-radius: 100px;
            border-bottom-right-radius: 100px;
            display: flex; align-items: center;
            padding: 20px; position: relative;
        }
        .profile-container {
            display: flex; flex-direction: column;
            margin-left: 20px;
        }
        .profile-pic {
            width: 70px; height: 70px;
            border-radius: 50%; border: 3px solid #fff;
        }
        .user-name {
            font-size: 22px; font-weight: bold;
            margin-bottom: 2px;
        }
        .user-role {
            font-size: 16px; color: gray;
        }
        .button-container {
            display: flex; flex-direction: column;
            margin: 20px 0 0 20px; width: 200px;
        }
        .btn {
            display: block; width: 100%;
            padding: 15px; margin-bottom: 10px;
            background-color: #ffcc66; color: black;
            text-decoration: none; font-size: 18px;
            border-radius: 30px; text-align: center;
        }
        .content {
            flex-grow: 1; background: #fff;
            padding: 20px; border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            width: 60%; position: absolute;
            top: 50px; left: 50%; transform: translateX(-50%);
        }
        .course-container {
            background-color: #fff1d6;
            border-radius: 20px; padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .course-title {
            font-size: 28px; color: #cc6600;
            margin-bottom: 10px;
        }
        .course-tagline {
            font-size: 20px; font-weight: bold;
            color: #333; margin-bottom: 15px;
        }
        .course-description {
            font-size: 16px; line-height: 1.6;
            color: #444; margin-bottom: 15px;
        }
        .progress-bar-container {
            width: 80%; margin: 20px auto;
            background-color: #eee; border-radius: 20px;
            overflow: hidden; height: 25px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.2);
        }
        .progress-bar-fill {
            height: 100%; width: 0%;
            background-color: #4caf50;
            text-align: center; line-height: 25px;
            color: white; font-weight: bold;
            transition: width 0.4s ease;
        }
        .module {
            margin-bottom: 1em;
            background-color: #ffcc66; color: white;
            padding: 1em; border-radius: 8px;
            font-weight: bold; cursor: pointer;
            display: flex; justify-content: space-between;
            align-items: center;
            transition: background-color 0.3s;
        }
        .module:hover { background-color: #ff9900; }
        .arrow {
            font-size: 20px; color: black;
            transition: transform 0.3s;
        }
        .module-details {
            display: none; margin-top: 0.5em;
            background-color: #f0f4f8; padding: 1em;
            border-radius: 8px; color: black;
        }
        .task-box {
            background-color: #fff; border: 1px solid #ddd;
            padding: 10px; margin: 5px 0;
            border-radius: 5px; cursor: pointer;
        }
        .video-container {
            width: 60%; position: absolute;
            top: 0; left: 50%; transform: translateX(-50%);
            display: none; background: rgba(0,0,0,0.8);
            padding: 10px; border-radius: 10px;
            z-index: 10;
        }
        .video-container video {
            width: 100%; border-radius: 10px;
        }
        .close-video {
            position: absolute; top: 5px; right: 10px;
            background: red; color: white;
            border-radius: 50%; padding: 5px;
            cursor: pointer; font-size: 20px;
        }
    </style>
    <script>
        let completedTasks = new Set();
        function toggleModule(id, arr) {
            const det = document.getElementById(id),
                  arrow = document.getElementById(arr);
            if(det.style.display==='block') {
                det.style.display='none'; arrow.style.transform='rotate(0deg)';
            } else {
                det.style.display='block'; arrow.style.transform='rotate(180deg)';
            }
        }
        function playVideo() {
            document.getElementById('video-container').style.display='block';
        }
        function closeVideo() {
            document.getElementById('video-container').style.display='none';
        }
        function markDone(task) {
            completedTasks.add(task);
            const total = document.querySelectorAll('.task-box').length;
            const pct = Math.round(completedTasks.size/total*100) + '%';
            const bar = document.getElementById('progress-fill');
            bar.style.width=pct; bar.innerText=pct;
        }
    </script>
</head>
<body>
    <div class="header">
        <div class="profile-container">
            <img src="logo.jpg" class="profile-pic" alt="Profile">
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

    <div class="video-container" id="video-container">
        <span class="close-video" onclick="closeVideo()">&times;</span>
        <video controls>
            <source src="video.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>

    <div class="content">
        <div class="course-container">
            <h2 class="course-title">Internet Of Things Course</h2>
            <p class="course-tagline">Become a skilled IoT developer and kickstart your career in building the smart, connected world of tomorrow!</p>
            <p class="course-description">
                Master the Internet of Things and build smart, connected systems that bridge the digital and physical worlds. 
                This course covers everything from <strong>IoT architecture and sensor integration to edge computing, cloud communication</strong>,
                and real-world IoT applications.
            </p>
            <p class="course-description">
                You'll work with microcontrollers like <strong>Arduino and Raspberry Pi, use communication 
                protocols like MQTT and HTTP</strong>, and analyze data in the cloud using platforms like <strong>AWS and ThingSpeak</strong>.
            </p>
            <p class="course-description">
                By the end of the course, you'll be equipped to <strong>design, build, and deploy</strong> scalable IoT solutions—preparing you for roles in smart 
                systems development, embedded systems, and IoT engineering.
            </p>
        </div>

        <div class="progress-bar-container">
            <div class="progress-bar-fill" id="progress-fill">0%</div>
        </div>

        <h2>Modules in the Course</h2>

        <!-- Module 1 -->
        <div class="module" onclick="toggleModule('module1','arrow1')">
            Module 1: Introduction to IoT
            <span class="arrow" id="arrow1"> &gt; </span>
        </div>
        <div class="module-details" id="module1">
            <div class="task-box" onclick="markDone('What is IoT?')">Task 1: What is IoT?</div>
            <div class="task-box" onclick="markDone('IoT Architecture')">Task 2: IoT Architecture</div>
            <div class="task-box" onclick="markDone('Components of IoT')">Task 3: Components of IoT</div>
            <div class="task-box" onclick="markDone('IoT Ecosystem and Trends')">Task 4: IoT Ecosystem and Market Trends</div>
            <div class="task-box" onclick="markDone('Challenges')">Task 5: Challenges</div>
        </div>

        <!-- Module 2 -->
        <div class="module" onclick="toggleModule('module2','arrow2')">
            Module 2: Hardware Platforms and Sensor Integration
            <span class="arrow" id="arrow2"> &gt; </span>
        </div>
        <div class="module-details" id="module2">
            <div class="task-box" onclick="markDone('Microcontrollers')">Task 1: Microcontrollers</div>
            <div class="task-box" onclick="markDone('Sensors and Actuators')">Task 2: Sensors and Actuators</div>
            <div class="task-box" onclick="markDone('GPIO Programming')">Task 3: GPIO Programming</div>
            <div class="task-box" onclick="markDone('Power Management')">Task 4: Power Management</div>
            <div class="task-box" onclick="markDone('Prototyping Tools')">Task 5: IoT Prototyping Tools</div>
        </div>

        <!-- Module 3 -->
        <div class="module" onclick="toggleModule('module3','arrow3')">
            Module 3: Communication and Networking
            <span class="arrow" id="arrow3"> &gt; </span>
        </div>
        <div class="module-details" id="module3">
            <div class="task-box" onclick="markDone('Communication Protocols')">Task 1: Communication Protocols</div>
            <div class="task-box" onclick="markDone('Networking Basics')">Task 2: Networking Basics</div>
            <div class="task-box" onclick="markDone('Data Transmission')">Task 3: IoT Data Transmission</div>
            <div class="task-box" onclick="markDone('Edge Computing')">Task 4: Edge Computing</div>
            <div class="task-box" onclick="markDone('IoT Gateways')">Task 5: IoT Gateways</div>
        </div>

        <!-- Module 4 -->
        <div class="module" onclick="toggleModule('module4','arrow4')">
            Module 4: Cloud Integration and Data Management
            <span class="arrow" id="arrow4"> &gt; </span>
        </div>
        <div class="module-details" id="module4">
            <div class="task-box" onclick="markDone('Cloud Platforms')">Task 1: Cloud Platforms for IoT</div>
            <div class="task-box" onclick="markDone('Real-Time Monitoring')">Task 2: Real-Time Data Monitoring</div>
            <div class="task-box" onclick="markDone('Data Storage')">Task 3: Data Storage</div>
            <div class="task-box" onclick="markDone('Visualization')">Task 4: Visualization</div>
            <div class="task-box" onclick="markDone('API Integration')">Task 5: API Integration</div>
        </div>

        <!-- Module 5 -->
        <div class="module" onclick="toggleModule('module5','arrow5')">
            Module 5: IoT Security, Applications and Deployment
            <span class="arrow" id="arrow5"> &gt; </span>
        </div>
        <div class="module-details" id="module5">
            <div class="task-box" onclick="markDone('IoT Security')">Task 1: IoT Security</div>
            <div class="task-box" onclick="markDone('OTA Updates')">Task 2: Over-the-Air Updates (OTA)</div>
            <div class="task-box" onclick="markDone('Case Studies')">Task 3: Case Studies</div>
            <div class="task-box" onclick="markDone('Project Deployment')">Task 4: Project Deployment</div>
            <div class="task-box" onclick="markDone('Career & Certification')">Task 5: Career and Certification</div>
        </div>

       
    </div>
</body>
</html>