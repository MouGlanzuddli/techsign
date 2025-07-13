package controller;

import dal.DBContext;
import dal.JobDao;
import dal.UserDao;
import model.Job;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "JobListServlet", urlPatterns = {"/JobListServlet", "/jobs"})
public class JobListServlet extends HttpServlet {

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    
    try {
        // Kết nối database
        DBContext dbContext = new DBContext();
        Connection conn = dbContext.getConnection();
        JobDao jobDao = new JobDao(conn);
        UserDao userDao = new UserDao(conn);
        
        // Lấy parameters cho search và filter
        String searchKeyword = request.getParameter("search");
        String categoryFilter = request.getParameter("category");
        String locationFilter = request.getParameter("location");
        String jobTypeFilter = request.getParameter("jobType");
        String jobLevelFilter = request.getParameter("jobLevel");
        String sortBy = request.getParameter("sortBy");
        
        // Lấy tất cả jobs active
        List<Job> allJobs = jobDao.getAllActiveJobs();
        
        // Lọc jobs theo các tiêu chí
        List<Job> filteredJobs = filterJobs(allJobs, searchKeyword, categoryFilter, 
                                          locationFilter, jobTypeFilter, jobLevelFilter);
        
        // Sắp xếp jobs
        sortJobs(filteredJobs, sortBy);
        
        // Lấy thông tin company cho mỗi job
        Map<Integer, User> companyMap = new HashMap<>();
        for (Job job : filteredJobs) {
            if (!companyMap.containsKey(job.getCompanyId())) {
                try {
                    User company = userDao.getUserById(job.getCompanyId());
                    if (company != null) {
                        companyMap.put(job.getCompanyId(), company);
                    }
                } catch (SQLException e) {
                    System.out.println("Error getting company info: " + e.getMessage());
                }
            }
        }
        
        // Lấy danh sách categories và locations để hiển thị filter
        List<String> categories = jobDao.getAllCategories();
        List<String> locations = jobDao.getAllLocations();
        
        // Set attributes
        request.setAttribute("jobs", filteredJobs);
        request.setAttribute("companies", companyMap);
        request.setAttribute("categories", categories);
        request.setAttribute("locations", locations);
        request.setAttribute("totalJobs", filteredJobs.size());
        
        // Giữ lại các filter parameters
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("categoryFilter", categoryFilter);
        request.setAttribute("locationFilter", locationFilter);
        request.setAttribute("jobTypeFilter", jobTypeFilter);
        request.setAttribute("jobLevelFilter", jobLevelFilter);
        request.setAttribute("sortBy", sortBy);
        
        // Forward đến JSP
        request.getRequestDispatcher("/job-list.jsp").forward(request, response);
        
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}

private List<Job> filterJobs(List<Job> jobs, String searchKeyword, String category, 
                           String location, String jobType, String jobLevel) {
    return jobs.stream()
        .filter(job -> {
            // Filter by search keyword
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                String keyword = searchKeyword.toLowerCase();
                return job.getTitle().toLowerCase().contains(keyword) ||
                       (job.getDescription() != null && job.getDescription().toLowerCase().contains(keyword)) ||
                       (job.getRequirements() != null && job.getRequirements().toLowerCase().contains(keyword));
            }
            return true;
        })
        .filter(job -> {
            // Filter by category
            if (category != null && !category.trim().isEmpty() && !"all".equals(category)) {
                return category.equals(job.getCategory());
            }
            return true;
        })
        .filter(job -> {
            // Filter by location
            if (location != null && !location.trim().isEmpty() && !"all".equals(location)) {
                return job.getLocation() != null && job.getLocation().toLowerCase().contains(location.toLowerCase());
            }
            return true;
        })
        .filter(job -> {
            // Filter by job type
            if (jobType != null && !jobType.trim().isEmpty() && !"all".equals(jobType)) {
                return jobType.equals(job.getJobType());
            }
            return true;
        })
        .filter(job -> {
            // Filter by job level
            if (jobLevel != null && !jobLevel.trim().isEmpty() && !"all".equals(jobLevel)) {
                return jobLevel.equals(job.getJobLevel());
            }
            return true;
        })
        .collect(java.util.stream.Collectors.toList());
}

private void sortJobs(List<Job> jobs, String sortBy) {
    if (sortBy == null || sortBy.isEmpty()) {
        sortBy = "newest";
    }
    
    switch (sortBy) {
        case "oldest":
            jobs.sort((a, b) -> a.getCreatedAt().compareTo(b.getCreatedAt()));
            break;
        case "title":
            jobs.sort((a, b) -> a.getTitle().compareToIgnoreCase(b.getTitle()));
            break;
        case "company":
            // Sắp xếp theo company sẽ cần thêm logic
            break;
        case "newest":
        default:
            jobs.sort((a, b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
            break;
    }
}
}
