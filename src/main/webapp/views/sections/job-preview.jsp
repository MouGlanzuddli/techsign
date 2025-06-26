<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mycompany.adminscreen.model.JobPosting" %>
<%@ page import="com.mycompany.adminscreen.model.CompanyProfile" %>
<%@ page import="java.util.List" %>
<%
    JobPosting job = (JobPosting) request.getAttribute("job");
    List<CompanyProfile> companies = (List<CompanyProfile>) request.getAttribute("companies");
    CompanyProfile company = null;
    if (job != null && companies != null) {
        for (CompanyProfile c : companies) {
            if (c.getId() == job.getCompanyProfileId()) {
                company = c;
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem trước Tin Tuyển dụng</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7f6; margin: 0; padding: 0; }
        .preview-container {
            max-width: 700px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
            padding: 32px 36px;
        }
        h2 { color: #0056b3; margin-bottom: 18px; }
        .detail-row { margin-bottom: 14px; }
        .label { font-weight: bold; color: #333; min-width: 120px; display: inline-block; }
        .value { color: #444; }
        .status-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 6px;
            font-size: 0.95em;
            font-weight: bold;
            text-transform: uppercase;
            margin-left: 8px;
        }
        .status-active { background: #d4edda; color: #155724; }
        .status-expired { background: #f8d7da; color: #721c24; }
        .status-draft { background: #cce5ff; color: #004085; }
        .status-pending { background: #fff3cd; color: #856404; }
        .status-closed { background: #e2e3e5; color: #383d41; }
        .desc-box {
            background: #f8fafc;
            border-radius: 8px;
            padding: 18px;
            margin-top: 18px;
            color: #444;
            font-size: 1.08em;
        }
        .back-btn {
            display: inline-block;
            margin-top: 28px;
            padding: 10px 22px;
            background: #2563eb;
            color: #fff;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.2s;
        }
        .back-btn:hover { background: #1d4ed8; }
    </style>
</head>
<body>
<div class="preview-container">
<% if (job != null) { %>
    <h2><%= job.getTitle() %></h2>
    <div class="detail-row"><span class="label">Công ty:</span> <span class="value"><%= company != null ? company.getCompanyName() : "N/A" %></span></div>
    <div class="detail-row"><span class="label">Địa điểm:</span> <span class="value"><%= job.getLocation() != null ? job.getLocation() : "-" %></span></div>
    <div class="detail-row"><span class="label">Mức lương:</span> <span class="value"><%= job.getSalaryMin() %> - <%= job.getSalaryMax() %></span></div>
    <div class="detail-row"><span class="label">Loại công việc:</span> <span class="value"><%= job.getJobType() != null ? job.getJobType() : "-" %></span></div>
    <div class="detail-row"><span class="label">Trạng thái:</span> <span class="status-badge status-<%= job.getStatus() %>"><%= job.getStatus() %></span></div>
    <div class="detail-row"><span class="label">Ngày đăng:</span> <span class="value"><%= job.getPostedAt() != null ? job.getPostedAt() : "-" %></span></div>
    <div class="detail-row"><span class="label">Hạn nộp:</span> <span class="value"><%= job.getExpiresAt() != null ? job.getExpiresAt() : "-" %></span></div>
    <div class="detail-row"><span class="label">Phúc lợi:</span> <span class="value"><%= job.getBenefits() != null ? job.getBenefits() : "-" %></span></div>
    <div class="desc-box"><%= job.getDescription() %></div>
    <a href="job-postings.jsp" class="back-btn">Quay lại danh sách</a>
<% } else { %>
    <div>Không tìm thấy tin tuyển dụng.</div>
    <a href="job-postings.jsp" class="back-btn">Quay lại danh sách</a>
<% } %>
</div>
</body>
</html> 