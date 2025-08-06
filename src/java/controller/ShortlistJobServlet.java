package controller;

import DAO.BookmarkDAO;


import connectDB.DBContext;

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

import model.JobPosting;

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

        try (Connection conn = new DBContext().getConnection()) {
            BookmarkDAO dao = new BookmarkDAO();
            // Load tất cả jobs đã lưu không cần filter, mặc định page 1, pageSize đủ lớn
            List<Bookmarks> savedJobs = dao.searchSavedJobs(user.getId(), null, null, null, 1, 100);
            int totalJobs = dao.getTotalSavedJobs(user.getId(), null, null, null);

            request.setAttribute("savedJobs", savedJobs);
            request.setAttribute("totalJobs", totalJobs);
            request.setAttribute("currentPage", 1);
            request.setAttribute("pageSize", 100);
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
