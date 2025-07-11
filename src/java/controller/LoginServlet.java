/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.sql.Connection;
import dal.DBContext;
import dal.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import model.User;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Admin
 */
@WebServlet(name="LoginServlet", urlPatterns={"/LoginServlet"})
public class LoginServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    HttpSession session = request.getSession();

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        conn = new DBContext().getConnection();
        String sql = "SELECT password_hash, role_id FROM users WHERE email = ?";
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("password_hash");
                int roleId = rs.getInt("role_id");

                // Get user object from UserDao
                User user = new UserDao(conn).login(email, password);
                if (user != null) {
                    // User is authenticated, store in session
                    session.setAttribute("user", user);

                    // Chuyển hướng theo vai trò
                    switch (roleId) {
                        case 1:
                            response.sendRedirect(request.getContextPath() + "/adminHome.jsp");
                            break;
                        case 2:
                            response.sendRedirect(request.getContextPath() + "/candidateHome.jsp");
                            break;
                        case 3:
                            response.sendRedirect(request.getContextPath() + "/companyHome.jsp");
                            break;   
                        default:
                            response.sendRedirect(request.getContextPath() + "/index.jsp?error=invalid_role");
                    }
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp?error=invalid_credentials");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp?error=invalid_credentials");
            }
        } catch (SQLException e) {
            System.err.println("Error in login: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=database_error");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                // Don't close connection here as it's managed by the connection pool
            } catch (SQLException e) {
                System.err.println("Error closing resources: " + e.getMessage());
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Lỗi kết nối cơ sở dữ liệu.");
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}