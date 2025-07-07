package util;

import jakarta.servlet.http.HttpServletRequest;

public class DeviceInfoUtil {
    
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
    
    public static String getDeviceInfo(HttpServletRequest request) {
        String userAgent = request.getHeader("User-Agent");
        if (userAgent == null || userAgent.isEmpty()) {
            return "Unknown Device";
        }
        
        // Phân tích User-Agent để lấy thông tin device
        StringBuilder deviceInfo = new StringBuilder();
        
        if (userAgent.contains("Mobile")) {
            deviceInfo.append("Mobile ");
        } else if (userAgent.contains("Tablet")) {
            deviceInfo.append("Tablet ");
        } else {
            deviceInfo.append("Desktop ");
        }
        
        if (userAgent.contains("Chrome")) {
            deviceInfo.append("Chrome");
        } else if (userAgent.contains("Firefox")) {
            deviceInfo.append("Firefox");
        } else if (userAgent.contains("Safari")) {
            deviceInfo.append("Safari");
        } else if (userAgent.contains("Edge")) {
            deviceInfo.append("Edge");
        } else {
            deviceInfo.append("Unknown Browser");
        }
        
        return deviceInfo.toString();
    }
}