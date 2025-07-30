/**
 * Section Loader - Đơn giản hóa việc tải các section trong admin panel
 */
document.addEventListener('DOMContentLoaded', function() {
    'use strict';
    
    const menuLinks = document.querySelectorAll('.menu-link');
    const sectionContent = document.getElementById('section-content');
    const breadcrumbText = document.getElementById('breadcrumb-text');

    /**
     * Hiển thị loading spinner
     */
    function showLoading() {
        if (sectionContent) {
            sectionContent.innerHTML = `
                <div class="d-flex justify-content-center align-items-center" style="height: 300px;">
                    <div class="text-center">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="mt-2">Đang tải dữ liệu...</p>
                    </div>
                </div>`;
        }
    }

    /**
     * Hiển thị thông báo lỗi
     * @param {string} message - Nội dung thông báo lỗi
     */
    function showError(message) {
        if (sectionContent) {
            sectionContent.innerHTML = `
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${message}
                </div>`;
        }
    }

    /**
     * Lấy đường dẫn gốc của ứng dụng
     * @returns {string} Đường dẫn gốc
     */
    function getBasePath() {
        const path = window.location.pathname;
        return path.split('/').slice(0, 3).join('/') + '/';
    }

    /**
     * Tải một section dựa trên file và section ID
     * @param {string} file - File JSP cần tải
     * @param {string} sectionId - ID của section cần lấy
     * @param {string} breadcrumb - Tiêu đề hiển thị trên breadcrumb
     */
    function loadSection(file, sectionId, breadcrumb) {
        if (!sectionContent) {
            return;
        }
        showLoading();
        
        // Cập nhật active menu
        menuLinks.forEach(link => {
            const parent = link.parentElement;
            if (parent) {
                parent.classList.remove('active');
                if (link.getAttribute('data-section') === sectionId) {
                    parent.classList.add('active');
                }
            }
        });
        
        // Cập nhật breadcrumb
        if (breadcrumbText && breadcrumb) {
            breadcrumbText.textContent = breadcrumb;
        }
        
        // Cập nhật URL
        window.history.pushState(null, '', `#${sectionId}`);
        
        // Xác định file JSP cần load dựa trên loại section
        const basePath = getBasePath();
        let jspUrl;
        
        // Các section reporting đều load từ statistics-reports.jsp
        const reportingSections = ['account-stats', 'access-stats', 'activity-reports', 'job-posting-reports', 'application-analysis'];
        if (reportingSections.includes(sectionId)) {
            jspUrl = basePath + 'views/sections/statistics-reports.jsp';
        } else {
            // Các section khác load từ file JSP riêng
            jspUrl = basePath + 'views/sections/' + file;
        }
        
        fetch(jspUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.text();
            })
            .then(html => {
                sectionContent.innerHTML = html;
                
                // Đối với các section reporting, cần hiển thị section đúng
                if (reportingSections.includes(sectionId)) {
                    // Setup navigation cho các tab
                    if (typeof window.setupNavigation === 'function') {
                        window.setupNavigation();
                    }
                    
                    // Ẩn tất cả các section
                    const allSections = document.querySelectorAll('.report-section');
                    allSections.forEach(section => {
                        section.classList.remove('active');
                    });
                    
                    // Hiển thị section được chọn
                    const targetSection = document.getElementById(sectionId);
                    if (targetSection) {
                        targetSection.classList.add('active');
                    }
                    
                    // Cập nhật active tab
                    const allTabs = document.querySelectorAll('.nav-tab');
                    allTabs.forEach(tab => {
                        tab.classList.remove('active');
                    });
                    
                    const activeTab = document.querySelector(`[data-section="${sectionId}"]`);
                    if (activeTab) {
                        activeTab.classList.add('active');
                    }
                }
                
                // Sau khi load HTML xong, gọi hàm refresh tương ứng
                switch (sectionId) {
                    case 'account-stats':
                        if (typeof window.loadAllRealData === 'function') {
                            window.loadAllRealData().then(() => {
                                if (typeof window.refreshAccountStats === 'function') window.refreshAccountStats();
                            });
                        } else if (typeof window.refreshAccountStats === 'function') {
                            window.refreshAccountStats();
                        }
                        break;
                    case 'access-stats':
                        if (typeof window.loadAllRealData === 'function') {
                            window.loadAllRealData().then(() => {
                                if (typeof window.refreshAccessStats === 'function') window.refreshAccessStats();
                            });
                        } else if (typeof window.refreshAccessStats === 'function') {
                            window.refreshAccessStats();
                        }
                        break;
                    case 'activity-reports':
                        if (typeof window.loadAllRealData === 'function') {
                            window.loadAllRealData().then(() => {
                                if (typeof window.refreshActivityReports === 'function') window.refreshActivityReports();
                            });
                        } else if (typeof window.refreshActivityReports === 'function') {
                            window.refreshActivityReports();
                        }
                        break;
                    case 'job-posting-reports':
                        if (typeof window.refreshJobReport === 'function') window.refreshJobReport();
                        break;
                    case 'application-analysis':
                        if (typeof window.loadAllRealData === 'function') {
                            window.loadAllRealData().then(() => {
                                if (typeof window.refreshApplicationAnalysis === 'function') window.refreshApplicationAnalysis();
                            });
                        } else if (typeof window.refreshApplicationAnalysis === 'function') {
                            window.refreshApplicationAnalysis();
                        }
                        break;
                    case 'content-section':
                        if (typeof window.loadPosts === 'function') window.loadPosts();
                        break;
                    case 'system-notifications':
                        if (typeof window.initSystemNotifications === 'function') window.initSystemNotifications();
                        break;
                    case 'company-jobs':
                        if (typeof window.loadCompanies === 'function') window.loadCompanies();
                        break;
                    default:
                        console.log(`Section ${sectionId} - No specific refresh function found`);
                        break;
                }
            })
            .catch(error => {
                console.error('Error loading section:', error);
                showError('Không thể tải dữ liệu section');
            });
    }

    /**
     * Tải section ban đầu dựa trên URL hash
     */
    function loadInitialSection() {
        const hash = window.location.hash.substring(1);
        if (hash) {
            const menuLink = document.querySelector(`.menu-link[data-section="${hash}"]`);
            if (menuLink) {
                menuLink.click();
                return;
            }
        }
        
        // Mặc định tải section đầu tiên nếu không có hash
        const firstMenuItem = document.querySelector('.menu-link');
        if (firstMenuItem) {
            firstMenuItem.click();
        } else if (breadcrumbText) {
            breadcrumbText.textContent = 'Dashboard Tổng Quan';
        }
    }

    // Thêm sự kiện click cho các link trong menu
    menuLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const file = this.getAttribute('data-file');
            const section = this.getAttribute('data-section');
            const breadcrumb = this.getAttribute('data-breadcrumb') || this.textContent.trim();
            
            if (file && section) {
                loadSection(file, section, breadcrumb);
            }
        });
    });

    // Xử lý sự kiện back/forward của trình duyệt
    window.addEventListener('popstate', function() {
        const hash = window.location.hash.substring(1);
        if (hash) {
            const menuLink = document.querySelector(`.menu-link[data-section="${hash}"]`);
            if (menuLink) {
                menuLink.click();
            }
        }
    });

    // Khởi tạo
    loadInitialSection();
    
    // Khai báo biến toàn cục để có thể gọi từ bên ngoài
    window.loadSection = loadSection;
    
    console.log('Section loader đã được khởi tạo');
});