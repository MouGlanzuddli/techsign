package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.stream.Collectors;

public class ChatBotServlet extends HttpServlet {
    private static final String API_KEY = "AIzaSyAl0qgyIdPRk-69Avt5iYps3Gm1YZdFY-A";
    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + API_KEY;

    // Database connection info - thay cho phù hợp
    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=ShoesStore;encrypt=false";
    private static final String DB_USER = "sa";
    private static final String DB_PASS = "123";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String userMessage = request.getParameter("message");
            if (userMessage == null || userMessage.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.write(new JSONObject().put("reply", "Bạn vui lòng nhập câu hỏi!").toString());
                return;
            }

            // Bước 1: Lấy keyword đơn giản
            String keyword = extractKeyword(userMessage);

            // Bước 2: Lấy dữ liệu từ database kèm trả về đoạn HTML thân thiện có ảnh
            String productInfo = getProductInfoFromDB(keyword, request);

            // Nếu tìm được sản phẩm (không phải thông báo không có hoặc hỏi rõ hơn)
            if (!productInfo.contains("Rất tiếc") && !productInfo.contains("nói rõ hơn")) {
                // Trả về luôn, không gọi AI nữa
                out.write(new JSONObject().put("reply", productInfo).toString());
                return;
            }

            // Nếu không tìm thấy sản phẩm hoặc keyword rỗng, gọi AI trả lời chung
            String prompt = buildPrompt(userMessage, productInfo);
            String aiReply = generateAIResponse(prompt);

            out.write(new JSONObject().put("reply", aiReply).toString());

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write(new JSONObject().put("reply", "Lỗi server: " + e.getMessage()).toString());
        } finally {
            out.close();
        }
    }
    
    
    private String cleanText(String text) {
    return text.toLowerCase().replaceAll("[^a-z0-9\\s]", "");
}


    // Hàm trích keyword đơn giản từ câu hỏi
    private String extractKeyword(String message) {
    message = message.toLowerCase();
    if (message.contains("nike")) return "nike";
    if (message.contains("adidas")) return "adidas";
    if (message.contains("fila")) return "fila";      // Thêm dòng này
    if (message.contains("puma")) return "puma";      // Thêm dòng này
    if (message.contains("giày")) return "giày";
    if (message.contains("áo")) return "áo";
    return "";
}


    // Hàm lấy thông tin sản phẩm từ database theo keyword và tạo chuỗi trả lời HTML thân thiện
    private String getProductInfoFromDB(String keyword, HttpServletRequest request) throws SQLException {
        if (keyword.isEmpty()) {
            return "Bạn vui lòng nói rõ hơn về sản phẩm bạn quan tâm nhé.";
        }

        StringBuilder sb = new StringBuilder();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT TOP 3 ProductName, Price, Description, Image FROM Products WHERE ProductName LIKE ? OR Description LIKE ?";
            ps = conn.prepareStatement(sql);
            String likeKeyword = "%" + keyword + "%";
            ps.setString(1, likeKeyword);
            ps.setString(2, likeKeyword);
            rs = ps.executeQuery();

            boolean hasData = false;
            String contextPath = request.getContextPath();

            sb.append("Dưới đây là sản phẩm mình tìm được cho bạn nhé:<br><br>");

            while (rs.next()) {
                hasData = true;
                String name = rs.getString("ProductName");
                double price = rs.getDouble("Price");
                String desc = rs.getString("Description");
                String image = rs.getString("Image");

                String imageTag = "";
                if (image != null && !image.trim().isEmpty()) {
                    String imageUrl = contextPath + "/images/" + image;
                    imageTag = String.format("<br><img src='%s' alt='%s' style='max-width:300px; border-radius:12px; box-shadow:0 2px 6px rgba(0,0,0,0.1); margin-top:8px;'>", imageUrl, name);
                }

                sb.append(String.format(
                    "- <b>%s</b>, giá %.0f VNĐ.<br> Mô tả: %s%s<br><br>",
                    name, price, desc, imageTag));
            }

            if (!hasData) {
                return "Rất tiếc, hiện shop chưa có sản phẩm phù hợp với yêu cầu của bạn.";
            }

            sb.append("Bạn có thể xem ảnh sản phẩm bên trên để có cái nhìn trực quan hơn nhé! Nếu bạn cần thêm thông tin hoặc mẫu khác, cứ hỏi mình nha!");

            return sb.toString();

        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (ps != null) try { ps.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }

    // Hàm tạo prompt cho AI
   private String buildPrompt(String userMessage, String productInfoText) {
    if (productInfoText.contains("Rất tiếc") || productInfoText.contains("nói rõ hơn") || productInfoText.isEmpty()) {
        return "Bạn là một trợ lý AI thân thiện, chuyên hỗ trợ mọi câu hỏi của khách hàng tại ShoesStore.\n" +
               "Khách hàng hỏi: \"" + userMessage + "\".\n" +
               "Hãy trả lời một cách thân thiện, rõ ràng, chuyên nghiệp.";
    } else {
        return "Bạn là trợ lý bán hàng của cửa hàng giày dép ShoesStore.\n" +
               "Khách hàng hỏi: \"" + userMessage + "\".\n" +
               "Dưới đây là thông tin sản phẩm liên quan:\n" + productInfoText +
               "\nHãy trả lời khách hàng một cách thân thiện, chi tiết, chuyên nghiệp, " +
               "đồng thời nhắc đến ảnh sản phẩm và khuyến khích khách hàng xem ảnh bên dưới.";
    }
}


    // Hàm gọi API Gemini tạo câu trả lời AI
    private String generateAIResponse(String message) throws IOException {
        JSONObject contentPart = new JSONObject();
        contentPart.put("text", message);

        JSONArray partsArray = new JSONArray();
        partsArray.put(contentPart);

        JSONObject content = new JSONObject();
        content.put("parts", partsArray);

        JSONArray contentsArray = new JSONArray();
        contentsArray.put(content);

        JSONObject generationConfig = new JSONObject();
        generationConfig.put("maxOutputTokens", 256);

        JSONObject requestBodyJson = new JSONObject();
        requestBodyJson.put("contents", contentsArray);
        requestBodyJson.put("generationConfig", generationConfig);

        String requestBody = requestBodyJson.toString();

        HttpURLConnection conn = null;
        try {
            URL url = new URL(API_URL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(10000);
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
                return "API Error (" + status + "): " + responseText;
            }

            JSONObject jsonResponse = new JSONObject(responseText);
            JSONArray candidates = jsonResponse.optJSONArray("candidates");
            if (candidates == null || candidates.length() == 0) {
                return "API Error: No candidates in response";
            }

            JSONObject firstCandidate = candidates.optJSONObject(0);
            if (firstCandidate == null) {
                return "API Error: Candidate data missing";
            }

            JSONObject contentObj = firstCandidate.optJSONObject("content");
            if (contentObj == null) {
                return "API Error: Content data missing";
            }

            JSONArray parts = contentObj.optJSONArray("parts");
            if (parts == null || parts.length() == 0) {
                return "API Error: Parts data missing";
            }

            JSONObject firstPart = parts.optJSONObject(0);
            if (firstPart == null) {
                return "API Error: Part data missing";
            }

            String textResponse = firstPart.optString("text", "");
            if (textResponse.isEmpty()) {
                return "API Error: Text response missing";
            }

            return textResponse;

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
    }
}
