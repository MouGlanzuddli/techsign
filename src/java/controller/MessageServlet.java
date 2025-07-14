package controller;

import dal.DBContext;
import dal.ConversationDao;
import dal.MessageDao;
import dal.UserDao;
import model.Conversation;
import model.Message;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "MessageServlet", urlPatterns = {"/messages"})
public class MessageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp?error=access_denied");
            return;
        }

        try (Connection conn = new DBContext().getConnection()) {
            ConversationDao conversationDao = new ConversationDao(conn);
            MessageDao messageDao = new MessageDao(conn);
            UserDao userDao = new UserDao(conn);

            // Get all conversations for the current user
            List<Conversation> conversations = conversationDao.getConversationsByUserId(currentUser.getId());
            request.setAttribute("conversations", conversations);

            String conversationIdStr = request.getParameter("id");
            String recipientIdStr = request.getParameter("recipientId"); // For initiating new chat

            Conversation currentConversation = null;
            List<Message> messages = null;
            User recipientUser = null;

            if (conversationIdStr != null && !conversationIdStr.trim().isEmpty()) {
                int conversationId = Integer.parseInt(conversationIdStr);
                currentConversation = conversationDao.getConversationById(conversationId);

                // Verify current user is a participant in this conversation
                if (currentConversation != null && 
                    (currentConversation.getParticipant1Id() == currentUser.getId() || 
                     currentConversation.getParticipant2Id() == currentUser.getId())) {
                    
                    messages = messageDao.getMessagesByConversationId(conversationId);
                    messageDao.markMessagesAsRead(conversationId, currentUser.getId()); // Mark as read for current user

                    // Determine the recipient user
                    int otherParticipantId = (currentConversation.getParticipant1Id() == currentUser.getId()) ? 
                                             currentConversation.getParticipant2Id() : 
                                             currentConversation.getParticipant1Id();
                    recipientUser = userDao.getUserById(otherParticipantId);

                    request.setAttribute("currentConversation", currentConversation);
                    request.setAttribute("messages", messages);
                    request.setAttribute("recipientUser", recipientUser);
                } else {
                    request.setAttribute("error", "Conversation not found or you don't have access.");
                }
            } else if (recipientIdStr != null && !recipientIdStr.trim().isEmpty()) {
                // Attempt to initiate a new conversation or open existing one with a specific recipient
                int recipientId = Integer.parseInt(recipientIdStr);
                if (recipientId == currentUser.getId()) {
                    request.setAttribute("error", "Cannot start a conversation with yourself.");
                } else {
                    recipientUser = userDao.getUserById(recipientId);
                    if (recipientUser != null) {
                        currentConversation = conversationDao.getOrCreateConversation(currentUser.getId(), recipientId);
                        if (currentConversation != null) {
                            // Redirect to the conversation with its ID
                            response.sendRedirect(request.getContextPath() + "/messages?id=" + currentConversation.getId());
                            return; // Important to stop further processing
                        } else {
                            request.setAttribute("error", "Failed to create or retrieve conversation.");
                        }
                    } else {
                        request.setAttribute("error", "Recipient user not found.");
                    }
                }
            }

            request.getRequestDispatcher("/messages.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid conversation or recipient ID.");
            request.getRequestDispatcher("/messages.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/messages.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect("login.jsp?error=access_denied");
            return;
        }

        String conversationIdStr = request.getParameter("conversationId");
        String recipientIdStr = request.getParameter("recipientId"); // Used if conversationId is not yet known
        String messageContent = request.getParameter("messageContent");

        if (messageContent == null || messageContent.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/messages?id=" + conversationIdStr + "&error=empty_message");
            return;
        }

        try (Connection conn = new DBContext().getConnection()) {
            ConversationDao conversationDao = new ConversationDao(conn);
            MessageDao messageDao = new MessageDao(conn);

            int conversationId;
            if (conversationIdStr != null && !conversationIdStr.trim().isEmpty()) {
                conversationId = Integer.parseInt(conversationIdStr);
            } else if (recipientIdStr != null && !recipientIdStr.trim().isEmpty()) {
                // If no conversation ID, try to get or create one
                int recipientId = Integer.parseInt(recipientIdStr);
                Conversation conv = conversationDao.getOrCreateConversation(currentUser.getId(), recipientId);
                if (conv == null) {
                    response.sendRedirect(request.getContextPath() + "/messages?error=failed_to_create_conversation");
                    return;
                }
                conversationId = conv.getId();
            } else {
                response.sendRedirect(request.getContextPath() + "/messages?error=missing_conversation_or_recipient");
                return;
            }

            Message newMessage = new Message(conversationId, currentUser.getId(), messageContent);
            boolean messageAdded = messageDao.addMessage(newMessage);

            if (messageAdded) {
                conversationDao.updateLastMessage(conversationId, newMessage.getId());
                response.sendRedirect(request.getContextPath() + "/messages?id=" + conversationId);
            } else {
                response.sendRedirect(request.getContextPath() + "/messages?id=" + conversationId + "&error=failed_to_send");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/messages?error=invalid_id_format");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/messages?error=database_error");
        }
    }
}
