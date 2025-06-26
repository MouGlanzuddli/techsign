package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.IndustryDAO;
import com.mycompany.adminscreen.model.Industry;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/industry")
public class IndustryServlet extends HttpServlet {
    private IndustryDAO industryDAO;

    @Override
    public void init() throws ServletException {
        industryDAO = new IndustryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        StringBuilder jsonResponse = new StringBuilder();

        try {
            switch (action) {
                case "getAll":
                    List<Industry> allIndustries = industryDAO.getAllIndustries();
                    jsonResponse.append("{\"success\":true,\"data\":[");
                    for (int i = 0; i < allIndustries.size(); i++) {
                        Industry industry = allIndustries.get(i);
                        jsonResponse.append(buildIndustryJson(industry));
                        if (i < allIndustries.size() - 1) jsonResponse.append(",");
                    }
                    jsonResponse.append("]}");
                    break;

                case "getById":
                    String idParam = request.getParameter("id");
                    if (idParam != null && !idParam.trim().isEmpty()) {
                        int id = Integer.parseInt(idParam);
                        Industry industry = industryDAO.getIndustryById(id);
                        if (industry != null) {
                            jsonResponse.append("{\"success\":true,\"data\":").append(buildIndustryJson(industry)).append("}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Industry not found\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"ID parameter is required\"}");
                    }
                    break;

                default:
                    jsonResponse.append("{\"success\":false,\"message\":\"Invalid action\"}");
                    break;
            }
        } catch (Exception e) {
            jsonResponse.append("{\"success\":false,\"message\":\"Error: ").append(e.getMessage()).append("\"}");
            e.printStackTrace();
        }

        out.print(jsonResponse.toString());
        out.flush();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");
        StringBuilder jsonResponse = new StringBuilder();

        try {
            switch (action) {
                case "add":
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    
                    if (name != null && !name.trim().isEmpty()) {
                        Industry industry = new Industry();
                        industry.setName(name);
                        industry.setDescription(description);
                        
                        boolean success = industryDAO.addIndustry(industry);
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Industry added successfully\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to add industry\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Industry name is required\"}");
                    }
                    break;

                case "update":
                    String updateIdParam = request.getParameter("id");
                    String updateName = request.getParameter("name");
                    String updateDescription = request.getParameter("description");
                    
                    if (updateIdParam != null && updateName != null) {
                        int updateId = Integer.parseInt(updateIdParam);
                        Industry updateIndustry = new Industry();
                        updateIndustry.setId(updateId);
                        updateIndustry.setName(updateName);
                        updateIndustry.setDescription(updateDescription);
                        
                        boolean success = industryDAO.updateIndustry(updateIndustry);
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Industry updated successfully\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to update industry\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Industry ID and name are required\"}");
                    }
                    break;

                case "delete":
                    String deleteIdParam = request.getParameter("id");
                    if (deleteIdParam != null) {
                        int deleteId = Integer.parseInt(deleteIdParam);
                        boolean success = industryDAO.deleteIndustry(deleteId);
                        
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Industry deleted successfully\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to delete industry\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Industry ID is required\"}");
                    }
                    break;

                default:
                    jsonResponse.append("{\"success\":false,\"message\":\"Invalid action\"}");
                    break;
            }
        } catch (Exception e) {
            jsonResponse.append("{\"success\":false,\"message\":\"Error: ").append(e.getMessage()).append("\"}");
            e.printStackTrace();
        }

        out.print(jsonResponse.toString());
        out.flush();
    }
    
    private String buildIndustryJson(Industry industry) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(industry.getId()).append(",");
        json.append("\"name\":\"").append(escapeJson(industry.getName())).append("\",");
        json.append("\"description\":\"").append(escapeJson(industry.getDescription())).append("\",");
        json.append("\"createdAt\":\"").append(industry.getCreatedAt() != null ? industry.getCreatedAt().toString() : "").append("\",");
        json.append("\"updatedAt\":\"").append(industry.getUpdatedAt() != null ? industry.getUpdatedAt().toString() : "").append("\"");
        json.append("}");
        return json.toString();
    }
    
    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
} 