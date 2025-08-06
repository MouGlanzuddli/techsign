package DAO;

import connectDB.DBContext;
import model.Skill;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobPostingSkillDAO {
   

    public List<Skill> getSkillsByJobId(int jobId) throws SQLException {
        List<Skill> list = new ArrayList<>();
        String sql = """
                     SELECT s.id, s.name
                     FROM skills s
                     JOIN job_required_skills jrs ON s.id = jrs.skill_id
                     WHERE jrs.job_posting_id = ?
                     """;
        Connection conn = new DBContext().getConnection();
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, jobId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Skill s = new Skill(rs.getInt("id"), rs.getString("name"));
            list.add(s);
        }
        rs.close();
        ps.close();
        return list;
    }
}
