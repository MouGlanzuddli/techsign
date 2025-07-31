package controller;

// import jakarta.websocket.Session;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

public class ChatboxSessionManager {
    private static final Set<Object> sessions = Collections.synchronizedSet(new HashSet<>());

    public static void add(Object session) {
        sessions.add(session);
    }

    public static void remove(Object session) {
        sessions.remove(session);
    }

    public static void broadcast(String message) {
        synchronized (sessions) {
            for (Object session : sessions) {
                try {
                    // session.getBasicRemote().sendText(message);
                } catch (Exception e) {
                    // log error
                }
            }
        }
    }
} 