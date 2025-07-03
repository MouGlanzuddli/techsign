<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    // Xóa session
    session.invalidate();
    
    // Redirect về trang index.jsp
    response.sendRedirect("index.jsp");
%>
