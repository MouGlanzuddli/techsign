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
                <!-- Account Bar Chart: Tài khoản mới theo ngày -->
                <div class="chart-section fade-in">
                    <div class="chart-header">
                        <h3 class="chart-title">Biểu đồ tài khoản mới theo ngày</h3>
                        <p class="chart-subtitle">Số lượng tài khoản mới được tạo trong khoảng thời gian tuỳ chọn</p>
                        <div class="account-bar-date-range" style="margin-bottom: 16px; display: flex; gap: 12px; align-items: center;">
                            <label for="accountBarStartDate">Từ ngày:</label>
                            <input type="date" id="accountBarStartDate" class="form-control" style="width: 160px;">
                            <label for="accountBarEndDate">Đến ngày:</label>
                            <input type="date" id="accountBarEndDate" class="form-control" style="width: 160px;">
                            <button class="btn btn-primary" id="accountBarRangeBtn" style="margin-left: 8px;" onclick="handleAccountBarRangeClick()">Xem biểu đồ</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="accountBarChart"></canvas>
                        <div id="accountBarNoDataMsg" style="display:none; text-align:center; color:#888; margin:32px 0; font-size:1.1rem;">Không có dữ liệu trong khoảng thời gian này.</div>
                    </div>
                </div>

                <!-- ĐÃ XÓA TOÀN BỘ PHẦN BIỂU ĐỒ XU HƯỚNG TÀI KHOẢN (trendChart) TRONG SECTION THỐNG KÊ TÀI KHOẢN -->
            </div>
        </div>

        <!-- Access Statistics Section -->
        <div id="access-stats" class="report-section">
            <div class="section-header">
                <h2><i class="fas fa-chart-line"></i> Lưu lượng truy cập</h2>
                <p>Chọn khoảng thời gian để xem biểu đồ truy cập</p>
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
                                <h3>Tổng lượt truy cập trong tháng</h3>
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
                                <h3>Thời gian trung bình mỗi phiên (7 ngày)</h3>
                                <div class="stat-number purple" id="avgSessionTime"></div>
                                <span class="stat-change" id="avgSessionTimeChange"></span>
                            </div>
                            <div class="stat-icon purple">
                                <i class="fas fa-clock"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card orange fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Số người truy cập (7 ngày)</h3>
                                <div class="stat-number orange" id="activeUsersWeek"></div>
                                <span class="stat-change" id="activeUsersWeekChange"></span>
                            </div>
                            <div class="stat-icon orange">
                                <i class="fas fa-user-clock"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Access Chart -->
                <div class="chart-section fade-in">
                    <div class="chart-header">
                        <h3 class="chart-title">Biểu đồ truy cập theo ngày</h3>
                        <p class="chart-subtitle">Số lượt truy cập hệ thống trong khoảng thời gian tuỳ chọn</p>
                        <div class="access-bar-date-range" style="margin-bottom: 16px; display: flex; gap: 12px; align-items: center;">
                            <label for="accessBarStartDate">Từ ngày:</label>
                            <input type="date" id="accessBarStartDate" class="form-control" style="width: 160px;">
                            <label for="accessBarEndDate">Đến ngày:</label>
                            <input type="date" id="accessBarEndDate" class="form-control" style="width: 160px;">
                            <button class="btn btn-primary" id="accessBarRangeBtn" style="margin-left: 8px;" onclick="handleAccessBarRangeClick()">Xem biểu đồ</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="accessBarChart"></canvas>
                        <div id="accessBarNoDataMsg" style="display:none; text-align:center; color:#888; margin:32px 0; font-size:1.1rem;">Không có dữ liệu trong khoảng thời gian này.</div>
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

                <!-- Activity Summary Cards -->
                <div class="stats-grid">
                    <div class="stat-card blue fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Tổng hoạt động (30 ngày)</h3>
                                <div class="stat-number blue" id="totalActivities"></div>
                                <span class="stat-change" id="totalActivitiesChange"></span>
                            </div>
                            <div class="stat-icon blue">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card green fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Hoạt động hôm nay</h3>
                                <div class="stat-number green" id="newActivities"></div>
                                <span class="stat-change" id="newActivitiesChange"></span>
                            </div>
                            <div class="stat-icon green">
                                <i class="fas fa-calendar-day"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card purple fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Người dùng tham gia (7 ngày)</h3>
                                <div class="stat-number purple" id="activeParticipants"></div>
                                <span class="stat-change" id="activeParticipantsChange"></span>
                            </div>
                            <div class="stat-icon purple">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card orange fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Hoạt động trung bình/ngày (30 ngày)</h3>
                                <div class="stat-number orange" id="avgDailyActivities"></div>
                                <span class="stat-change" id="avgDailyActivitiesChange"></span>
                            </div>
                            <div class="stat-icon orange">
                                <i class="fas fa-chart-line"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Activity Table -->
                <div class="detail-card fade-in">
                    <div class="detail-header">
                        <div class="detail-icon" style="background: linear-gradient(135deg, #8b5cf6, #7c3aed);">
                            <i class="fas fa-list"></i>
                        </div>
                        <div>
                            <h4 class="detail-title">Chi tiết hoạt động gần đây</h4>
                            <p class="detail-subtitle">Danh sách các hoạt động trong hệ thống</p>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Thời gian</th>
                                    <th>Người dùng</th>
                                    <th>Loại hoạt động</th>
                                    <th>Chi tiết</th>
                                    <th>IP Address</th>
                                </tr>
                            </thead>
                            <tbody id="activityTableBody">
                                <tr>
                                    <td colspan="5" class="text-center">Đang tải dữ liệu...</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- Activity Chart: chuyển xuống cuối section -->
                <div class="chart-section fade-in">
                    <div class="chart-header">
                        <h3 class="chart-title">Hoạt động theo thời gian</h3>
                        <p class="chart-subtitle">Biểu đồ hoạt động trong khoảng thời gian tuỳ chọn</p>
                        <div class="activity-date-range" style="margin-bottom: 16px; display: flex; gap: 12px; align-items: center;">
                            <label for="activityStartDate">Từ ngày:</label>
                            <input type="date" id="activityStartDate" class="form-control" style="width: 160px;">
                            <label for="activityEndDate">Đến ngày:</label>
                            <input type="date" id="activityEndDate" class="form-control" style="width: 160px;">
                            <button class="btn btn-primary" id="activityRangeBtn" style="margin-left: 8px;" onclick="handleActivityRangeClick()">Xem báo cáo</button>
                        </div>
                    </div>
                    <div class="chart-container">
                        <canvas id="activityChart"></canvas>
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

        <!-- Job Posting Reports Section (NEW) -->
        <div id="job-posting-reports" class="report-section">
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
                                <h3>Đơn bị từ chối (tháng này)</h3>
                                <div class="stat-number red" id="jobRejectedApplications">--</div>
                                <span class="stat-change" id="jobRejectedApplicationsChange"></span>
                            </div>
                            <div class="stat-icon red">
                                <i class="fas fa-times"></i>
                            </div>
                        </div>
                    </div>
                    <!-- Card Đơn đang chờ -->
                    <div class="stat-card orange fade-in">
                        <div class="stat-content">
                            <div class="stat-info">
                                <h3>Đơn đang chờ (tháng này)</h3>
                                <div class="stat-number orange" id="jobPendingApplications">--</div>
                                <span class="stat-change" id="jobPendingApplicationsChange"></span>
                            </div>
                            <div class="stat-icon orange">
                                <i class="fas fa-hourglass-half"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Top 10 bài đăng nổi bật trong tháng -->
                <div class="top-job-section" style="margin-top:32px;">
                  <div class="row" style="display:flex; gap:32px; flex-wrap:wrap;">
                    <div class="col" style="flex:1; min-width:320px;">
                      <div class="top10-section">
                        <div class="section-header top10-header">
                          <div class="section-icon top10-icon eye"><i class="fas fa-eye"></i></div>
                          <div>
                            <h4>Top 10 tin tuyển dụng được xem nhiều nhất trong tháng</h4>
                            <div class="section-subtitle">Chỉ tính các tin còn hoạt động trong tháng này</div>
                          </div>
                        </div>
                        <table id="topViewedPostsTable">
                          <thead><tr><th>STT</th><th><i class="fas fa-file-alt"></i> TIÊU ĐỀ</th><th>LƯỢT XEM</th></tr></thead>
                          <tbody></tbody>
                        </table>
                      </div>
                    </div>
                    <div class="col" style="flex:1; min-width:320px;">
                      <div class="top10-section">
                        <div class="section-header top10-header">
                          <div class="section-icon top10-icon users"><i class="fas fa-users"></i></div>
                          <div>
                            <h4>Top 10 tin tuyển dụng có nhiều lượt ứng tuyển nhất trong tháng</h4>
                            <div class="section-subtitle">Chỉ tính các tin còn hoạt động trong tháng này</div>
                          </div>
                        </div>
                        <table id="topAppliedPostsTable">
                          <thead><tr><th>STT</th><th><i class="fas fa-file-alt"></i> TIÊU ĐỀ</th><th>LƯỢT ỨNG TUYỂN</th></tr></thead>
                          <tbody></tbody>
                        </table>
                      </div>
                        </div>
                    </div>
                </div>
                <!-- Biểu đồ tuyển dụng theo thời gian -->
                <div class="job-chart-section" id="jobChartSection" style="display:none;">
                    <div class="chart-header">
                        <h3 class="chart-title">Biểu đồ tin tuyển dụng mới theo ngày</h3>
                        <div class="job-date-range" style="margin-bottom: 16px; display: flex; gap: 12px; align-items: center;">
                            <label for="jobChartFrom">Từ ngày:</label>
                            <input type="date" id="jobChartFrom" class="form-control" style="width: 160px;">
                            <label for="jobChartTo">Đến ngày:</label>
                            <input type="date" id="jobChartTo" class="form-control" style="width: 160px;">
                            <button class="btn btn-primary" id="jobChartBtn" style="margin-left: 8px;" onclick="handleJobChartClick()">Xem báo cáo</button>
                        </div>
                    </div>
                    <div class="chart-container" id="jobPostsChartContainer" style="height:320px;">
                        <canvas id="jobPostsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
