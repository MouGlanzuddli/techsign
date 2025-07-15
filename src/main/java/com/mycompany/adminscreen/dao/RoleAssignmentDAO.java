package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.RoleAssignmentRequest;
import com.mycompany.adminscreen.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleAssignmentDAO {
    
    public boolean createRoleAssignmentRequest(RoleAssignmentRequest request) throws SQLException {
        String sql = "INSERT INTO role_assignment_requests (user_id, requested_role_id, requested_by_admin_id, " +
                    "status, token, expires_at, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, request.getUserId());
            stmt.setInt(2, request.getRequestedRoleId());
            stmt.setInt(3, request.getRequestedByAdminId());
            stmt.setString(4, request.getStatus());
            stmt.setString(5, request.getToken());
            stmt.setTimestamp(6, request.getExpiresAt());
            stmt.setTimestamp(7, request.getCreatedAt());
            stmt.setTimestamp(8, request.getUpdatedAt());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public RoleAssignmentRequest getByToken(String token) throws SQLException {
        String sql = "SELECT rar.*, u.email as user_email, u.full_name as user_full_name, " +
                    "a.full_name as admin_name FROM role_assignment_requests rar " +
                    "LEFT JOIN users u ON rar.user_id = u.id " +
                    "LEFT JOIN users a ON rar.requested_by_admin_id = a.id " +
                    "WHERE rar.token = ? AND rar.expires_at > NOW()";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToRequest(rs);
            }
        }
        return null;
    }
    
    public boolean updateRequestStatus(int requestId, String status) throws SQLException {
        String sql = "UPDATE role_assignment_requests SET status = ?, updated_at = ? WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            stmt.setInt(3, requestId);
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public List<RoleAssignmentRequest> getPendingRequests() throws SQLException {
        String sql = "SELECT rar.*, u.email as user_email, u.full_name as user_full_name, " +
                    "a.full_name as admin_name FROM role_assignment_requests rar " +
                    "LEFT JOIN users u ON rar.user_id = u.id " +
                    "LEFT JOIN users a ON rar.requested_by_admin_id = a.id " +
                    "WHERE rar.status = 'pending' ORDER BY rar.created_at DESC";
        
        List<RoleAssignmentRequest> requests = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                requests.add(mapResultSetToRequest(rs));
            }
        }
        return requests;
    }
    
    public List<RoleAssignmentRequest> getRequestsByUserId(int userId) throws SQLException {
        String sql = "SELECT rar.*, u.email as user_email, u.full_name as user_full_name, " +
                    "a.full_name as admin_name FROM role_assignment_requests rar " +
                    "LEFT JOIN users u ON rar.user_id = u.id " +
                    "LEFT JOIN users a ON rar.requested_by_admin_id = a.id " +
                    "WHERE rar.user_id = ? ORDER BY rar.created_at DESC";
        
        List<RoleAssignmentRequest> requests = new ArrayList<>();
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                requests.add(mapResultSetToRequest(rs));
            }
        }
        return requests;
    }
    
    public boolean deleteExpiredRequests() throws SQLException {
        String sql = "DELETE FROM role_assignment_requests WHERE expires_at < NOW()";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    private RoleAssignmentRequest mapResultSetToRequest(ResultSet rs) throws SQLException {
        RoleAssignmentRequest request = new RoleAssignmentRequest();
        request.setId(rs.getInt("id"));
        request.setUserId(rs.getInt("user_id"));
        request.setRequestedRoleId(rs.getInt("requested_role_id"));
        request.setRequestedByAdminId(rs.getInt("requested_by_admin_id"));
        request.setStatus(rs.getString("status"));
        request.setToken(rs.getString("token"));
        request.setExpiresAt(rs.getTimestamp("expires_at"));
        request.setCreatedAt(rs.getTimestamp("created_at"));
        request.setUpdatedAt(rs.getTimestamp("updated_at"));
        
        // Additional fields
        request.setUserEmail(rs.getString("user_email"));
        request.setUserFullName(rs.getString("user_full_name"));
        request.setAdminName(rs.getString("admin_name"));
        
        return request;
    }
} 