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
        
        // Xử lý tất cả các section reporting giống nhau
        const reportingSections = ['account-stats', 'access-stats', 'activity-reports', 'job-posting-reports', 'application-analysis'];
        
        if (reportingSections.includes(sectionId)) {
            // HTML đã có sẵn, chỉ cần chuyển đổi section
            const allSections = document.querySelectorAll('.report-section');
            allSections.forEach(section => {
                section.classList.remove('active');
            });
            
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
            
            // Gọi refresh function tương ứng
            switch (sectionId) {
                case 'account-stats':
                    if (typeof window.refreshAccountStats === 'function') window.refreshAccountStats();
                    break;
                case 'access-stats':
                    if (typeof window.refreshAccessStats === 'function') window.refreshAccessStats();
                    break;
                case 'activity-reports':
                    if (typeof window.refreshActivityReports === 'function') window.refreshActivityReports();
                    break;
                case 'job-posting-reports':
                    // Đảm bảo HTML được render hoàn toàn trước khi gọi refreshJobReport
                    setTimeout(() => {
                        if (typeof window.refreshJobReport === 'function') window.refreshJobReport();
                    }, 100);
                    break;
                case 'application-analysis':
                    if (typeof window.refreshApplicationAnalysis === 'function') window.refreshApplicationAnalysis();
                    break;
            }
        } else {
            // Các section khác (không phải reporting)
            console.log('Section không được hỗ trợ:', sectionId);
        }
    }

    /**
     * Tải section ban đầu dựa trên URL hash
     */
    function loadInitialSection() {
        const hash = window.location.hash.substring(1);
        
        // Load tất cả HTML của statistics-reports.jsp ngay khi vào trang
        const basePath = getBasePath();
        const jspUrl = basePath + 'views/sections/statistics-reports.jsp';
        
        fetch(jspUrl)
            .then(response => {
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                return response.text();
            })
            .then(html => {
                if (sectionContent) {
                    sectionContent.innerHTML = html;
                }
                
                // Nếu có hash, hiển thị section tương ứng
                if (hash) {
                    const menuLink = document.querySelector(`.menu-link[data-section="${hash}"]`);
                    if (menuLink) {
                        // Hiển thị section được chọn
                        const allSections = document.querySelectorAll('.report-section');
                        allSections.forEach(section => {
                            section.classList.remove('active');
                        });
                        
                        const targetSection = document.getElementById(hash);
                        if (targetSection) {
                            targetSection.classList.add('active');
                        }
                        
                        // Cập nhật active tab
                        const allTabs = document.querySelectorAll('.nav-tab');
                        allTabs.forEach(tab => {
                            tab.classList.remove('active');
                        });
                        
                        const activeTab = document.querySelector(`[data-section="${hash}"]`);
                        if (activeTab) {
                            activeTab.classList.add('active');
                        }
                        
                        // Gọi refresh function tương ứng
                        switch (hash) {
                            case 'account-stats':
                                if (typeof window.refreshAccountStats === 'function') window.refreshAccountStats();
                                break;
                            case 'access-stats':
                                if (typeof window.refreshAccessStats === 'function') window.refreshAccessStats();
                                break;
                            case 'activity-reports':
                                if (typeof window.refreshActivityReports === 'function') window.refreshActivityReports();
                                break;
                            case 'job-posting-reports':
                                // Đảm bảo HTML được render hoàn toàn trước khi gọi refreshJobReport
                                setTimeout(() => {
                                    if (typeof window.refreshJobReport === 'function') window.refreshJobReport();
                                }, 100);
                                break;
                            case 'application-analysis':
                                if (typeof window.refreshApplicationAnalysis === 'function') window.refreshApplicationAnalysis();
                                break;
                        }
                    }
                } else {
                    // Mặc định hiển thị account-stats và load dữ liệu
                    const allSections = document.querySelectorAll('.report-section');
                    allSections.forEach(section => {
                        section.classList.remove('active');
                    });
                    
                    const defaultSection = document.getElementById('account-stats');
                    if (defaultSection) {
                        defaultSection.classList.add('active');
                    }
                    
                    // Cập nhật active tab
                    const allTabs = document.querySelectorAll('.nav-tab');
                    allTabs.forEach(tab => {
                        tab.classList.remove('active');
                    });
                    
                    const defaultTab = document.querySelector('[data-section="account-stats"]');
                    if (defaultTab) {
                        defaultTab.classList.add('active');
                    }
                    
                    // Load dữ liệu mặc định
                    if (typeof window.refreshAccountStats === 'function') window.refreshAccountStats();
                }
            })
            .catch(error => {
                console.error('Error loading initial section:', error);
                if (breadcrumbText) {
                    breadcrumbText.textContent = 'Dashboard Tổng Quan';
                }
            });
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