<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page session="true" %>
 <%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("UserRole");

Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    java.util.Set<String> completedTasks = new java.util.HashSet<>();
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "Durga");

    
    String query = "SELECT taskName FROM progress WHERE userName = ? AND courseName = ?";
    ps = conn.prepareStatement(query);
    ps.setString(1, userName);
    ps.setString(2, "Full Stack Development");
    rs = ps.executeQuery();
    while (rs.next()) {
        completedTasks.add(rs.getString("taskName"));
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (ps != null) ps.close(); } catch (Exception e) {}
    try { if (conn != null) conn.close(); } catch (Exception e) {}
}
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
        .task-box .status {
    float: right;
    font-weight: bold;
    color: green;
}
</style>
</head>
<body>

<script>


let completedTasks = new Set([
    <% for(String task : completedTasks) { %>
        "<%= task.replace("\"", "\\\"") %>",
    <% } %>
]);


  
        function toggleModule(id, arr) {
            const det = document.getElementById(id),
                  arrow = document.getElementById(arr);
            if (det.style.display === 'block') {
                det.style.display = 'none'; arrow.style.transform = 'rotate(0deg)';
            } else {
                det.style.display = 'block'; arrow.style.transform = 'rotate(180deg)';
            }
        }

        function playVideoForTask(name) {
            const vc = document.getElementById('video-container'),
                  vs = document.getElementById('video-source'),
                  vp = document.getElementById('task-video');
            vs.src = 'videos/' + name.replace(/ /g,'_').toLowerCase() + '.mp4';
            vp.load(); vc.style.display = 'block';

            // Save to DB if not already saved
            if (!completedTasks.has(name)) {
                fetch('saveProgress.jsp?taskName=' + encodeURIComponent(name));
                completedTasks.add(name);

                const taskBoxes = document.querySelectorAll('.task-box');
                taskBoxes.forEach(task => {
                    if (task.dataset.task === name) {
                        const statusSpan = task.querySelector('.status');
                        if (statusSpan) statusSpan.innerText = '✔ Completed';
                        task.style.backgroundColor = '#d4edda';
                    }
                });

                updateProgressBar();
            }

        }

        function closeVideo() {
            document.getElementById('video-container').style.display = 'none';
        }

        function updateProgressBar() {
            const allTasks = document.querySelectorAll('.task-box');
            const bar = document.getElementById('progress-fill');
            let doneCount = 0;

            allTasks.forEach(task => {
                const taskName = task.dataset.task;
                const statusSpan = task.querySelector('.status');

                if (completedTasks.has(taskName)) {
                    doneCount++;
                    if (statusSpan) statusSpan.innerText = '✔ Completed';
                    task.style.backgroundColor = '#d4edda'; // Optional: highlight completed
                } else {
                    if (statusSpan) statusSpan.innerText = '';
                }
            });

            const progress = Math.min(doneCount * 4, 100); // 4% per task, max 100%
            bar.style.width = progress + '%';
            bar.innerText = progress + '%';
        }

        document.addEventListener('DOMContentLoaded', updateProgressBar);


  
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
        <h2 class="course-title">Full-Stack Development Course</h2>
        <p class="course-tagline">Become a skilled developer and kickstart your tech career!</p>
        <p class="course-description">
        Master the art of building modern, <strong>dynamic web applications</strong>from start to finish. 
    </p>
    <p class="course-description">
        This course covers everything from designing responsive frontends using <strong>HTML, CSS, JavaScript, 
        and React</strong>, to creating powerful backend APIs with <strong>Node.js and MongoDB</strong>. 
        You'll also learn to manage databases, implement authentication, and deploy real-world full-stack projects.
    </p>
    <p class="course-description">
        By the end of the course, you'll be able to develop, deploy, and maintain complete web applications-equipping 
        you for roles in web development, software engineering, and beyond.
    </p>

    </div>

    <div class="progress-bar-container">
        <div class="progress-bar-fill" id="progress-fill">0%</div>
    </div>

    <h2>Modules in the Course</h2>

    <%-- Each module with tasks now triggers playVideoForTask --%>
    <div class="module" onclick="toggleModule('module1', 'arrow1')">Module 1: Introduction to Web Development Basics <span class="arrow" id="arrow1"> > </span></div>
    <div class="module-details" id="module1">
        <div class="task-box" onclick="playVideoForTask('What is Web Development?')" data-task="What is Web Development?">
  Task 1:What is Web Development?<span class="status"></span>
</div>
  <div class="task-box" onclick="playVideoForTask('How the Web Works')" data-task="How the Web Works">
    Task 2:How the Web Works<span class="status"></span>
