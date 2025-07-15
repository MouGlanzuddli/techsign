/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.Connection;
import connectDB.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
/**
 *
 * @author Thien An
 */
public class CandidateProfileDAO {
    public static int getCandidateProfileIdByUserId(int userId) {
    int profileId = -1;
    String sql = "SELECT id FROM candidate_profiles WHERE user_id = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            profileId = rs.getInt("id");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return profileId;
}

}
