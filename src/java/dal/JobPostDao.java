/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;     // ✅ JDBC Connection
import java.sql.Statement;      // ✅ JDBC Statement
import java.sql.ResultSet;      // ✅ Để xử lý kết quả truy vấn
import java.sql.SQLException;   // ✅ Bắt lỗi khi thao tác DB

public class JobPostDao {
    private final Connection connection;

    public JobPostDao(Connection connection) {
        this.connection = connection;
    }

    public int getTotalJobPosts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM job_postings"; // table của bạn
        try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}