</div>
<div class="task-box" onclick="playVideoForTask('Web Development Tools and Environment Setup')" data-task="Web Development Tools and Environment Setup">
    Task 3: Web Development Tools and Environment Setup <span class="status"></span>
</div>
<div class="task-box" onclick="playVideoForTask('Introduction to HTML, CSS, and JavaScript')" data-task="Introduction to HTML, CSS, and JavaScript">
    Task 4: Introduction to HTML, CSS, and JavaScript <span class="status"></span>
</div>
<div class="task-box" onclick="playVideoForTask('Basic Web Development Workflow')" data-task="Basic Web Development Workflow">
    Task 5: Basic Web Development Workflow <span class="status"></span>
</div></div>

<!-- Module 2 -->
<div class="module" onclick="toggleModule('module2', 'arrow2')">Module 2: Advanced Frontend with React <span class="arrow" id="arrow2"> > </span></div>
<div class="module-details" id="module2">
    <div class="task-box" onclick="playVideoForTask('React Component Architecture')" data-task="React Component Architecture">
        Task 1: React Component Architecture <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Advanced State Management')" data-task="Advanced State Management">
        Task 2: Advanced State Management <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Routing with React Router')" data-task="Routing with React Router">
        Task 3: Routing with React Router <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('API Integration and Data Handling')" data-task="API Integration and Data Handling">
        Task 4: API Integration and Data Handling <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Performance Optimization & Best Practices')" data-task="Performance Optimization & Best Practices">
        Task 5: Performance Optimization and Best Practices <span class="status"></span>
    </div>
</div>

<!-- Module 3 -->
<div class="module" onclick="toggleModule('module3', 'arrow3')">Module 3: Backend Development with Node.js <span class="arrow" id="arrow3"> > </span></div>
<div class="module-details" id="module3">
    <div class="task-box" onclick="playVideoForTask('Introduction to Node.js and Express.js')" data-task="Introduction to Node.js and Express.js">
        Task 1: Introduction to Node.js and Express.js <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Working with RESTful APIs')" data-task="Working with RESTful APIs">
        Task 2: Working with RESTful APIs <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Connecting to a Database (MongoDB)')" data-task="Connecting to a Database (MongoDB)">
        Task 3: Connecting to a Database (MongoDB) <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Middleware and Authentication')" data-task="Middleware and Authentication">
        Task 4: Middleware and Authentication <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Project Structure & Deployment Basics')" data-task="Project Structure & Deployment Basics">
        Task 5: Project Structure and Deployment Basics <span class="status"></span>
    </div>
</div>

<!-- Module 4 -->
<div class="module" onclick="toggleModule('module4', 'arrow4')">Module 4: Database Management with MongoDB <span class="arrow" id="arrow4"> > </span></div>
<div class="module-details" id="module4">
    <div class="task-box" onclick="playVideoForTask('Introduction to Databases and MongoDB')" data-task="Introduction to Databases and MongoDB">
        Task 1: Introduction to Databases and MongoDB <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('CRUD Operations in MongoDB')" data-task="CRUD Operations in MongoDB">
        Task 2: CRUD Operations in MongoDB <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Mongoose and Data Modeling')" data-task="Mongoose and Data Modeling">
        Task 3: Mongoose and Data Modeling <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Indexes, Aggregation, and Performance Optimization')" data-task="Indexes, Aggregation, and Performance Optimization">
        Task 4: Indexes, Aggregation, and Performance Optimization <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Database Security and Backup')" data-task="Database Security and Backup">
        Task 5: Database Security and Backup <span class="status"></span>
    </div>
</div>

<!-- Module 5 -->
<div class="module" onclick="toggleModule('module5', 'arrow5')">Module 5: Deployment and DevOps Basics <span class="arrow" id="arrow5"> > </span></div>
<div class="module-details" id="module5">
    <div class="task-box" onclick="playVideoForTask('Introduction to Deployment and DevOps')" data-task="Introduction to Deployment and DevOps">
        Task 1: Introduction to Deployment and DevOps <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Hosting Frontend and Backend Applications')" data-task="Hosting Frontend and Backend Applications">
        Task 2: Hosting Frontend and Backend Applications <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Version Control and GitHub Workflow')" data-task="Version Control and GitHub Workflow">
        Task 3: Version Control and GitHub Workflow <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Introduction to Containers and Docker')" data-task="Introduction to Containers and Docker">
        Task 4: Introduction to Containers and Docker <span class="status"></span>
    </div>
    <div class="task-box" onclick="playVideoForTask('Basic CI/CD Pipeline Setup')" data-task="Basic CI/CD Pipeline Setup">
        Task 5: Basic CI/CD Pipeline Setup <span class="status"></span>
    </div>
</div>

</body>
</html>