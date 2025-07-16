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
    <title>Blockchain & Cryptocurrency Course</title>
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
        .user-name { font-size: 22px; font-weight: bold; margin-bottom: 2px; }
        .user-role { font-size: 16px; color: gray; }

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
        .course-title { font-size: 28px; color: #cc6600; margin-bottom: 10px; }
        .course-tagline { font-size: 20px; font-weight: bold; color: #333; margin-bottom: 15px; }
        .course-description { font-size: 16px; line-height: 1.6; color: #444; margin-bottom: 15px; }

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
    </style>
    <script>
        let completedTasks = new Set();
        function toggleModule(id, arr) {
            const det = document.getElementById(id),
                  arrow = document.getElementById(arr);
            if (det.style.display==='block') {
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
</div>    <div class="content">
        <div class="course-container">
            <h2 class="course-title">Blockchain & Cryptocurrency Course</h2>
            <p class="course-tagline">Become a blockchain expert and dive into the world of digital currency!</p>
            <p class="course-description">
                Master the principles of blockchain and cryptocurrency to build decentralized applications and digital assets.
            </p>
            <p class="course-description">
                You'll explore <strong>cryptographic foundations, consensus algorithms, and smart contract development</strong> on platforms like Ethereum and Hyperledger.
            </p>
            <p class="course-description">
                Gain hands-on experience with wallets, token creation, DeFi protocols, NFT standards, and develop secure, scalable blockchain solutions.
            </p>
        </div>
        <div class="progress-bar-container">
            <div class="progress-bar-fill" id="progress-fill">0%</div>
        </div>

        <h2>Modules in the Course</h2>

        <!-- Module 1 -->
        <div class="module" onclick="toggleModule('mod1','arr1')">
            Module 1: Introduction to Blockchain
            <span class="arrow" id="arr1">&gt;</span>
        </div>
        <div class="module-details" id="mod1">
            <div class="task-box" onclick="markDone('History of Blockchain')">Task 1: History of Blockchain</div>
            <div class="task-box" onclick="markDone('Key Concepts')">Task 2: Key Concepts (Ledger, Nodes)</div>
            <div class="task-box" onclick="markDone('Types of Blockchains')">Task 3: Types of Blockchains (Public vs Private)</div>
            <div class="task-box" onclick="markDone('Use Cases')">Task 4: Real-World Use Cases</div>
        </div>

        <!-- Module 2 -->
        <div class="module" onclick="toggleModule('mod2','arr2')">
            Module 2: Cryptography & Consensus
            <span class="arrow" id="arr2">&gt;</span>
        </div>
        <div class="module-details" id="mod2">
            <div class="task-box" onclick="markDone('Hash Functions')">Task 1: Hash Functions and Merkle Trees</div>
            <div class="task-box" onclick="markDone('Public-Key Crypto')">Task 2: Public-Key Cryptography</div>
            <div class="task-box" onclick="markDone('Proof of Work')">Task 3: Proof of Work</div>
            <div class="task-box" onclick="markDone('Proof of Stake')">Task 4: Proof of Stake & Variants</div>
        </div>

        <!-- Module 3 -->
        <div class="module" onclick="toggleModule('mod3','arr3')">
            Module 3: Platforms & Smart Contracts
            <span class="arrow" id="arr3">&gt;</span>
        </div>
        <div class="module-details" id="mod3">
            <div class="task-box" onclick="markDone('Ethereum Basics')">Task 1: Ethereum Basics</div>
            <div class="task-box" onclick="markDone('Solidity Programming')">Task 2: Solidity Programming</div>
            <div class="task-box" onclick="markDone('Hyperledger Fabric')">Task 3: Hyperledger Fabric Overview</div>
            <div class="task-box" onclick="markDone('Smart Contract Security')">Task 4: Smart Contract Security</div>
        </div>

        <!-- Module 4 -->
        <div class="module" onclick="toggleModule('mod4','arr4')">
            Module 4: Cryptocurrencies & DeFi
            <span class="arrow" id="arr4">&gt;</span>
        </div>
        <div class="module-details" id="mod4">
            <div class="task-box" onclick="markDone('Bitcoin Architecture')">Task 1: Bitcoin Architecture</div>
            <div class="task-box" onclick="markDone('Wallets & Addresses')">Task 2: Wallets and Addresses</div>
            <div class="task-box" onclick="markDone('DeFi Protocols')">Task 3: DeFi Protocols</div>
            <div class="task-box" onclick="markDone('Stablecoins & Tokens')">Task 4: Stablecoins & Token Standards</div>
        </div>

        <!-- Module 5 -->
        <div class="module" onclick="toggleModule('mod5','arr5')">
            Module 5: NFTs, Scaling & Future Trends
            <span class="arrow" id="arr5">&gt;</span>
        </div>
        <div class="module-details" id="mod5">
            <div class="task-box" onclick="markDone('NFT Standards')">Task 1: NFT Standards (ERC-721)</div>
            <div class="task-box" onclick="markDone('Layer 2 Solutions')">Task 2: Layer 2 Scaling Solutions</div>
            <div class="task-box" onclick="markDone('Cross-Chain')">Task 3: Cross-Chain Interoperability</div>
            <div class="task-box" onclick="markDone('Future of Web3')">Task 4: Future of Web3</div>
        </div>

        
    </div>
</body>
</html>