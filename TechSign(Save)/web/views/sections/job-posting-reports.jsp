<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Job Posting Reports Section -->
<div id="job-posting-reports" class="report-section active">
    <div class="section-header">
        <h2><i class="fas fa-file-invoice"></i> Báo cáo Tuyển dụng</h2>
        <p>Thống kê tổng quan về các tin tuyển dụng và hiệu quả ứng tuyển</p>
    </div>
    <div class="dashboard-wrapper" id="jobDashboardWrapper">
        <div class="update-info-bar">
            <div class="update-left">
                <i class="fas fa-calendar-alt"></i>
                <span>Cập nhật: <span id="jobLastUpdate">--:--</span></span>
            </div>
            <div class="update-right">
                <button class="btn btn-sm btn-primary" onclick="refreshJobReport()">
                    <i class="fas fa-sync-alt"></i> Làm mới
                </button>
            </div>
        </div>
        <div class="stats-grid">
            <div class="stat-card blue fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Tổng tin tuyển dụng (tháng này)</h3>
                        <div class="stat-number blue" id="jobTotalPosts">--</div>
                        <span class="stat-change" id="jobTotalPostsChange"></span>
                    </div>
                    <div class="stat-icon blue">
                        <i class="fas fa-briefcase"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card green fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Tin đang hoạt động (tháng này)</h3>
                        <div class="stat-number green" id="jobActivePosts">--</div>
                        <span class="stat-change" id="jobActivePostsChange"></span>
                    </div>
                    <div class="stat-icon green">
                        <i class="fas fa-check-circle"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card orange fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Tin hết hạn (tháng này)</h3>
                        <div class="stat-number orange" id="jobExpiredPosts">--</div>
                        <span class="stat-change" id="jobExpiredPostsChange"></span>
                    </div>
                    <div class="stat-icon orange">
                        <i class="fas fa-times-circle"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card purple fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Lượt xem trung bình/tin tuyển dụng (tháng này)</h3>
                        <div class="stat-number purple" id="jobAvgViews">--</div>
                        <span class="stat-change" id="jobAvgViewsChange"></span>
                    </div>
                    <div class="stat-icon purple">
                        <i class="fas fa-eye"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card teal fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Ứng viên trung bình/tin tuyển dụng (tháng này)</h3>
                        <div class="stat-number teal" id="jobAvgApplications">--</div>
                        <span class="stat-change" id="jobAvgApplicationsChange"></span>
                    </div>
                    <div class="stat-icon teal">
                        <i class="fas fa-users"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card blue fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Tổng đơn ứng tuyển (tháng này)</h3>
                        <div class="stat-number blue" id="jobTotalApplications">--</div>
                        <span class="stat-change" id="jobTotalApplicationsChange"></span>
                    </div>
                    <div class="stat-icon blue">
                        <i class="fas fa-file-alt"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card green fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Đơn thành công (tháng này)</h3>
                        <div class="stat-number green" id="jobApprovedApplications">--</div>
                        <span class="stat-change" id="jobApprovedApplicationsChange"></span>
                    </div>
                    <div class="stat-icon green">
                        <i class="fas fa-check"></i>
                    </div>
                </div>
            </div>
            <div class="stat-card red fade-in">
                <div class="stat-content">
                    <div class="stat-info">
                        <h3>Đơn từ chối (tháng này)</h3>
                        <div class="stat-number red" id="jobRejectedApplications">--</div>
                        <span class="stat-change" id="jobRejectedApplicationsChange"></span>
                    </div>
                    <div class="stat-icon red">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div> 