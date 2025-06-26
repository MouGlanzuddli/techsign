package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.CompanyProfile;
import com.mycompany.adminscreen.util.DBConnection;
import java.sql.*;
import java.util.*;

public class CompanyProfileDAO {

    public CompanyProfileDAO() {
        // Default constructor
    }

    public CompanyProfile getById(int id) throws SQLException {
        String sql = "SELECT * FROM company_profiles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<CompanyProfile> getAll() throws SQLException {
        String sql = "SELECT * FROM company_profiles";
        List<CompanyProfile> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); 
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }
    
    public List<CompanyProfile> getAllWithIndustry() throws SQLException {
        String sql = "SELECT cp.*, i.name as industry_name FROM company_profiles cp " +
                    "LEFT JOIN industries i ON cp.industry_id = i.id " +
                    "ORDER BY cp.company_name";
        List<CompanyProfile> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); 
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) list.add(mapRowWithIndustry(rs));
        }
        return list;
    }
    
    public List<CompanyProfile> getByIndustry(int industryId) throws SQLException {
        String sql = "SELECT cp.*, i.name as industry_name FROM company_profiles cp " +
                    "LEFT JOIN industries i ON cp.industry_id = i.id " +
                    "WHERE cp.industry_id = ? " +
                    "ORDER BY cp.company_name";
        List<CompanyProfile> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, industryId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRowWithIndustry(rs));
            }
        }
        return list;
    }

    private CompanyProfile mapRow(ResultSet rs) throws SQLException {
        CompanyProfile cp = new CompanyProfile();
        cp.setId(rs.getInt("id"));
        cp.setUserId(rs.getInt("user_id"));
        cp.setIndustryId(rs.getObject("industry_id") != null ? rs.getInt("industry_id") : null);
        cp.setCompanyName(rs.getString("company_name"));
        cp.setWebsite(rs.getString("website"));
        cp.setDescription(rs.getString("description"));
        cp.setAddress(rs.getString("address"));
        cp.setPhone(rs.getString("phone"));
        cp.setLogoUrl(rs.getString("logo_url"));
        cp.setBannerUrl(rs.getString("banner_url"));
        cp.setIconUrl(rs.getString("icon_url"));
        cp.setFeatured(rs.getBoolean("is_featured"));
        cp.setSearchable(rs.getBoolean("is_searchable"));
        cp.setCreatedAt(rs.getTimestamp("created_at"));
        cp.setUpdatedAt(rs.getTimestamp("updated_at"));
        return cp;
    }
    
    private CompanyProfile mapRowWithIndustry(ResultSet rs) throws SQLException {
        CompanyProfile cp = mapRow(rs);
        // Add industry name if available
        String industryName = rs.getString("industry_name");
        if (industryName != null) {
            // You might want to add an industryName field to CompanyProfile model
            // For now, we'll just use the existing structure
        }
        return cp;
    }
} 