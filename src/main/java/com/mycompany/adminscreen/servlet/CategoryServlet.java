package com.mycompany.adminscreen.servlet;

import com.mycompany.adminscreen.dao.CategoryDAO;
import com.mycompany.adminscreen.model.Category;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {
        categoryDAO = new CategoryDAO();
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
                    List<Category> allCategories = categoryDAO.getAllCategories();
                    jsonResponse.append("{\"success\":true,\"data\":[");
                    for (int i = 0; i < allCategories.size(); i++) {
                        Category category = allCategories.get(i);
                        jsonResponse.append(buildCategoryJson(category));
                        if (i < allCategories.size() - 1) jsonResponse.append(",");
                    }
                    jsonResponse.append("]}");
                    break;

                case "getById":
                    String idParam = request.getParameter("id");
                    if (idParam != null && !idParam.trim().isEmpty()) {
                        int id = Integer.parseInt(idParam);
                        Category category = categoryDAO.getCategoryById(id);
                        if (category != null) {
                            jsonResponse.append("{\"success\":true,\"data\":").append(buildCategoryJson(category)).append("}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Category not found\"}");
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
                    String iconUrl = request.getParameter("iconUrl");
                    
                    if (name != null && !name.trim().isEmpty()) {
                        Category category = new Category();
                        category.setName(name);
                        category.setDescription(description);
                        category.setIconUrl(iconUrl);
                        
                        boolean success = categoryDAO.addCategory(category);
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Category added successfully\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to add category\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Category name is required\"}");
                    }
                    break;

                case "update":
                    String updateIdParam = request.getParameter("id");
                    String updateName = request.getParameter("name");
                    String updateDescription = request.getParameter("description");
                    String updateIconUrl = request.getParameter("iconUrl");
                    
                    if (updateIdParam != null && updateName != null) {
                        int updateId = Integer.parseInt(updateIdParam);
                        Category updateCategory = new Category();
                        updateCategory.setId(updateId);
                        updateCategory.setName(updateName);
                        updateCategory.setDescription(updateDescription);
                        updateCategory.setIconUrl(updateIconUrl);
                        
                        boolean success = categoryDAO.updateCategory(updateCategory);
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Category updated successfully\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to update category\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Category ID and name are required\"}");
                    }
                    break;

                case "delete":
                    String deleteIdParam = request.getParameter("id");
                    if (deleteIdParam != null) {
                        int deleteId = Integer.parseInt(deleteIdParam);
                        boolean success = categoryDAO.deleteCategory(deleteId);
                        
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Category deleted successfully\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to delete category\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Category ID is required\"}");
                    }
                    break;

                case "reorder":
                    String orderParam = request.getParameter("order");
                    if (orderParam != null && !orderParam.trim().isEmpty()) {
                        String[] idStrings = orderParam.split(",");
                        int[] ids = new int[idStrings.length];
                        for (int i = 0; i < idStrings.length; i++) {
                            ids[i] = Integer.parseInt(idStrings[i]);
                        }
                        boolean success = categoryDAO.reorderCategories(ids);
                        if (success) {
                            jsonResponse.append("{\"success\":true,\"message\":\"Order updated\"}");
                        } else {
                            jsonResponse.append("{\"success\":false,\"message\":\"Failed to update order\"}");
                        }
                    } else {
                        jsonResponse.append("{\"success\":false,\"message\":\"Order parameter is required\"}");
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
    
    private String buildCategoryJson(Category category) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(category.getId()).append(",");
        json.append("\"name\":\"").append(escapeJson(category.getName())).append("\",");
        json.append("\"description\":\"").append(escapeJson(category.getDescription())).append("\",");
        json.append("\"iconUrl\":\"").append(escapeJson(category.getIconUrl())).append("\",");
        json.append("\"createdAt\":\"").append(category.getCreatedAt() != null ? category.getCreatedAt().toString() : "").append("\",");
        json.append("\"updatedAt\":\"").append(category.getUpdatedAt() != null ? category.getUpdatedAt().toString() : "").append("\"");
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