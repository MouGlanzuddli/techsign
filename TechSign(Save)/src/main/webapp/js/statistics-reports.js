// Statistics and Reports JavaScript
// This file handles all statistics and reporting functionality

// Global variables for statistics data
let currentStatisticsData = null;
let refreshInterval = null;

// Initialize statistics when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('Statistics and Reports JS loaded');
    initializeStatistics();
});

function initializeStatistics() {
    console.log('Initializing statistics...');
    
    // Load initial statistics
    loadAllStatistics();
    
    // Set up refresh button listeners
    setupRefreshButtons();
    
    // Set up filter listeners
    setupFilterListeners();
}

function loadAllStatistics() {
    console.log('Loading all statistics...');
    
    // Load statistics from the backend
    fetch(getBasePath() + 'StatisticsServlet')
        .then(response => {
            if (!response.ok) throw new Error('HTTP error ' + response.status);
            return response.json();
        })
        .then(data => {
            console.log('ALL real data from TechSignDB...');
            console.log('DATA received from TechSignDB:', data);
            
            currentStatisticsData = data;
            
            // Update all statistics sections
            updateAccountStats(data);
            updateAccessStats(data);
            updateActivityReports(data);
            updateJobPostingReports(data);
            updateApplicationAnalysis(data);
            
            console.log('Real data updated:', {
                accountStats: data,
                accessStats: data,
                activityReports: data,
                applicationAnalysis: data,
                securityStats: data
            });
            
            // Update dashboard stats
            updateDashboardStats(data);
            
            console.log('Initializing account stats with REAL DATA from TechSignDB...');
        })
        .catch(error => {
            console.error('Error loading statistics:', error);
            showErrorMessage('Lỗi khi tải dữ liệu thống kê');
        });
}

function updateAccountStats(data) {
    const container = document.getElementById('accountStatsContainer');
    if (!container) return;
    
    const totalUsers = data.totalUsers || 0;
    const admins = data.admins || 0;
    const candidates = data.candidates || 0;
    const employers = data.employers || 0;
    const activeUsers = data.activeUsers || 0;
    const newUsersLast30Days = data.newUsersLast30Days || 0;
    
    const adminPercentage = totalUsers > 0 ? ((admins / totalUsers) * 100).toFixed(1) : 0;
    const userPercentage = totalUsers > 0 ? ((candidates + employers) / totalUsers * 100).toFixed(1) : 0;
    
    container.innerHTML = `
        <table class="report-table">
            <thead>
                <tr>
                    <th>Loại tài khoản</th>
                    <th>Số lượng</th>
                    <th>Tỷ lệ</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Admin</td>
                    <td>${admins}</td>
                    <td>${adminPercentage}%</td>
                </tr>
                <tr>
                    <td>Ứng viên</td>
                    <td>${candidates}</td>
                    <td>${totalUsers > 0 ? ((candidates / totalUsers) * 100).toFixed(1) : 0}%</td>
                </tr>
                <tr>
                    <td>Nhà tuyển dụng</td>
                    <td>${employers}</td>
                    <td>${totalUsers > 0 ? ((employers / totalUsers) * 100).toFixed(1) : 0}%</td>
                </tr>
                <tr>
                    <td>Tổng cộng</td>
                    <td><strong>${totalUsers}</strong></td>
                    <td>100%</td>
                </tr>
            </tbody>
        </table>
        <div style="margin-top: 20px; padding: 15px; background: #f8f9fa; border-radius: 8px;">
            <h4>Thống kê bổ sung:</h4>
            <ul style="list-style: none; padding: 0;">
                <li>✅ Tài khoản hoạt động: <strong>${activeUsers}</strong></li>
                <li>📈 Tài khoản mới (30 ngày): <strong>${newUsersLast30Days}</strong></li>
            </ul>
        </div>
    `;
}

function updateAccessStats(data) {
    const container = document.getElementById('accessStatsContainer');
    if (!container) return;
    
    const totalVisits = data.totalVisits || 0;
    const todayVisits = data.todayVisits || 0;
    const activeUsersWeek = data.activeUsersWeek || 0;
    const avgSessionMinutes = data.avgSessionMinutes || 0;
    
    container.innerHTML = `
        <table class="report-table">
            <thead>
                <tr>
                    <th>Chỉ số</th>
                    <th>Giá trị</th>
                    <th>Mô tả</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Tổng lượt truy cập</td>
                    <td>${totalVisits.toLocaleString()}</td>
                    <td>Tổng số lượt truy cập từ khi khởi tạo</td>
                </tr>
                <tr>
                    <td>Truy cập hôm nay</td>
                    <td>${todayVisits.toLocaleString()}</td>
                    <td>Số lượt truy cập trong ngày hôm nay</td>
                </tr>
                <tr>
                    <td>Người dùng hoạt động (tuần)</td>
                    <td>${activeUsersWeek}</td>
                    <td>Số người dùng hoạt động trong tuần này</td>
                </tr>
                <tr>
                    <td>Thời gian session TB</td>
                    <td>${avgSessionMinutes} phút</td>
                    <td>Thời gian trung bình mỗi phiên làm việc</td>
                </tr>
            </tbody>
        </table>
    `;
}

