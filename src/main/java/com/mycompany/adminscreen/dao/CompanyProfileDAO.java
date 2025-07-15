package com.mycompany.adminscreen.dao;

import com.mycompany.adminscreen.model.CompanyProfile;
import com.mycompany.adminscreen.util.DBConnection;
import java.sql.*;
import java.util.*;

public class CompanyProfileDAO {

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
    
    public List<CompanyProfile> getAllCompanies() throws SQLException {
        List<CompanyProfile> list = new ArrayList<>();
        String sql = "SELECT id, company_name FROM company_profiles";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement(); ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                CompanyProfile cp = new CompanyProfile();
                cp.setId(rs.getInt("id"));
                String name = rs.getString("company_name");
                if (name == null) {
                    System.out.println("[DEBUG] company_name is null for id: " + cp.getId());
                    cp.setCompanyName("Không có tên");
                } else {
                    cp.setCompanyName(name);
                }
                list.add(cp);
            }
            System.out.println("[DEBUG] Số công ty lấy được: " + list.size());
        } catch (SQLException e) {
            System.err.println("[ERROR] SQL Exception in getAllCompanies: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    private CompanyProfile mapRow(ResultSet rs) throws SQLException {
        CompanyProfile cp = new CompanyProfile();
        cp.setId(rs.getInt("id"));
        cp.setUserId(rs.getInt("user_id"));
        String name = rs.getString("company_name");
        if (name == null) {
            System.out.println("[DEBUG] company_name is null for id: " + cp.getId());
            cp.setCompanyName("Không có tên");
        } else {
            cp.setCompanyName(name);
        }
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
} 