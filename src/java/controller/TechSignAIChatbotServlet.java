package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.stream.Collectors;
import dao.DBContext;
import model.User;

public class TechSignAIChatbotServlet extends HttpServlet {
//    private static final String API_KEY = "AIzaSyAl0qgyIdPRk-69Avt5iYps3Gm1YZdFY-A";
//    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String userMessage = request.getParameter("message");
            if (userMessage == null || userMessage.trim().isEmpty()) {
                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("reply", "Xin chào! Bạn cần tôi giúp gì?");
                out.write(jsonResponse.toString());
                return;
            }

            // Lấy thông tin người dùng từ session
            String userName = getUserNameFromSession(request);
            String userRole = getUserRoleFromSession(request);

            // Bước 1: Phân loại loại câu hỏi
            String questionType = classifyQuestionType(userMessage);
            
            // Bước 2: Xử lý theo loại câu hỏi
            String reply = "";
            
            if (questionType.equals("OFF_TOPIC")) {
                // Câu hỏi không liên quan - chuyển hướng về chủ đề việc làm
                reply = "🤖 Xin lỗi, tôi là trợ lý AI chuyên về việc làm và nghề nghiệp IT. " +
                       "Tôi không thể trả lời câu hỏi này vì nó không liên quan đến mục đích của TechSign. " +
                       "Tôi có thể giúp bạn: tìm việc, tư vấn CV, phỏng vấn, hoặc thông tin về thị trường IT Việt Nam. " +
                       "Bạn có câu hỏi gì về việc làm không? 💼";
            } else if (questionType.equals("JOB_SEARCH")) {
                // Câu hỏi về việc làm - tìm trong database
                String keyword = extractKeyword(userMessage);
                String jobInfo = getJobInfoFromDB(keyword, request);
                
                if (!jobInfo.contains("Chưa có việc làm") && !jobInfo.contains("nói rõ hơn")) {
                    reply = jobInfo;
                } else {
                    // Không tìm thấy việc làm cụ thể, đề xuất việc làm thông minh
                    String suggestedJobs = getSuggestedJobs(userRole, request);
                    String prompt = buildPrompt(userMessage, "Đề xuất việc làm: " + suggestedJobs, userName, userRole, questionType);
                    reply = generateAIResponse(prompt);
                }
            } else if (questionType.equals("SYSTEM_STATS")) {
                // Câu hỏi về thống kê hệ thống - truy vấn database thực tế
                String systemStats = getSystemStatsFromDB(request);
                String prompt = buildPrompt(userMessage, "Thống kê hệ thống: " + systemStats, userName, userRole, questionType);
                reply = generateAIResponse(prompt);
            } else if (questionType.equals("DATABASE_QUERY")) {
                // Câu hỏi về database - xử lý linh hoạt
                String dbResult = processDatabaseQuery(userMessage, request);
                String prompt = buildPrompt(userMessage, "Kết quả database: " + dbResult, userName, userRole, questionType);
                reply = generateAIResponse(prompt);
            } else {
                // Các loại câu hỏi khác - gọi AI với context phù hợp
                String prompt = buildPrompt(userMessage, "", userName, userRole, questionType);
                reply = generateAIResponse(prompt);
            }

            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("reply", reply);
            out.write(jsonResponse.toString());

        } catch (Exception e) {
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("reply", "Xin lỗi, có lỗi xảy ra. Vui lòng thử lại sau.");
            out.write(jsonResponse.toString());
        } finally {
            out.close();
        }
    }

    // Hàm lấy tên người dùng từ session
    private String getUserNameFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object userObj = session.getAttribute("user");
            if (userObj instanceof User) {
                User user = (User) userObj;
                return user.getFullName() != null ? user.getFullName() : user.getEmail();
            }
        }
        return null;
    }

    // Hàm lấy role người dùng từ session
    private String getUserRoleFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object userObj = session.getAttribute("user");
            if (userObj instanceof User) {
                User user = (User) userObj;
                return user.getRoleName();
            }
        }
        return null;
    }

    private String cleanText(String text) {
        return text.toLowerCase().replaceAll("[^a-z0-9\\s]", "");
    }

    // Hàm phân loại loại câu hỏi
    private String classifyQuestionType(String message) {
        message = message.toLowerCase();
        
        // Câu hỏi về việc làm
        if (message.contains("việc làm") || message.contains("job") || message.contains("tuyển dụng") || 
            message.contains("tìm việc") || message.contains("công việc") || message.contains("nghề nghiệp")) {
            return "JOB_SEARCH";
        }
        
        // Câu hỏi về CV/Resume
        if (message.contains("cv") || message.contains("resume") || message.contains("hồ sơ") || 
            message.contains("sơ yếu lý lịch") || message.contains("portfolio")) {
            return "CV_ADVICE";
        }
        
        // Câu hỏi về phỏng vấn
        if (message.contains("phỏng vấn") || message.contains("interview") || message.contains("câu hỏi phỏng vấn") ||
            message.contains("trả lời phỏng vấn") || message.contains("tips phỏng vấn")) {
            return "INTERVIEW";
        }
        
        // Câu hỏi về kỹ năng
        if (message.contains("kỹ năng") || message.contains("skill") || message.contains("học") || 
            message.contains("training") || message.contains("đào tạo")) {
            return "SKILLS";
        }
        
        // Câu hỏi về công ty
        if (message.contains("công ty") || message.contains("company") || message.contains("doanh nghiệp") ||
            message.contains("startup") || message.contains("tập đoàn")) {
            return "COMPANY_INFO";
        }
        
        // Câu hỏi về lương
        if (message.contains("lương") || message.contains("salary") || message.contains("thu nhập") ||
            message.contains("mức lương") || message.contains("lương thưởng")) {
            return "SALARY";
        }
        
        // Câu hỏi về TechSign
        if (message.contains("techsign") || message.contains("website") || message.contains("hướng dẫn") ||
            message.contains("sử dụng") || message.contains("tính năng")) {
            return "TECHSIGN_HELP";
        }
        
        // Câu hỏi về thống kê hệ thống
        if (message.contains("số tài khoản") || message.contains("thống kê") || message.contains("users") ||
            message.contains("người dùng") || message.contains("tài khoản") || message.contains("số liệu")) {
            return "SYSTEM_STATS";
        }
        
        // Câu hỏi về database/query
        if (message.contains("database") || message.contains("query") || message.contains("truy vấn") ||
            message.contains("select") || message.contains("count") || message.contains("tìm kiếm") ||
            message.contains("danh sách") || message.contains("liệt kê") || message.contains("hiển thị")) {
            return "DATABASE_QUERY";
        }
        
        // Câu hỏi chung về IT/tech
        if (message.contains("it") || message.contains("công nghệ") || message.contains("tech") ||
            message.contains("programming") || message.contains("lập trình")) {
            return "IT_GENERAL";
        }
        
        // Nhận diện câu hỏi trắc nghiệm (có cấu trúc "Câu X. ... A. B. C. D.")
        if (message.matches(".*Câu\\s*\\d+\\..*[A-D]\\..*[A-D]\\..*[A-D]\\..*[A-D]\\..*")) {
            return "OFF_TOPIC";
        }
        
        // Câu hỏi không liên quan đến mục đích website
        if (message.contains("bài thơ") || message.contains("thơ") || message.contains("văn học") ||
            message.contains("âm nhạc") || message.contains("phim") || message.contains("game") ||
            message.contains("thể thao") || message.contains("nấu ăn") || message.contains("du lịch") ||
            message.contains("kim loại") || message.contains("hóa học") || message.contains("vật lý") ||
            message.contains("toán học") || message.contains("sinh học") || message.contains("lịch sử") ||
            message.contains("địa lý") || message.contains("văn học") || message.contains("triết học") ||
            message.contains("tâm lý") || message.contains("xã hội học") || message.contains("kinh tế học") ||
            message.contains("chính trị") || message.contains("luật") || message.contains("y học") ||
            message.contains("nghệ thuật") || message.contains("kiến trúc") || message.contains("thời trang") ||
            message.contains("ẩm thực") || message.contains("du lịch") || message.contains("thể dục") ||
            message.contains("câu đố") || message.contains("trò chơi") || message.contains("giải trí") ||
            message.contains("cô giáo") || message.contains("thầy giáo") || message.contains("giáo viên") ||
            message.contains("mở lòng") || message.contains("chia sẻ") || message.contains("tâm sự") ||
            message.contains("tình cảm") || message.contains("yêu đương") || message.contains("hẹn hò") ||
            message.contains("gia đình") || message.contains("bạn bè") || message.contains("mối quan hệ") ||
            message.contains("cuộc sống") || message.contains("sức khỏe") || message.contains("tâm linh") ||
            message.contains("phong thủy") || message.contains("bói toán") || message.contains("tử vi")) {
            return "OFF_TOPIC";
        }
        
        return "GENERAL";
    }

    // Hàm trích keyword từ câu hỏi
    private String extractKeyword(String message) {
        message = message.toLowerCase();
        
        // Keywords cho việc làm
        if (message.contains("java") || message.contains("lập trình java")) return "java";
        if (message.contains("python") || message.contains("lập trình python")) return "python";
        if (message.contains("javascript") || message.contains("js")) return "javascript";
        if (message.contains("react") || message.contains("frontend")) return "react";
        if (message.contains("node") || message.contains("backend")) return "nodejs";
        if (message.contains("sql") || message.contains("database")) return "sql";
        if (message.contains("android") || message.contains("mobile")) return "android";
        if (message.contains("ios") || message.contains("iphone")) return "ios";
        if (message.contains("devops") || message.contains("deployment")) return "devops";
        if (message.contains("ui") || message.contains("ux") || message.contains("design")) return "design";
        if (message.contains("data") || message.contains("analytics")) return "data";
        if (message.contains("ai") || message.contains("machine learning")) return "ai";
        if (message.contains("fullstack") || message.contains("full stack")) return "fullstack";
        if (message.contains("intern") || message.contains("thực tập")) return "intern";
        if (message.contains("junior") || message.contains("mới ra trường")) return "junior";
        if (message.contains("senior") || message.contains("kinh nghiệm")) return "senior";
        if (message.contains("manager") || message.contains("quản lý")) return "manager";
        if (message.contains("remote") || message.contains("làm từ xa")) return "remote";
        if (message.contains("part-time") || message.contains("bán thời gian")) return "part-time";
        if (message.contains("full-time") || message.contains("toàn thời gian")) return "full-time";
        if (message.contains("hà nội") || message.contains("hanoi")) return "hà nội";
        if (message.contains("hồ chí minh") || message.contains("hcm") || message.contains("tp.hcm")) return "hồ chí minh";
        if (message.contains("đà nẵng")) return "đà nẵng";
        if (message.contains("việc làm") || message.contains("job")) return "việc làm";
        if (message.contains("lương") || message.contains("salary")) return "lương";
        if (message.contains("công ty") || message.contains("company")) return "công ty";
        
        return "";
    }

    // Hàm lấy thông tin việc làm từ database
    private String getJobInfoFromDB(String keyword, HttpServletRequest request) throws SQLException {
        if (keyword.isEmpty()) {
            return "💡 Hãy nói rõ hơn về việc làm bạn quan tâm. Ví dụ: 'Tìm việc Java', 'Việc làm React', 'Lương cao'...";
        }

        StringBuilder sb = new StringBuilder();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBContext.getConnection();

            String sql = "SELECT TOP 3 jp.title, jp.description, jp.location, jp.salary_min, jp.salary_max, " +
                        "cp.company_name, jp.job_type, jp.posted_at " +
                        "FROM job_postings jp " +
                        "INNER JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                        "WHERE jp.status = 'open' AND " +
                        "(jp.title LIKE ? OR jp.description LIKE ? OR cp.company_name LIKE ? OR jp.location LIKE ?) " +
                        "ORDER BY jp.posted_at DESC";
            
            ps = conn.prepareStatement(sql);
            String likeKeyword = "%" + keyword + "%";
            ps.setString(1, likeKeyword);
            ps.setString(2, likeKeyword);
            ps.setString(3, likeKeyword);
            ps.setString(4, likeKeyword);
            rs = ps.executeQuery();

            boolean hasData = false;
            String contextPath = request.getContextPath();

            sb.append("🔍 <strong>Việc làm phù hợp:</strong><br><br>");

            while (rs.next()) {
                hasData = true;
                String title = rs.getString("title");
                String description = rs.getString("description");
                String location = rs.getString("location");
                Double salaryMin = rs.getDouble("salary_min");
                Double salaryMax = rs.getDouble("salary_max");
                String companyName = rs.getString("company_name");
                String jobType = rs.getString("job_type");
                Timestamp postedAt = rs.getTimestamp("posted_at");

                // Format salary
                String salaryText = "Thương lượng";
                if (salaryMin != null && salaryMax != null) {
                    salaryText = String.format("%.0f - %.0f triệu VNĐ", salaryMin, salaryMax);
                } else if (salaryMin != null) {
                    salaryText = String.format("Từ %.0f triệu VNĐ", salaryMin);
                } else if (salaryMax != null) {
                    salaryText = String.format("Đến %.0f triệu VNĐ", salaryMax);
                }

                // Format job type
                String jobTypeText = jobType != null ? jobType : "Toàn thời gian";

                sb.append(String.format(
                    "<div style='background: #f8f9fa; padding: 12px; border-radius: 6px; margin-bottom: 8px; border-left: 3px solid #28a745;'>" +
                    "<strong style='color: #28a745;'>%s</strong><br>" +
                    "<small style='color: #666;'>🏢 %s | 📍 %s | 💰 %s | ⏰ %s</small><br>" +
                    "<small style='color: #888;'>%s</small>" +
                    "</div>",
                    title, companyName, location, salaryText, jobTypeText,
                    description != null ? (description.length() > 100 ? description.substring(0, 100) + "..." : description) : "Không có mô tả"
                ));
            }

            if (!hasData) {
                return "😔 Chưa có việc làm phù hợp. Thử từ khóa khác hoặc đăng ký nhận thông báo nhé!";
            }

            sb.append("<br><small>💡 Click vào việc làm để xem chi tiết và ứng tuyển!</small>");

            return sb.toString();

        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }

    // Hàm tạo prompt cho AI - TRAINED VERSION
    private String buildPrompt(String userMessage, String jobInfoText, String userName, String userRole, String questionType) {
        String greeting = "";
        if (userName != null && !userName.trim().isEmpty()) {
            greeting = "Người dùng: " + userName + " (" + (userRole != null ? userRole : "Guest") + ")";
        } else {
            greeting = "Người dùng: Khách";
        }
        
        String contextPrompt = getContextByQuestionType(questionType);
        
        String basePrompt = "Bạn là TechSign AI Assistant - trợ lý AI thông minh của nền tảng tìm việc làm công nghệ hàng đầu Việt Nam.\n\n" +
                           "THÔNG TIN NGƯỜI DÙNG:\n" +
                           greeting + "\n\n" +
                           
                           "LOẠI CÂU HỎI: " + questionType + "\n" +
                           "CONTEXT CHUYÊN MÔN:\n" + contextPrompt + "\n\n" +
                           
                           "QUY TẮC TRẢ LỜI:\n" +
                           "1. Trả lời NGẮN GỌN, SÚC TÍCH (tối đa 3-4 câu)\n" +
                           "2. Chuyên nghiệp, thân thiện, không dài dòng\n" +
                           "3. Sử dụng emoji phù hợp (1-2 emoji/câu trả lời)\n" +
                           "4. Tiếng Việt tự nhiên, dễ hiểu\n" +
                           "5. KHÔNG sử dụng ký tự ***, markdown, hoặc format đặc biệt\n" +
                           "6. Trả lời trực tiếp, không lặp lại câu hỏi\n" +
                           "7. Đưa ra lời khuyên cụ thể, thực tế\n" +
                           "8. Nếu biết tên người dùng, gọi tên họ một cách lịch sự\n" +
                           "9. LUÔN liên kết về TechSign và khuyến khích sử dụng nền tảng\n\n" +
                           
                           "KIẾN THỨC TECHSIGN:\n" +
                           "- Nền tảng kết nối ứng viên và công ty công nghệ\n" +
                           "- 3 loại tài khoản: Admin, Company, Candidate\n" +
                           "- Tính năng: đăng tin, tìm việc, quản lý hồ sơ, chat real-time\n" +
                           "- Tìm việc theo: công nghệ, địa điểm, lương, kinh nghiệm\n\n" +
                           
                           "CÂU HỎI: \"" + userMessage + "\"\n\n";

        if (jobInfoText.contains("Chưa có việc làm") || jobInfoText.contains("nói rõ hơn") || jobInfoText.isEmpty()) {
            return basePrompt + "Trả lời ngắn gọn, hướng dẫn sử dụng TechSign hiệu quả.";
        } else {
            return basePrompt + "Thông tin việc làm:\n" + jobInfoText + 
                   "\n\nTrả lời ngắn gọn, hướng dẫn ứng tuyển và tính năng TechSign.";
        }
    }

    // Hàm lấy context theo loại câu hỏi
    private String getContextByQuestionType(String questionType) {
        switch (questionType) {
            case "JOB_SEARCH":
                return "CHUYÊN MÔN TÌM VIỆC:\n" +
                       "- Thị trường IT Việt Nam: Java, Python, React, Node.js, Mobile, AI/ML\n" +
                       "- Mức lương theo kinh nghiệm: Junior (8-15M), Mid (15-30M), Senior (30-60M+)\n" +
                       "- Địa điểm hot: Hà Nội, TP.HCM, Đà Nẵng, Remote\n" +
                       "- Xu hướng: AI/ML, Cloud, DevOps, Full-stack\n" +
                       "- Gợi ý: Tìm việc trên TechSign, cập nhật profile thường xuyên";
                
            case "CV_ADVICE":
                return "CHUYÊN MÔN CV:\n" +
                       "- CV IT nên có: Skills, Projects, Experience, Education\n" +
                       "- Format: 1-2 trang, PDF, dễ đọc\n" +
                       "- Keywords: Java, React, SQL, Git, Agile\n" +
                       "- Projects: GitHub link, demo, tech stack\n" +
                       "- Gợi ý: Tạo CV trên TechSign, showcase projects";
                
            case "INTERVIEW":
                return "CHUYÊN MÔN PHỎNG VẤN:\n" +
                       "- Chuẩn bị: Research công ty, practice coding, dress code\n" +
                       "- Câu hỏi thường gặp: Tell me about yourself, Why this company, Technical questions\n" +
                       "- Kỹ năng: Communication, Problem-solving, Teamwork\n" +
                       "- Follow-up: Thank you email, LinkedIn connection\n" +
                       "- Gợi ý: Xem job requirements trên TechSign, prepare accordingly";
                
            case "SKILLS":
                return "CHUYÊN MÔN KỸ NĂNG:\n" +
                       "- Technical: Programming languages, Frameworks, Tools\n" +
                       "- Soft skills: Communication, Leadership, Problem-solving\n" +
                       "- Learning: Online courses, Certifications, Projects\n" +
                       "- Trends: AI/ML, Cloud, Cybersecurity, Blockchain\n" +
                       "- Gợi ý: Cập nhật skills trên TechSign profile";
                
            case "COMPANY_INFO":
                return "CHUYÊN MÔN CÔNG TY:\n" +
                       "- Công ty IT VN: FPT, VNG, Tiki, Shopee, Grab\n" +
                       "- Startup: Tiki, Momo, VNPay, Be Group\n" +
                       "- MNC: Microsoft, Google, Amazon, Samsung\n" +
                       "- Culture: Work-life balance, Learning, Growth\n" +
                       "- Gợi ý: Xem company profiles trên TechSign";
                
            case "SALARY":
                return "CHUYÊN MÔN LƯƠNG:\n" +
                       "- Mức lương IT VN 2024:\n" +
                       "  + Junior (0-2 năm): 8-20M VNĐ\n" +
                       "  + Mid (2-5 năm): 20-40M VNĐ\n" +
                       "  + Senior (5+ năm): 40-80M+ VNĐ\n" +
                       "- Benefits: 13th month, bonus, insurance, stock options\n" +
                       "- Negotiation: Research market, highlight value, be confident\n" +
                       "- Gợi ý: Xem salary ranges trên TechSign job postings";
                
            case "TECHSIGN_HELP":
                return "CHUYÊN MÔN TECHSIGN:\n" +
                       "- Tính năng chính: Job search, Company profiles, Real-time chat\n" +
                       "- Tài khoản: Đăng ký free, upload CV, apply jobs\n" +
                       "- Tìm việc: Filter by location, salary, skills, experience\n" +
                       "- Company: Post jobs, manage applications, view analytics\n" +
                       "- Admin: User management, system monitoring, reports";
                
            case "IT_GENERAL":
                return "CHUYÊN MÔN IT TỔNG QUAN:\n" +
                       "- Ngành IT VN: Tăng trưởng 15-20%/năm\n" +
                       "- Hot jobs: AI/ML Engineer, DevOps, Full-stack Developer\n" +
                       "- Skills demand: Python, React, Node.js, Cloud (AWS/Azure)\n" +
                       "- Career path: Developer → Senior → Lead → Manager\n" +
                       "- Gợi ý: Theo dõi trends trên TechSign";
                
            case "SYSTEM_STATS":
                return "CHUYÊN MÔN THỐNG KÊ HỆ THỐNG:\n" +
                       "- Users: Admin, Company, Candidate accounts\n" +
                       "- Job postings: Open/closed status, total count\n" +
                       "- Company profiles: Registered companies\n" +
                       "- Messages: Chat system usage\n" +
                       "- Gợi ý: Truy cập admin panel để xem chi tiết";
                
            case "DATABASE_QUERY":
                return "CHUYÊN MÔN TRUY VẤN DATABASE:\n" +
                       "- Users: Admin, Company, Candidate lists\n" +
                       "- Jobs: Recent postings, status, salary info\n" +
                       "- Companies: Industry, location, job count\n" +
                       "- Messages: Recent chat history\n" +
                       "- Analytics: Recent data, top performers\n" +
                       "- Gợi ý: Sử dụng từ khóa cụ thể để lấy thông tin chi tiết";
                
            default:
                return "CHUYÊN MÔN CHUNG:\n" +
                       "- TechSign: Nền tảng tìm việc IT hàng đầu VN\n" +
                       "- Services: Job matching, CV builder, Interview prep\n" +
                       "- Community: IT professionals, Career advice, Networking\n" +
                       "- Success: 10,000+ jobs posted, 50,000+ users\n" +
                       "- Gợi ý: Khám phá TechSign để phát triển sự nghiệp";
        }
    }

    // Hàm đề xuất việc làm thông minh dựa trên role
    private String getSuggestedJobs(String userRole, HttpServletRequest request) {
        try {
            Connection conn = DBContext.getConnection();
            String sql = "SELECT TOP 5 jp.title, cp.company_name, jp.location, jp.salary_min, jp.salary_max " +
                        "FROM job_postings jp " +
                        "INNER JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                        "WHERE jp.status = 'open' ";
            
            // Đề xuất theo role
            if ("Candidate".equals(userRole)) {
                sql += "AND (jp.title LIKE '%junior%' OR jp.title LIKE '%intern%' OR jp.title LIKE '%fresher%') ";
            } else if ("Company".equals(userRole)) {
                sql += "AND (jp.title LIKE '%senior%' OR jp.title LIKE '%manager%' OR jp.title LIKE '%lead%') ";
            }
            
            sql += "ORDER BY jp.posted_at DESC";
            
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            StringBuilder suggestions = new StringBuilder();
            suggestions.append("💡 <strong>Đề xuất việc làm phù hợp:</strong><br><br>");
            
            while (rs.next()) {
                String title = rs.getString("title");
                String company = rs.getString("company_name");
                String location = rs.getString("location");
                Double salaryMin = rs.getDouble("salary_min");
                Double salaryMax = rs.getDouble("salary_max");
                
                String salaryText = "Thương lượng";
                if (salaryMin != null && salaryMax != null) {
                    salaryText = String.format("%.0f - %.0f triệu VNĐ", salaryMin, salaryMax);
                }
                
                suggestions.append(String.format(
                    "• <strong>%s</strong> tại %s<br>" +
                    "  📍 %s | 💰 %s<br><br>",
                    title, company, location, salaryText
                ));
            }
            
            if (suggestions.toString().contains("💡")) {
                suggestions.append("💼 <em>Khám phá thêm việc làm trên TechSign!</em>");
            } else {
                suggestions.append("💼 <em>Hiện tại chưa có việc làm phù hợp. Hãy thử lại sau!</em>");
            }
            
            rs.close();
            ps.close();
            conn.close();
            
            return suggestions.toString();
            
        } catch (Exception e) {
            return "💼 <em>Có thể tìm thêm việc làm trên TechSign!</em>";
        }
    }

    // Hàm lấy thống kê hệ thống từ database
    private String getSystemStatsFromDB(HttpServletRequest request) {
        try {
            Connection conn = DBContext.getConnection();
            StringBuilder stats = new StringBuilder();
            
            // Thống kê users theo role
            String userStatsSql = "SELECT role_name, COUNT(*) as count FROM users GROUP BY role_name";
            PreparedStatement userPs = conn.prepareStatement(userStatsSql);
            ResultSet userRs = userPs.executeQuery();
            
            stats.append("📊 <strong>Thống kê người dùng:</strong><br>");
            int totalUsers = 0;
            while (userRs.next()) {
                String roleName = userRs.getString("role_name");
                int count = userRs.getInt("count");
                totalUsers += count;
                stats.append(String.format("• %s: %d tài khoản<br>", roleName, count));
            }
            stats.append(String.format("<strong>Tổng cộng: %d tài khoản</strong><br><br>", totalUsers));
            
            userRs.close();
            userPs.close();
            
            // Thống kê job postings
            String jobStatsSql = "SELECT COUNT(*) as total_jobs, " +
                               "SUM(CASE WHEN status = 'open' THEN 1 ELSE 0 END) as open_jobs, " +
                               "SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) as closed_jobs " +
                               "FROM job_postings";
            PreparedStatement jobPs = conn.prepareStatement(jobStatsSql);
            ResultSet jobRs = jobPs.executeQuery();
            
            if (jobRs.next()) {
                int totalJobs = jobRs.getInt("total_jobs");
                int openJobs = jobRs.getInt("open_jobs");
                int closedJobs = jobRs.getInt("closed_jobs");
                
                stats.append("💼 <strong>Thống kê việc làm:</strong><br>");
                stats.append(String.format("• Tổng việc làm: %d<br>", totalJobs));
                stats.append(String.format("• Đang tuyển: %d<br>", openJobs));
                stats.append(String.format("• Đã đóng: %d<br><br>", closedJobs));
            }
            
            jobRs.close();
            jobPs.close();
            
            // Thống kê company profiles
            String companyStatsSql = "SELECT COUNT(*) as total_companies FROM company_profiles";
            PreparedStatement companyPs = conn.prepareStatement(companyStatsSql);
            ResultSet companyRs = companyPs.executeQuery();
            
            if (companyRs.next()) {
                int totalCompanies = companyRs.getInt("total_companies");
                stats.append("🏢 <strong>Thống kê công ty:</strong><br>");
                stats.append(String.format("• Tổng công ty: %d<br><br>", totalCompanies));
            }
            
            companyRs.close();
            companyPs.close();
            
            // Thống kê messages (chat)
            String messageStatsSql = "SELECT COUNT(*) as total_messages FROM messages";
            PreparedStatement messagePs = conn.prepareStatement(messageStatsSql);
            ResultSet messageRs = messagePs.executeQuery();
            
            if (messageRs.next()) {
                int totalMessages = messageRs.getInt("total_messages");
                stats.append("💬 <strong>Thống kê tin nhắn:</strong><br>");
                stats.append(String.format("• Tổng tin nhắn: %d<br>", totalMessages));
            }
            
            messageRs.close();
            messagePs.close();
            conn.close();
            
            return stats.toString();
            
        } catch (Exception e) {
            return "❌ Không thể truy vấn thống kê hệ thống. Vui lòng thử lại sau!";
        }
    }

    // Hàm xử lý database query linh hoạt
    private String processDatabaseQuery(String userMessage, HttpServletRequest request) {
        try {
            Connection conn = DBContext.getConnection();
            StringBuilder result = new StringBuilder();
            String message = userMessage.toLowerCase();
            
            // Xử lý các loại query khác nhau
            if (message.contains("admin") || message.contains("quản trị")) {
                result.append(getAdminUsers(conn));
            } else if (message.contains("company") || message.contains("công ty")) {
                result.append(getCompanyList(conn));
            } else if (message.contains("candidate") || message.contains("ứng viên")) {
                result.append(getCandidateList(conn));
            } else if (message.contains("job") || message.contains("việc làm")) {
                result.append(getJobList(conn));
            } else if (message.contains("message") || message.contains("tin nhắn")) {
                result.append(getMessageList(conn));
            } else if (message.contains("recent") || message.contains("gần đây") || message.contains("mới")) {
                result.append(getRecentData(conn));
            } else if (message.contains("top") || message.contains("nhiều nhất")) {
                result.append(getTopData(conn));
            } else {
                // Query tổng quát
                result.append(getGeneralData(conn));
            }
            
            conn.close();
            return result.toString();
            
        } catch (Exception e) {
            return "❌ Không thể truy vấn database. Vui lòng thử lại sau!";
        }
    }
    
    // Lấy danh sách admin users
    private String getAdminUsers(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT TOP 10 id, full_name, email, created_at FROM users WHERE role_name = 'Admin' ORDER BY created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        sb.append("👨‍💼 <strong>Danh sách Admin:</strong><br>");
        while (rs.next()) {
            String name = rs.getString("full_name");
            String email = rs.getString("email");
            Timestamp createdAt = rs.getTimestamp("created_at");
            sb.append(String.format("• %s (%s) - Tạo: %s<br>", name, email, createdAt));
        }
        
        rs.close();
        ps.close();
        return sb.toString();
    }
    
    // Lấy danh sách công ty
    private String getCompanyList(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT TOP 10 id, company_name, industry, location FROM company_profiles ORDER BY id DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        sb.append("🏢 <strong>Danh sách Công ty:</strong><br>");
        while (rs.next()) {
            String name = rs.getString("company_name");
            String industry = rs.getString("industry");
            String location = rs.getString("location");
            sb.append(String.format("• %s - %s tại %s<br>", name, industry, location));
        }
        
        rs.close();
        ps.close();
        return sb.toString();
    }
    
    // Lấy danh sách ứng viên
    private String getCandidateList(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT TOP 10 id, full_name, email, phone FROM users WHERE role_name = 'Candidate' ORDER BY created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        sb.append("👤 <strong>Danh sách Ứng viên:</strong><br>");
        while (rs.next()) {
            String name = rs.getString("full_name");
            String email = rs.getString("email");
            String phone = rs.getString("phone");
            sb.append(String.format("• %s (%s) - %s<br>", name, email, phone));
        }
        
        rs.close();
        ps.close();
        return sb.toString();
    }
    
    // Lấy danh sách việc làm
    private String getJobList(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT TOP 10 jp.title, cp.company_name, jp.location, jp.salary_min, jp.status " +
                    "FROM job_postings jp " +
                    "INNER JOIN company_profiles cp ON jp.company_profile_id = cp.id " +
                    "ORDER BY jp.posted_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        sb.append("💼 <strong>Danh sách Việc làm:</strong><br>");
        while (rs.next()) {
            String title = rs.getString("title");
            String company = rs.getString("company_name");
            String location = rs.getString("location");
            Double salary = rs.getDouble("salary_min");
            String status = rs.getString("status");
            sb.append(String.format("• %s tại %s (%s) - %s triệu<br>", title, company, location, salary));
        }
        
        rs.close();
        ps.close();
        return sb.toString();
    }
    
    // Lấy danh sách tin nhắn
    private String getMessageList(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        String sql = "SELECT TOP 10 m.content, u.full_name, m.created_at " +
                    "FROM messages m " +
                    "INNER JOIN users u ON m.sender_id = u.id " +
                    "ORDER BY m.created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        sb.append("💬 <strong>Tin nhắn gần đây:</strong><br>");
        while (rs.next()) {
            String content = rs.getString("content");
            String sender = rs.getString("full_name");
            Timestamp createdAt = rs.getTimestamp("created_at");
            String shortContent = content.length() > 50 ? content.substring(0, 50) + "..." : content;
            sb.append(String.format("• %s: %s<br>", sender, shortContent));
        }
        
        rs.close();
        ps.close();
        return sb.toString();
    }
    
    // Lấy dữ liệu gần đây
    private String getRecentData(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        
        // Users mới
        String userSql = "SELECT COUNT(*) as new_users FROM users WHERE created_at >= DATEADD(day, -7, GETDATE())";
        PreparedStatement userPs = conn.prepareStatement(userSql);
        ResultSet userRs = userPs.executeQuery();
        if (userRs.next()) {
            int newUsers = userRs.getInt("new_users");
            sb.append(String.format("👥 <strong>Tuần này:</strong> %d người dùng mới<br>", newUsers));
        }
        userRs.close();
        userPs.close();
        
        // Jobs mới
        String jobSql = "SELECT COUNT(*) as new_jobs FROM job_postings WHERE posted_at >= DATEADD(day, -7, GETDATE())";
        PreparedStatement jobPs = conn.prepareStatement(jobSql);
        ResultSet jobRs = jobPs.executeQuery();
        if (jobRs.next()) {
            int newJobs = jobRs.getInt("new_jobs");
            sb.append(String.format("💼 <strong>Tuần này:</strong> %d việc làm mới<br>", newJobs));
        }
        jobRs.close();
        jobPs.close();
        
        return sb.toString();
    }
    
    // Lấy dữ liệu top
    private String getTopData(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        
        // Top companies
        String companySql = "SELECT TOP 5 cp.company_name, COUNT(jp.id) as job_count " +
                           "FROM company_profiles cp " +
                           "LEFT JOIN job_postings jp ON cp.id = jp.company_profile_id " +
                           "GROUP BY cp.company_name " +
                           "ORDER BY job_count DESC";
        PreparedStatement companyPs = conn.prepareStatement(companySql);
        ResultSet companyRs = companyPs.executeQuery();
        
        sb.append("🏆 <strong>Top Công ty đăng việc:</strong><br>");
        while (companyRs.next()) {
            String company = companyRs.getString("company_name");
            int jobCount = companyRs.getInt("job_count");
            sb.append(String.format("• %s: %d việc làm<br>", company, jobCount));
        }
        
        companyRs.close();
        companyPs.close();
        return sb.toString();
    }
    
    // Lấy dữ liệu tổng quát
    private String getGeneralData(Connection conn) throws SQLException {
        StringBuilder sb = new StringBuilder();
        
        // Tổng quan hệ thống
        String[] queries = {
            "SELECT COUNT(*) as total FROM users",
            "SELECT COUNT(*) as total FROM job_postings WHERE status = 'open'",
            "SELECT COUNT(*) as total FROM company_profiles",
            "SELECT COUNT(*) as total FROM messages"
        };
        
        String[] labels = {"👥 Tổng users", "💼 Việc làm đang tuyển", "🏢 Tổng công ty", "💬 Tổng tin nhắn"};
        
        for (int i = 0; i < queries.length; i++) {
            PreparedStatement ps = conn.prepareStatement(queries[i]);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("total");
                sb.append(String.format("%s: %d<br>", labels[i], count));
            }
            rs.close();
            ps.close();
        }
        
        return sb.toString();
    }

    // Hàm gọi API Gemini tạo câu trả lời AI
    private String generateAIResponse(String message) throws IOException {
        Gson gson = new Gson();
        
        JsonObject contentPart = new JsonObject();
        contentPart.addProperty("text", message);

        JsonArray partsArray = new JsonArray();
        partsArray.add(contentPart);

        JsonObject content = new JsonObject();
        content.add("parts", partsArray);

        JsonArray contentsArray = new JsonArray();
        contentsArray.add(content);

        JsonObject generationConfig = new JsonObject();
        generationConfig.addProperty("maxOutputTokens", 512);

        JsonObject requestBodyJson = new JsonObject();
        requestBodyJson.add("contents", contentsArray);
        requestBodyJson.add("generationConfig", generationConfig);

        String requestBody = gson.toJson(requestBodyJson);

        HttpURLConnection conn = null;
        try {
            URL url = new URL(API_URL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(15000);
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.getBytes(StandardCharsets.UTF_8));
            }

            int status = conn.getResponseCode();
            InputStream is = (status >= 200 && status < 300) ? conn.getInputStream() : conn.getErrorStream();

            String responseText;
            try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                responseText = br.lines().collect(Collectors.joining());
            }

            if (status != 200) {
                return "⚠️ Có lỗi kỹ thuật. Vui lòng thử lại sau!";
            }

            JsonObject jsonResponse = gson.fromJson(responseText, JsonObject.class);
            JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
            if (candidates == null || candidates.size() == 0) {
                return "❌ Không thể xử lý yêu cầu. Vui lòng thử lại!";
            }

            JsonObject firstCandidate = candidates.get(0).getAsJsonObject();
            if (firstCandidate == null) {
                return "❌ Lỗi xử lý. Vui lòng thử lại!";
            }

            JsonObject contentObj = firstCandidate.getAsJsonObject("content");
            if (contentObj == null) {
                return "❌ Không nhận được phản hồi. Vui lòng thử lại!";
            }

            JsonArray parts = contentObj.getAsJsonArray("parts");
            if (parts == null || parts.size() == 0) {
                return "❌ Lỗi xử lý. Vui lòng thử lại!";
            }

            JsonObject firstPart = parts.get(0).getAsJsonObject();
            if (firstPart == null) {
                return "❌ Không thể xử lý yêu cầu. Vui lòng thử lại!";
            }

            String textResponse = firstPart.get("text").getAsString();
            if (textResponse.isEmpty()) {
                return "❌ Không nhận được phản hồi. Vui lòng thử lại!";
            }

            return textResponse;

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
} 