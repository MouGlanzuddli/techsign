package controller;

import dao.UserDAO;
import dao.DBContext;
import util.TokenUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;

public class VerifyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String message;
        // You need to implement token verification logic in UserDAO or a separate DAO
        // For now, just show a placeholder message
        message = "Tính năng xác thực tài khoản chưa được triển khai.";
        req.setAttribute("message", message);
        req.getRequestDispatcher("/views/verify-result.jsp").forward(req, resp);
    }
} 