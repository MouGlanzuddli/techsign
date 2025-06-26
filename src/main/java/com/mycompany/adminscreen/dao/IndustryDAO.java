package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.Industry;
import com.mycompany.adminscreen.util.DBConnection;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class IndustryDAO {
    
    public List<Industry> getAllIndustries() {
        List<Industry> industries = new ArrayList<>();
        String sql = "SELECT id, name, description, created_at, updated_at FROM industries ORDER BY name";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Industry industry = new Industry();
                industry.setId(rs.getInt("id"));
                industry.setName(rs.getString("name"));
                industry.setDescription(rs.getString("description"));
                
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    industry.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    industry.setUpdatedAt(updatedAt.toLocalDateTime());
                }
                
                industries.add(industry);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return industries;
    }
    
    public Industry getIndustryById(int id) {
        String sql = "SELECT id, name, description, created_at, updated_at FROM industries WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Industry industry = new Industry();
                industry.setId(rs.getInt("id"));
                industry.setName(rs.getString("name"));
                industry.setDescription(rs.getString("description"));
                
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    industry.setCreatedAt(createdAt.toLocalDateTime());
                }
                
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    industry.setUpdatedAt(updatedAt.toLocalDateTime());
                }
                
                return industry;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addIndustry(Industry industry) {
        String sql = "INSERT INTO industries (name, description, created_at, updated_at) VALUES (?, ?, GETDATE(), GETDATE())";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, industry.getName());
            stmt.setString(2, industry.getDescription());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateIndustry(Industry industry) {
        String sql = "UPDATE industries SET name = ?, description = ?, updated_at = GETDATE() WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, industry.getName());
            stmt.setString(2, industry.getDescription());
            stmt.setInt(3, industry.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean deleteIndustry(int id) {
        String sql = "DELETE FROM industries WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 