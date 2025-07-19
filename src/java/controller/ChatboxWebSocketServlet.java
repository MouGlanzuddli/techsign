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
        sessions.add(session);
    }

    @OnMessage
    public void onMessage(String message, Session senderSession) throws IOException {
        // Broadcast message to all connected clients except sender
        synchronized (sessions) {
            for (Session session : sessions) {
                if (session.isOpen() && !session.equals(senderSession)) {
                    session.getBasicRemote().sendText(message);
                }
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
    }
}