package controller;

// import jakarta.websocket.OnClose;
// import jakarta.websocket.OnMessage;
// import jakarta.websocket.OnOpen;
// import jakarta.websocket.Session;
import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
// import jakarta.websocket.server.ServerEndpoint;

// @ServerEndpoint("/chatbox")
public class ChatboxWebSocketServlet {
    private static final Set<Object> sessions = Collections.synchronizedSet(new HashSet<>());

    // @OnOpen
    public void onOpen(Object session) {
        System.out.println("[WebSocket] New connection: " + session.hashCode());
        ChatboxSessionManager.add(session);
        sessions.add(session);
    }

    // @OnMessage
    public void onMessage(String message, Object senderSession) throws IOException {
        System.out.println("[WebSocket] Received message from " + senderSession.hashCode() + ": " + message);
        
        // Broadcast message to all connected clients EXCEPT sender
        synchronized (sessions) {
            for (Object session : sessions) {
                if (!session.equals(senderSession)) {
                    try {
                        // session.getBasicRemote().sendText(message);
                        System.out.println("[WebSocket] Sent to " + session.hashCode());
                    } catch (Exception e) {
                        System.err.println("[WebSocket] Error sending to " + session.hashCode() + ": " + e.getMessage());
                    }
                }
            }
        }
    }

    // @OnClose
    public void onClose(Object session) {
        System.out.println("[WebSocket] Connection closed: " + session.hashCode());
        ChatboxSessionManager.remove(session);
        sessions.remove(session);
    }
}