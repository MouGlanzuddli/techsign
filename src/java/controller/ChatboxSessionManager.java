package controller;

import jakarta.websocket.Session;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ChatboxSessionManager {
    private static final Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    public static void add(Session session) {
        sessions.add(session);
        System.out.println("[ChatboxSessionManager] Added session: " + session.getId() + ", Total sessions: " + sessions.size());
    }

    public static void remove(Session session) {
        sessions.remove(session);
        System.out.println("[ChatboxSessionManager] Removed session: " + session.getId() + ", Total sessions: " + sessions.size());
    }

    public static void broadcast(String message) {
        System.out.println("[ChatboxSessionManager] Broadcasting message to " + sessions.size() + " sessions: " + message.substring(0, Math.min(100, message.length())) + "...");
        
        synchronized (sessions) {
            for (Session session : sessions) {
                if (session.isOpen()) {
                    try {
                        session.getBasicRemote().sendText(message);
                        System.out.println("[ChatboxSessionManager] Sent to session: " + session.getId());
                    } catch (Exception e) {
                        System.err.println("[ChatboxSessionManager] Error sending to session " + session.getId() + ": " + e.getMessage());
                    }
                } else {
                    System.out.println("[ChatboxSessionManager] Session " + session.getId() + " is closed, removing...");
                    sessions.remove(session);
                }
            }
        }
    }
} 