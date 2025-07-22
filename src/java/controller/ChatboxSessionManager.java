package controller;

import jakarta.websocket.Session;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ChatboxSessionManager {
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    public static void add(Session session) {
        sessions.add(session);
    }

    public static void remove(Session session) {
        sessions.remove(session);
    }

    public static void broadcast(String message) {
        synchronized (sessions) {
            for (Session session : sessions) {
                if (session.isOpen()) {
                    try {
                        session.getBasicRemote().sendText(message);
                    } catch (Exception e) {
                        // log error
                    }
                }
            }
        }
    }
} 