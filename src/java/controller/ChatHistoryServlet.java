package controller;

import dao.MessageDao;
import model.Message;
import model.User;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChatHistoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        
        try (Connection conn = dao.DBContext.getConnection()) {
            // Lấy current user từ session
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("[]");
                return;
            }
            
            User currentUser = (User) session.getAttribute("user");
            int currentUserId = currentUser.getId();
            
            // Lấy receiver_id từ parameter
            String receiverIdStr = request.getParameter("receiver_id");
            if (receiverIdStr == null || receiverIdStr.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("[]");
                return;
            }
            
            int receiverId = Integer.parseInt(receiverIdStr);
            
            // Lấy chat history
            MessageDao messageDao = new MessageDao(conn);
            List<Message> messages = messageDao.getChatHistory(currentUserId, receiverId);
            
            System.out.println("[ChatHistoryServlet] Current user ID: " + currentUserId);
            System.out.println("[ChatHistoryServlet] Receiver ID: " + receiverId);
            System.out.println("[ChatHistoryServlet] Messages found: " + (messages != null ? messages.size() : "null"));
            
            // Đánh dấu tin nhắn đã đọc
            messageDao.markAllAsRead(currentUserId, receiverId);
            
            // Convert sang JSON format cho frontend
            System.out.println("[ChatHistoryServlet] Converting " + messages.size() + " messages to JSON");
            
            // Tạo JSON thủ công thay vì dùng Gson với anonymous objects
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");
            
            for (int i = 0; i < messages.size(); i++) {
                Message m = messages.get(i);
                System.out.println("[ChatHistoryServlet] Processing message: id=" + m.getId() + ", content=" + m.getContent());
                
                if (i > 0) jsonBuilder.append(",");
                jsonBuilder.append("{");
                jsonBuilder.append("\"id\":").append(m.getId()).append(",");
                jsonBuilder.append("\"senderId\":").append(m.getSenderId()).append(",");
                jsonBuilder.append("\"receiverId\":").append(m.getReceiverId()).append(",");
                jsonBuilder.append("\"content\":\"").append(m.getContent() != null ? m.getContent().replace("\"", "\\\"") : "").append("\",");
                jsonBuilder.append("\"messageType\":\"").append(m.getMessageType() != null ? m.getMessageType() : "text").append("\",");
                jsonBuilder.append("\"fileUrl\":\"").append(m.getFileUrl() != null ? m.getFileUrl() : "").append("\",");
                jsonBuilder.append("\"sentAt\":\"").append(m.getSentAt() != null ? m.getSentAt().toString() : "").append("\",");
                jsonBuilder.append("\"isRead\":").append(m.isRead()).append(",");
                jsonBuilder.append("\"isSelf\":").append(m.getSenderId() == currentUserId);
                jsonBuilder.append("}");
            }
            
            jsonBuilder.append("]");
            String jsonResult = jsonBuilder.toString();
            System.out.println("[ChatHistoryServlet] JSON result: " + jsonResult);
            response.getWriter().write(jsonResult);
            
        } catch (Exception e) {
            System.err.println("[ChatHistoryServlet] Error: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("[]");
        }
    }
} 