<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Test AI Chatbot - TechSign</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background: #f5f5f5;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #1b5e20;
            text-align: center;
        }
        .test-section {
            margin: 20px 0;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .test-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 15px 0;
        }
        .test-btn {
            background: #1b5e20;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .test-btn:hover {
            background: #43ea7c;
        }
        .result {
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
            border-left: 4px solid #1b5e20;
            white-space: pre-wrap;
        }
        .success {
            border-left-color: #28a745;
            background: #d4edda;
        }
        .error {
            border-left-color: #dc3545;
            background: #f8d7da;
        }
        .info {
            background: #d1ecf1;
            border-left-color: #17a2b8;
        }
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .feature-card {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #1b5e20;
        }
        .feature-card h3 {
            color: #1b5e20;
            margin-top: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🤖 Test TechSign AI Chatbot</h1>

        <div class="test-section">
            <h3>✅ Trạng thái hệ thống</h3>
            <p><strong>Context Path:</strong> <%= request.getContextPath() %></p>
            <p><strong>Thời gian:</strong> <%= new java.util.Date() %></p>
            <p><strong>Servlet URL:</strong> <%= request.getContextPath() %>/techsign-ai-chatbot</p>
            <p><strong>API Key:</strong> Đã cấu hình Google Gemini AI</p>
        </div>

        <div class="test-section">
            <h3>🔧 Test Servlet AI</h3>
            <div class="test-buttons">
                <button class="test-btn" onclick="testServlet('xin chào')">Test: Xin chào</button>
                <button class="test-btn" onclick="testServlet('tìm việc java')">Test: Tìm việc Java</button>
                <button class="test-btn" onclick="testServlet('việc làm react')">Test: Việc làm React</button>
                <button class="test-btn" onclick="testServlet('lương cao')">Test: Lương cao</button>
                <button class="test-btn" onclick="testServlet('công ty tốt')">Test: Công ty tốt</button>
                <button class="test-btn" onclick="testServlet('hà nội')">Test: Hà Nội</button>
                <button class="test-btn" onclick="testServlet('remote work')">Test: Remote work</button>
                <button class="test-btn" onclick="testServlet('junior developer')">Test: Junior developer</button>
            </div>
            <div id="servlet-result"></div>
        </div>

        <div class="test-section">
            <h3>🎯 Test Chatbot Component</h3>
<<<<<<< HEAD
            <p>Nếu chatbot component hoạt động, bạn sẽ thấy nút 🤖 ở góc phải dưới màn hình.</p>
=======
            <p>Nếu chatbot component hoạt động, bạn sẽ thấy nút 💬 ở góc phải dưới màn hình.</p>
>>>>>>> 0afdcb29c1f79bf1ecb57703469c15dacc5f22b5
            <button class="test-btn" onclick="window.location.href='index.jsp'">Mở trang chủ để test chatbot</button>
        </div>

        <div class="test-section">
            <h3>🚀 Tính năng AI Chatbot</h3>
            <div class="feature-grid">
                <div class="feature-card">
                    <h3>🔍 Tìm kiếm thông minh</h3>
                    <p>• Tìm việc làm theo từ khóa</p>
                    <p>• Lọc theo địa điểm, công nghệ</p>
                    <p>• Hiển thị thông tin chi tiết</p>
                </div>
                <div class="feature-card">
                    <h3>🤖 AI Gemini</h3>
                    <p>• Trả lời thông minh</p>
                    <p>• Tư vấn chuyên nghiệp</p>
                    <p>• Hỗ trợ đa dạng câu hỏi</p>
                </div>
                <div class="feature-card">
                    <h3>💼 Tích hợp Database</h3>
                    <p>• Kết nối với job_postings</p>
                    <p>• Hiển thị việc làm thực tế</p>
                    <p>• Thông tin công ty chi tiết</p>
                </div>
                <div class="feature-card">
                    <h3>🎨 Giao diện đẹp</h3>
                    <p>• Thiết kế hiện đại</p>
                    <p>• Typing indicator</p>
                    <p>• Responsive design</p>
                </div>
            </div>
        </div>

        <div class="test-section">
            <h3>📋 Hướng dẫn test</h3>
            <ol>
                <li>Click vào các nút test để kiểm tra servlet AI</li>
                <li>Mở trang chủ để test chatbot component</li>
<<<<<<< HEAD
                <li>Click vào nút 🤖 để mở chatbot</li>
=======
                <li>Click vào nút 💬 để mở chatbot</li>
>>>>>>> 0afdcb29c1f79bf1ecb57703469c15dacc5f22b5
                <li>Thử gửi tin nhắn trong chatbot</li>
                <li>Test các tính năng: tìm việc, hỏi lương, tư vấn...</li>
            </ol>
        </div>

        <div class="test-section">
            <h3>⚠️ Lưu ý quan trọng</h3>
            <div class="result info">
                • Cần restart Tomcat để load servlet mới<br>
                • Đảm bảo database có dữ liệu job_postings<br>
                • API Key Google Gemini đã được cấu hình<br>
                • Chatbot sẽ hiển thị việc làm thực tế từ database
            </div>
        </div>
    </div>

    <script>
        function testServlet(message) {
            const resultDiv = document.getElementById('servlet-result');
            resultDiv.innerHTML = '<div class="result">🔄 Đang test AI chatbot...</div>';

            fetch('<%= request.getContextPath() %>/techsign-ai-chatbot', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'message=' + encodeURIComponent(message)
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('HTTP ' + response.status);
                }
            })
            .then(data => {
                resultDiv.innerHTML = `
                    <div class="result success">
                        ✅ <strong>AI Chatbot hoạt động!</strong><br>
                        <strong>Tin nhắn gửi:</strong> ${message}<br>
                        <strong>Phản hồi AI:</strong><br>${data.reply}
                    </div>
                `;
            })
            .catch(error => {
                resultDiv.innerHTML = `
                    <div class="result error">
                        ❌ <strong>Lỗi AI chatbot:</strong> ${error.message}<br>
                        <strong>Nguyên nhân có thể:</strong><br>
                        • Chưa restart Tomcat<br>
                        • Lỗi kết nối database<br>
                        • API Key không hợp lệ<br>
                        • Lỗi mạng
                    </div>
                `;
            });
        }
    </script>
</body>
</html> 