<!-- AIML Course Container - Right Side -->
<div class="course-container" style="top: -300px; left: 650px; width: 550px;">
    <h2 style="color: #ff6600;">Machine Learning & Artificial Intelligence</h2>
    <p>Explore the fundamentals and advanced concepts of AI & ML through detailed modules.</p>

    <!-- Module 1 -->
    <div class="module">
        <button class="module-btn">Module 1: Introduction to AI & ML</button>
        <div class="module-content">
            <ul>
                <li>History of AI & ML</li>
                <li>Applications & Future Scope</li>
                <li>Types of Machine Learning</li>
            </ul>
        </div>
    </div>

    <!-- Module 2 -->
    <div class="module">
        <button class="module-btn">Module 2: Data Preprocessing & Visualization</button>
        <div class="module-content">
            <ul>
                <li>Data Cleaning Techniques</li>
                <li>Feature Engineering</li>
                <li>Exploratory Data Analysis (EDA)</li>
            </ul>
        </div>
    </div>

    <!-- Module 3 -->
    <div class="module">
        <button class="module-btn">Module 3: Supervised & Unsupervised Learning</button>
        <div class="module-content">
            <ul>
                <li>Regression and Classification</li>
                <li>Decision Trees & SVM</li>
                <li>Clustering Algorithms</li>
            </ul>
        </div>
    </div>

    <!-- Module 4 -->
    <div class="module">
        <button class="module-btn">Module 4: Neural Networks & Deep Learning</button>
        <div class="module-content">
            <ul>
                <li>Perceptrons & Backpropagation</li>
                <li>Convolutional Neural Networks (CNN)</li>
                <li>Recurrent Neural Networks (RNN)</li>
            </ul>
        </div>
    </div>

    <!-- Module 5 -->
    <div class="module">
        <button class="module-btn">Module 5: NLP & Project Deployment</button>
        <div class="module-content">
            <ul>
                <li>Text Preprocessing</li>
                <li>Sentiment Analysis</li>
                <li>Model Evaluation & Deployment</li>
            </ul>
        </div>
    </div>
</div>

<!-- CSS for Module Toggle -->
<style>
    .module {
        margin-bottom: 15px;
    }
    .module-btn {
        background-color: #ffcc66;
        padding: 12px;
        width: 100%;
        border: none;
        text-align: left;
        font-size: 16px;
        cursor: pointer;
        border-radius: 8px;
    }
    .module-btn:hover {
        background-color: #ff9900;
        color: #fff;
    }
    .module-content {
        display: none;
        background-color: #fff7e6;
        padding: 10px;
        border-radius: 8px;
    }
    .module-content ul {
        margin: 0;
        padding-left: 20px;
    }
</style>

<!-- JavaScript for Toggle -->
<script>
    const buttons = document.querySelectorAll('.module-btn');
    buttons.forEach(btn => {
        btn.addEventListener('click', () => {
            const content = btn.nextElementSibling;
            content.style.display = content.style.display === 'block' ? 'none' : 'block';
        });
    });
</script>
