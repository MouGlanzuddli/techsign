package controller;

import dal.BookmarkDAO;
import dal.JobPostingDAO;
import dal.DBContext;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import model.User;
import java.util.List;
import model.Bookmarks;

public class ShortlistJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("signup.jsp");
            return;
        }

        int page = 1;
        int pageSize = 5; // mỗi trang 5 job lưu
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        try (Connection conn = new DBContext().getConnection()) {
            BookmarkDAO dao = new BookmarkDAO();
            JobPostingDAO DAO = new JobPostingDAO();
            List<Bookmarks> savedJobs = dao.searchSavedJobs(user.getId(), null, null, null, page, pageSize);
            int totalJobs = dao.getTotalSavedJobs(user.getId(), null, null, null);
            int totalPages = (int) Math.ceil((double) totalJobs / pageSize);
            
            List<String> des = DAO.getAllJobCategoriesDes();
            List<String> cities = DAO.getAllCities();
            
            request.setAttribute("savedJobs", savedJobs);
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("des", des);
            request.setAttribute("cities", cities);
            request.getRequestDispatcher("shortlistjob.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
                response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String location = request.getParameter("location"); // Sửa từ "location" thành "city"
        String description = request.getParameter("description");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int pageSize = 10;
        User user = (User) request.getSession().getAttribute("user");

        try (Connection conn = new DBContext().getConnection()) {
            BookmarkDAO dao = new BookmarkDAO();
            List<Bookmarks> savedJobs = dao.searchSavedJobs(user.getId(), keyword, description, location, page, pageSize);
            int totalJobs = dao.getTotalSavedJobs(user.getId(), keyword, description, location);
            request.setAttribute("savedJobs", savedJobs);
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("param", request.getParameterMap());

            request.getRequestDispatcher("shortlistjob.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

}
