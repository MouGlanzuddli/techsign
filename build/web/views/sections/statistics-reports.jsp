<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Statistics Reports Content -->
<div class="reports-container">
    <!-- Navigation Tabs -->
    <div class="reports-nav">
        <div class="nav-tabs">
            <button class="nav-tab active" data-section="account-stats">
                <i class="fas fa-chart-bar"></i>
                <span>Thống kê tài khoản</span>
            </button>
            <button class="nav-tab" data-section="access-stats">
                <i class="fas fa-chart-line"></i>
                <span>Thống kê truy cập</span>
            </button>
            <button class="nav-tab" data-section="activity-reports">
                <i class="fas fa-file-alt"></i>
                <span>Báo cáo hoạt động</span>
            </button>
            <button class="nav-tab" data-section="job-posting-reports">
                <i class="fas fa-file-invoice"></i>
                <span>Báo cáo tuyển dụng</span>
            </button>
            <button class="nav-tab" data-section="application-analysis">
                <i class="fas fa-chart-pie"></i>
                <span>Phân tích ứng dụng</span>
            </button>
        </div>
    </div>

    <!-- Content Sections -->
    <div class="reports-content">
        
        <!-- Account Statistics Section -->
        <div id="account-stats" class="report-section active">
            <div class="section-header">
                <h2><i class="fas fa-chart-bar"></i> Thống kê Tài khoản</h2>
                <p>Tổng quan về tình trạng tài khoản hệ thống tuyển dụng</p>
            </div>
            
            <!-- Include Account Statistics Dashboard -->
            <div class="dashboard-wrapper">
                <!-- Update Info -->
                <div class="update-info-bar">
                    <div class="update-left">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Cập nhật: <span id="lastUpdate">--:--</span></span>
                    </div>
                    <div class="update-right">
                        <button class="btn btn-sm btn-primary" onclick="refreshAccountStats()">
                            <i class="fas fa-sync-alt"></i> Làm mới
                        </button>
                    </div>
                </div>

                <!-- Quick Stats -->
                <div class="stats-grid">
                    <div class="stat-card blue fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tổng tài khoản</h3>
                                <div class="stat-number blue" id="totalAccounts"></div>
                                <span class="stat-change" id="totalChange"></span>
                            </div>
                            <div class="stat-icon blue">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card green fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tài khoản mới (30 ngày)</h3>
                                <div class="stat-number green" id="newAccounts"></div>
                                <span class="stat-change" id="newChange"></span>
                            </div>
                            <div class="stat-icon green">
                                <i class="fas fa-user-plus"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card red fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tài khoản không hoạt động</h3>
                                <div class="stat-number red" id="inactiveAccounts"></div>
                                <span class="stat-change" id="inactiveChange"></span>
                            </div>
                            <div class="stat-icon red">
                                <i class="fas fa-user-times"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card yellow fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tăng trưởng tài khoản mới (tháng)</h3>
                                <div class="stat-number yellow" id="growthRate"></div>
                                <span class="stat-change" id="growthChange"></span>
                            </div>
                            <div class="stat-icon yellow">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Chart -->
                <div class="chart-section fade-in">
                    <div class="chart-header">
                        <h3 class="chart-title">Phân bố Tài khoản Hệ thống</h3>
                        <p class="chart-subtitle">Tổng quan về các loại tài khoản trong hệ thống</p>
                    </div>
                    
                    <div class="chart-grid">
                        <div class="chart-container">
                            <canvas id="mainChart"></canvas>
                        </div>
                        
                        <div class="chart-legend" id="mainChartLegend">
                            <!-- Legend sẽ được tạo bởi JavaScript -->
                        </div>
                    </div>
                </div>

                <!-- Detail Statistics -->
                <div class="detail-grid">
                    <!-- Account Types -->
                    <div class="detail-card fade-in">
                        <div class="detail-header">
                            <div class="detail-icon" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
                                <i class="fas fa-users"></i>
                            </div>
                            <div>
                                <h4 class="detail-title">Phân loại Tài khoản</h4>
                                <p class="detail-subtitle">Chi tiết theo vai trò người dùng</p>
                            </div>
                        </div>
                        
                        <div id="accountTypeStats">
                            <!-- Sẽ được tạo bởi JavaScript -->
                        </div>
                    </div>

                    <!-- Account Status -->
                    <div class="detail-card fade-in">
                        <div class="detail-header">
                            <div class="detail-icon" style="background: linear-gradient(135deg, #10b981, #059669);">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div>
                                <h4 class="detail-title">Trạng thái Tài khoản</h4>
                                <p class="detail-subtitle">Tình trạng hoạt động của tài khoản</p>
                            </div>
                        </div>
                        
                        <div id="statusStats">
                            <!-- Sẽ được tạo bởi JavaScript -->
                        </div>
                    </div>
                </div>

                <!-- Trend Chart -->
                <div class="chart-section fade-in">
                    <div class="chart-header">
                        <h3 class="chart-title">Xu hướng 6 tháng gần đây</h3>
                        <p class="chart-subtitle">Biến động số lượng tài khoản theo thời gian</p>
                    </div>
                    
                    <div class="chart-container">
                        <canvas id="trendChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Access Statistics Section -->
        <div id="access-stats" class="report-section">
            <div class="section-header">
                <h2><i class="fas fa-chart-line"></i> Thống kê Truy cập</h2>
                <p>Phân tích lưu lượng truy cập và hành vi người dùng</p>
            </div>
            
            <!-- Access Statistics Content -->
            <div class="dashboard-wrapper">
                <div class="update-info-bar">
                    <div class="update-left">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Cập nhật: <span id="accessLastUpdate">--:--</span></span>
                    </div>
                    <div class="update-right">
                        <button class="btn btn-sm btn-primary" onclick="refreshAccessStats()">
                            <i class="fas fa-sync-alt"></i> Làm mới
                        </button>
                    </div>
                </div>

                <!-- Access Stats Grid -->
                <div class="stats-grid">
                    <div class="stat-card blue fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tổng lượt truy cập</h3>
                                <div class="stat-number blue" id="totalVisits"></div>
                                <span class="stat-change" id="totalVisitsChange"></span>
                            </div>
                            <div class="stat-icon blue">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card green fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Lượt truy cập hôm nay</h3>
                                <div class="stat-number green" id="todayVisits"></div>
                                <span class="stat-change" id="todayVisitsChange"></span>
                            </div>
                            <div class="stat-icon green">
                                <i class="fas fa-eye"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card purple fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Người dùng hoạt động (tuần)</h3>
                                <div class="stat-number purple" id="activeUsersWeek"></div>
                                <span class="stat-change" id="activeUsersWeekChange"></span>
                            </div>
                            <div class="stat-icon purple">
                                <i class="fas fa-user-clock"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card orange fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Thời gian trung bình</h3>
                                <div class="stat-number orange" id="avgSessionTime"></div>
                                <span class="stat-change" id="avgSessionTimeChange"></span>
                            </div>
                            <div class="stat-icon orange">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card red fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tỷ lệ thoát</h3>
                                <div class="stat-number red" id="bounceRate"></div>
                                <span class="stat-change" id="bounceRateChange"></span>
                            </div>
                            <div class="stat-icon red">
                                <i class="fas fa-sign-out-alt"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Access Chart -->
                <div class="chart-section fade-in">
                    <div class="chart-header">
                        <h3 class="chart-title">Lưu lượng truy cập theo giờ</h3>
                        <p class="chart-subtitle">Phân tích mẫu truy cập trong ngày</p>
                    </div>
                    
                    <div class="chart-container">
                        <canvas id="accessChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Activity Reports Section -->
        <div id="activity-reports" class="report-section">
            <div class="section-header">
                <h2><i class="fas fa-file-alt"></i> Báo cáo Hoạt động</h2>
                <p>Chi tiết các hoạt động và sự kiện trong hệ thống</p>
            </div>
            
            <div class="dashboard-wrapper">
                <div class="update-info-bar">
                    <div class="update-left">
                        <i class="fas fa-calendar-alt"></i>
                        <span>Cập nhật: <span id="activityLastUpdate">--:--</span></span>
                    </div>
                    <div class="update-right">
                        <button class="btn btn-sm btn-primary" onclick="refreshActivityReports()">
                            <i class="fas fa-sync-alt"></i> Làm mới
                        </button>
                    </div>
                </div>

                <div class="activity-filters">
                    <div class="filter-group">
                        <label>Từ ngày:</label>
                        <input type="date" id="startDate" class="form-control">
                    </div>
                    <div class="filter-group">
                        <label>Đến ngày:</label>
                        <input type="date" id="endDate" class="form-control">
                    </div>
                    <div class="filter-group">
                        <label>Loại hoạt động:</label>
                        <select id="activityType" class="form-control">
                            <option value="">Tất cả</option>
                            <option value="login">Đăng nhập</option>
                            <option value="register">Đăng ký</option>
                            <option value="job_post">Đăng tin tuyển dụng</option>
                            <option value="application">Nộp đơn</option>
                        </select>
                    </div>
                    <button class="btn btn-primary" onclick="generateActivityReport()">
                        <i class="fas fa-search"></i> Tạo báo cáo
                    </button>
                </div>

                <div class="activity-results">
                    <div class="activity-summary">
                        <h4>Tổng quan hoạt động</h4>
                        <div class="summary-stats">
                            <div class="summary-item">
                                <span class="summary-label">Tổng hoạt động:</span>
                                <span class="summary-value" id="totalActivities"></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label">Hoạt động mới:</span>
                                <span class="summary-value" id="newActivities"></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label">Người dùng tham gia:</span>
                                <span class="summary-value" id="activeParticipants"></span>
                            </div>
                        </div>
                    </div>

                    <div class="activity-chart">
                        <canvas id="activityChart"></canvas>
                    </div>

                    <div class="activity-table">
                        <h4>Chi tiết hoạt động</h4>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Thời gian</th>
                                        <th>Người dùng</th>
                                        <th>Hoạt động</th>
                                        <th>Chi tiết</th>
                                        <th>IP</th>
                                    </tr>
                                </thead>
                                <tbody id="activityTableBody">
                                    <!-- Sẽ được tạo bởi JavaScript -->
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Job Posting Reports Section -->
        <div id="job-posting-reports" class="report-section">
            <div class="section-header">
                <h2><i class="fas fa-file-invoice"></i> Báo cáo Tuyển dụng</h2>
                <p>Phân tích hiệu quả các tin tuyển dụng và ứng viên</p>
            </div>
            
            <div class="dashboard-wrapper">
                <div class="job-stats-grid">
                    <div class="stat-card blue fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tổng tin tuyển dụng</h3>
                                <div class="stat-number blue" id="totalJobPosts"></div>
                                <span class="stat-change" id="totalJobPostsChange"></span>
                            </div>
                            <div class="stat-icon blue">
                                <i class="fas fa-briefcase"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card green fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tin đang hoạt động</h3>
                                <div class="stat-number green" id="activeJobPosts"></div>
                                <span class="stat-change" id="activeJobPostsChange"></span>
                            </div>
                            <div class="stat-icon green">
                                <i class="fas fa-check-circle"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card orange fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Lượt xem trung bình</h3>
                                <div class="stat-number orange" id="avgJobViews"></div>
                                <span class="stat-change" id="avgJobViewsChange"></span>
                            </div>
                            <div class="stat-icon orange">
                                <i class="fas fa-eye"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card purple fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Ứng viên trung bình</h3>
                                <div class="stat-number purple" id="avgApplications"></div>
                                <span class="stat-change" id="avgApplicationsChange"></span>
                            </div>
                            <div class="stat-icon purple">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="job-chart-section">
                    <div class="chart-header">
                        <h3 class="chart-title">Hiệu quả tin tuyển dụng</h3>
                        <p class="chart-subtitle">So sánh lượt xem và ứng viên theo ngành nghề</p>
                    </div>
                    
                    <div class="chart-container">
                        <canvas id="jobEffectivenessChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Application Analysis Section -->
        <div id="application-analysis" class="report-section">
            <div class="section-header">
                <h2><i class="fas fa-chart-pie"></i> Phân tích Ứng dụng</h2>
                <p>Thống kê chi tiết về quá trình tuyển dụng và ứng viên</p>
            </div>
            
            <div class="dashboard-wrapper">
                <div class="application-stats-grid">
                    <div class="stat-card blue fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tổng đơn ứng tuyển</h3>
                                <div class="stat-number blue" id="totalApplications"></div>
                                <span class="stat-change" id="totalApplicationsChange"></span>
                            </div>
                            <div class="stat-icon blue">
                                <i class="fas fa-file-alt"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card green fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Đã phê duyệt</h3>
                                <div class="stat-number green" id="approvedApplications"></div>
                                <span class="stat-change" id="approvedApplicationsChange"></span>
                            </div>
                            <div class="stat-icon green">
                                <i class="fas fa-check"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card yellow fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Đang xử lý</h3>
                                <div class="stat-number yellow" id="pendingApplications"></div>
                                <span class="stat-change" id="pendingApplicationsChange"></span>
                            </div>
                            <div class="stat-icon yellow">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card red fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Từ chối</h3>
                                <div class="stat-number red" id="rejectedApplications"></div>
                                <span class="stat-change" id="rejectedApplicationsChange"></span>
                            </div>
                            <div class="stat-icon red">
                                <i class="fas fa-times"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="application-charts">
                    <div class="chart-section fade-in">
                        <div class="chart-header">
                            <h3 class="chart-title">Tỷ lệ phê duyệt theo thời gian</h3>
                            <p class="chart-subtitle">Xu hướng xử lý đơn ứng tuyển</p>
                        </div>
                        
                        <div class="chart-container">
                            <canvas id="applicationTrendChart"></canvas>
                        </div>
                    </div>

                    <div class="chart-section fade-in">
                        <div class="chart-header">
                            <h3 class="chart-title">Phân bố ứng viên theo ngành</h3>
                            <p class="chart-subtitle">Thống kê ứng viên theo lĩnh vực</p>
                        </div>
                        
                        <div class="chart-container">
                            <canvas id="applicationSectorChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
