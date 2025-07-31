package controller;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

@ServerEndpoint("/chatbox")
public class ChatboxWebSocketServlet {
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        System.out.println("[WebSocket] New connection: " + session.getId());
        ChatboxSessionManager.add(session);
        sessions.add(session);
    }

    @OnMessage
    public void onMessage(String message, Session senderSession) throws IOException {
        System.out.println("[WebSocket] Received message from " + senderSession.getId() + ": " + message);
        
        // Broadcast message to all connected clients EXCEPT sender
        synchronized (sessions) {
            for (Session session : sessions) {
                if (session.isOpen() && !session.equals(senderSession)) {
                    try {
                        session.getBasicRemote().sendText(message);
                        System.out.println("[WebSocket] Sent to " + session.getId());
                    } catch (Exception e) {
                        System.err.println("[WebSocket] Error sending to " + session.getId() + ": " + e.getMessage());
                    }
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        System.out.println("[WebSocket] Connection closed: " + session.getId());
        ChatboxSessionManager.remove(session);
        sessions.remove(session);
    }
}