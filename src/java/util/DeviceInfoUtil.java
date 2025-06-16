package util;

import jakarta.servlet.http.HttpServletRequest;

public class DeviceInfoUtil {
    
    public static String getDeviceInfo(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent == null) {
            return "Unknown Device";
        }
        
        StringBuilder deviceInfo = new StringBuilder();
        
        // Detect OS
        if (userAgent.contains("Windows")) {
            deviceInfo.append("Windows");
        } else if (userAgent.contains("Mac")) {
            deviceInfo.append("macOS");
        } else if (userAgent.contains("Linux")) {
            deviceInfo.append("Linux");
        } else if (userAgent.contains("Android")) {
            deviceInfo.append("Android");
        } else if (userAgent.contains("iPhone") || userAgent.contains("iPad")) {
            deviceInfo.append("iOS");
        } else {
            deviceInfo.append("Unknown OS");
        }
        
        deviceInfo.append(" - ");
        
        // Detect Browser
        if (userAgent.contains("Chrome") && !userAgent.contains("Edg")) {
            deviceInfo.append("Chrome");
        } else if (userAgent.contains("Firefox")) {
            deviceInfo.append("Firefox");
        } else if (userAgent.contains("Safari") && !userAgent.contains("Chrome")) {
            deviceInfo.append("Safari");
        } else if (userAgent.contains("Edg")) {
            deviceInfo.append("Edge");
        } else {
            deviceInfo.append("Unknown Browser");
        }
        
        return deviceInfo.toString();
    }
    
    public static String getClientIpAddress(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        
        String xRealIp = request.getHeader("X-Real-IP");
        if (xRealIp != null && !xRealIp.isEmpty()) {
            return xRealIp;
        }
        
        return request.getRemoteAddr();
    }
}