function updateActivityReports(data) {
    const container = document.getElementById('activityReportsContainer');
    if (!container) return;
    
    const totalActivities = data.totalActivities || 0;
    const newActivities = data.newActivities || 0;
    const activeParticipants = data.activeParticipants || 0;
    
    container.innerHTML = `
        <table class="report-table">
            <thead>
                <tr>
                    <th>Loại hoạt động</th>
                    <th>Số lượng</th>
                    <th>Mô tả</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Tổng hoạt động</td>
                    <td>${totalActivities}</td>
                    <td>Tổng số hoạt động trong hệ thống</td>
                </tr>
                <tr>
                    <td>Hoạt động mới hôm nay</td>
                    <td>${newActivities}</td>
                    <td>Số hoạt động mới trong ngày hôm nay</td>
                </tr>
                <tr>
                    <td>Người tham gia hoạt động</td>
                    <td>${activeParticipants}</td>
                    <td>Số người dùng đang hoạt động</td>
                </tr>
            </tbody>
        </table>
    `;
}

function updateJobPostingReports(data) {
    const container = document.getElementById('jobPostingReportsContainer');
    if (!container) return;
    
    // Sample data - in real implementation, this would come from the database
    container.innerHTML = `
        <table class="report-table">
            <thead>
                <tr>
                    <th>ID Doanh nghiệp</th>
                    <th>Tên Doanh nghiệp</th>
                    <th>Tổng số tin</th>
                    <th>Tổng ứng tuyển</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>B001</td>
                    <td>ABC Tech Solutions</td>
                    <td>15</td>
                    <td>120</td>
                    <td><button class="action-btn view-btn" onclick="viewCompanyDetails('B001')">Xem chi tiết</button></td>
                </tr>
                <tr>
                    <td>B002</td>
                    <td>Global Marketing</td>
                    <td>8</td>
                    <td>70</td>
                    <td><button class="action-btn view-btn" onclick="viewCompanyDetails('B002')">Xem chi tiết</button></td>
                </tr>
            </tbody>
        </table>
    `;
}

function updateApplicationAnalysis(data) {
    const container = document.getElementById('applicationAnalysisContainer');
    if (!container) return;
    
    const totalApplications = data.totalApplications || 0;
    const approvedApplications = data.approvedApplications || 0;
    const pendingApplications = data.pendingApplications || 0;
    const rejectedApplications = data.rejectedApplications || 0;
    
    const approvalRate = totalApplications > 0 ? ((approvedApplications / totalApplications) * 100).toFixed(1) : 0;
    
    container.innerHTML = `
        <table class="report-table">
            <thead>
                <tr>
                    <th>Trạng thái</th>
                    <th>Số lượng</th>
                    <th>Tỷ lệ</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Đã chấp nhận</td>
                    <td>${approvedApplications}</td>
                    <td>${approvalRate}%</td>
                </tr>
                <tr>
                    <td>Đang chờ</td>
                    <td>${pendingApplications}</td>
                    <td>${totalApplications > 0 ? ((pendingApplications / totalApplications) * 100).toFixed(1) : 0}%</td>
                </tr>
                <tr>
                    <td>Đã từ chối</td>
                    <td>${rejectedApplications}</td>
                    <td>${totalApplications > 0 ? ((rejectedApplications / totalApplications) * 100).toFixed(1) : 0}%</td>
                </tr>
                <tr>
                    <td><strong>Tổng cộng</strong></td>
                    <td><strong>${totalApplications}</strong></td>
                    <td>100%</td>
                </tr>
            </tbody>
        </table>
    `;
}

function updateDashboardStats(data) {
    // Update dashboard statistics cards
    const statsElements = document.querySelectorAll('.stats-cards .number');
    if (statsElements.length >= 4) {
        statsElements[0].textContent = data.totalUsers || 0; // Total accounts
        statsElements[1].textContent = '10'; // Job postings (hardcoded for now)
        statsElements[2].textContent = data.systemWarnings || 0; // Security alerts
        statsElements[3].textContent = data.todayVisits || 0; // Today's visits
    }
}

function setupRefreshButtons() {
    // Find all refresh buttons and add click listeners
    const refreshButtons = document.querySelectorAll('.btn-filter, button[onclick*="refresh"]');
    refreshButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('Refreshing statistics...');
            loadAllStatistics();
        });
    });
}

function setupFilterListeners() {
    // Add listeners for filter dropdowns
    const filterSelects = document.querySelectorAll('select[id*="filter"]');
    filterSelects.forEach(select => {
        select.addEventListener('change', function() {
            console.log('Filter changed:', this.id, this.value);
            // You can add specific filter logic here
        });
    });
}

function viewCompanyDetails(companyId) {
    console.log('Viewing company details for:', companyId);
    // Implement company details view
    alert('Xem chi tiết công ty: ' + companyId);
}

function getBasePath() {
    const path = window.location.pathname;
    if (path.includes('/TechSign/')) {
        return '/TechSign/';
    } else if (path.includes('/adminscreen/')) {
        return '/adminscreen/';
    } else if (path.includes('/')) {
        const parts = path.split('/');
        if (parts.length > 1) {
            return '/' + parts[1] + '/';
        }
    }
    return '/';
}

function showErrorMessage(message) {
    console.error('Error:', message);
    // You can implement a more sophisticated error display here
}

// Export functions for use in other scripts
window.statisticsReports = {
    loadAllStatistics,
    updateAccountStats,
    updateAccessStats,
    updateActivityReports,
    updateJobPostingReports,
    updateApplicationAnalysis,
    viewCompanyDetails
}; 