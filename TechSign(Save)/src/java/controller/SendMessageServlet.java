package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.Date;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dao.MessageDao;
import model.Message;
import model.User;

public class SendMessageServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try (Connection conn = dao.DBContext.getConnection()) {
            // Lấy current user từ session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"success\": false, \"message\": \"Unauthorized\"}");
                return;
            }
            
            User currentUser = (User) session.getAttribute("user");
            int senderId = currentUser.getId();
            
            // Lấy parameters
            String receiverIdStr = request.getParameter("receiver_id");
            String content = request.getParameter("content");
            String messageType = request.getParameter("message_type");
            String fileUrl = request.getParameter("file_url");
            
            if (receiverIdStr == null || content == null || messageType == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"Missing parameters\"}");
                return;
            }
            
            int receiverId = Integer.parseInt(receiverIdStr);
            
            // Tạo message mới
            Message message = new Message(senderId, receiverId, content, messageType, fileUrl);
            
            // Lưu vào database
            MessageDao messageDao = new MessageDao(conn);
            boolean success = messageDao.insertMessage(message);
            
            if (success) {
                // Trả về message đã lưu - JSON thủ công
                String jsonResult = "{" +
                    "\"success\":true," +
                    "\"id\":" + message.getId() + "," +
                    "\"senderId\":" + message.getSenderId() + "," +
                    "\"receiverId\":" + message.getReceiverId() + "," +
                    "\"content\":\"" + (message.getContent() != null ? message.getContent().replace("\"", "\\\"") : "") + "\"," +
                    "\"messageType\":\"" + (message.getMessageType() != null ? message.getMessageType() : "text") + "\"," +
                    "\"fileUrl\":\"" + (message.getFileUrl() != null ? message.getFileUrl() : "") + "\"," +
                    "\"sentAt\":\"" + (message.getSentAt() != null ? message.getSentAt().toString() : "") + "\"," +
                    "\"isRead\":" + message.isRead() +
                    "}";
                
                System.out.println("[SendMessageServlet] JSON result: " + jsonResult);
                // Broadcast qua WebSocket
                ChatboxSessionManager.broadcast(jsonResult);
                response.getWriter().write(jsonResult);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to save message\"}");
            }
            
        } catch (Exception e) {
            System.err.println("[SendMessageServlet] Error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server error\"}");
        }
    }
} 