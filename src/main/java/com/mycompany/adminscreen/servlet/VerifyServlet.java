package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/verify")
public class VerifyServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        String message;
        Optional<Integer> userIdOpt = userDAO.getUserIdByToken(token);
        if (userIdOpt.isPresent()) {
            userDAO.verifyUserById(userIdOpt.get(), token);
            message = "Xác nhận thành công! Tài khoản đã được kích hoạt.";
        } else {
            message = "Token không hợp lệ hoặc đã hết hạn.";
        }
        req.setAttribute("message", message);
        req.getRequestDispatcher("/views/verify-result.jsp").forward(req, resp);
    }
} 