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
    <title>AWS Cloud Computing Course</title>
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
        <span class="close-video" onclick="toggleModule('','')">&times;</span>
        <video controls>
            <source src="video.mp4" type="video/mp4">
            Your browser does not support the video tag.
        </video>
    </div>
    <div class="content">
        <div class="course-container">
            <h2 class="course-title">AWS Cloud Computing Course</h2>
            <p class="course-tagline">Become a proficient AWS cloud professional and accelerate your career in the world's leading cloud platform!</p>
<p class="course-description">
    Master AWS Cloud Computing and build scalable, secure, and highly available applications. 
    This course covers everything from <strong>cloud fundamentals and core AWS services to advanced architecture design</strong> and real-world cloud solutions.
</p>
<p class="course-description">
    You'll work hands-on with services like <strong>EC2, S3, Lambda, RDS, and VPC</strong>, implement networking and security best practices, 
    and manage infrastructure using tools like <strong>AWS CloudFormation and the AWS CLI</strong>.
</p>
<p class="course-description">
    By the end of the course, you'll be ready to <strong>design, deploy, and operate</strong> cloud environments—preparing you for roles in cloud architecture, DevOps, and cloud engineering.
</p>

        </div>
        <div class="progress-bar-container">
            <div class="progress-bar-fill" id="progress-fill">0%</div>
        </div>
        <h2>Modules in the Course</h2>
        <!-- Module 1 -->
        <div class="module" onclick="toggleModule('mod1','arr1')">
            Module 1: AWS Fundamentals and IAM
            <span class="arrow" id="arr1">&gt;</span>
        </div>
        <div class="module-details" id="mod1">
            <div class="task-box" onclick="markDone('AWS Global Infrastructure')">Task 1: AWS Global Infrastructure</div>
            <div class="task-box" onclick="markDone('IAM Users & Roles')">Task 2: IAM Users and Roles</div>
            <div class="task-box" onclick="markDone('Security Best Practices')">Task 3: Security Best Practices</div>
            <div class="task-box" onclick="markDone('Billing & Cost Management')">Task 4: Billing and Cost Management</div>
        </div>
        <!-- Module 2 -->
        <div class="module" onclick="toggleModule('mod2','arr2')">
            Module 2: Compute Services
            <span class="arrow" id="arr2">&gt;</span>
        </div>
        <div class="module-details" id="mod2">
            <div class="task-box" onclick="markDone('EC2 Instances')">Task 1: EC2 Instances</div>
            <div class="task-box" onclick="markDone('Auto Scaling & Load Balancing')">Task 2: Auto Scaling and Load Balancing</div>
            <div class="task-box" onclick="markDone('Lambda Functions')">Task 3: Lambda Functions</div>
            <div class="task-box" onclick="markDone('Container Services')">Task 4: ECS and EKS</div>
        </div>
        <!-- Module 3 -->
        <div class="module" onclick="toggleModule('mod3','arr3')">
            Module 3: Storage and Databases
            <span class="arrow" id="arr3">&gt;</span>
        </div>
        <div class="module-details" id="mod3">
            <div class="task-box" onclick="markDone('S3 & Glacier')">Task 1: S3 and Glacier</div>
            <div class="task-box" onclick="markDone('EBS & EFS')">Task 2: EBS and EFS</div>
            <div class="task-box" onclick="markDone('RDS & Aurora')">Task 3: RDS and Aurora</div>
            <div class="task-box" onclick="markDone('DynamoDB')">Task 4: DynamoDB</div>
        </div>
        <!-- Module 4 -->
        <div class="module" onclick="toggleModule('mod4','arr4')">
            Module 4: Networking and VPC
            <span class="arrow" id="arr4">&gt;</span>
        </div>
        <div class="module-details" id="mod4">
            <div class="task-box" onclick="markDone('VPC & Subnets')">Task 1: VPC and Subnets</div>
            <div class="task-box" onclick="markDone('Security Groups & NACLs')">Task 2: Security Groups and NACLs</div>
            <div class="task-box" onclick="markDone('Route 53 DNS')">Task 3: Route 53 DNS</div>
            <div class="task-box" onclick="markDone('Elastic Load Balancing')">Task 4: Elastic Load Balancing</div>
        </div>
        <!-- Module 5 -->
        <div class="module" onclick="toggleModule('mod5','arr5')">
            Module 5: DevOps, Monitoring and Deployment
            <span class="arrow" id="arr5">&gt;</span>
        </div>
        <div class="module-details" id="mod5">
            <div class="task-box" onclick="markDone('CloudFormation')">Task 1: CloudFormation</div>
            <div class="task-box" onclick="markDone('CI/CD with CodePipeline')">Task 2: CI/CD with CodePipeline</div>
            <div class="task-box" onclick="markDone('Monitoring with CloudWatch')">Task 3: Monitoring with CloudWatch</div>
            <div class="task-box" onclick="markDone('Logging with CloudTrail')">Task 4: Logging with CloudTrail</div>
            <div class="task-box" onclick="markDone('Serverless Deployment')">Task 5: Serverless Deployment</div>
        </div>

        
    </div>
</body>
</html>