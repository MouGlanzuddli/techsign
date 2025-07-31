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
                    // Khởi tạo section với data hiện có, không load chart
                    setTimeout(() => {
                        if (typeof window.initializeAccessStatsWithRealData === 'function') window.initializeAccessStatsWithRealData();
                    }, 100);
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
        } else if (sectionId === 'user-management') {
            // Load user management section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/user-management.jsp';
            
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
                        
                        // Initialize the user management functionality
                        if (typeof window.loadAccessHistory === 'function') {
                            window.loadAccessHistory();
                        }
                    }
                })
                .catch(error => {
                    console.error('Error loading user management section:', error);
                    showError('Lỗi khi tải trang quản lý người dùng');
                });
        } else if (sectionId === 'system-notifications') {
            // Load system notifications section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/system-notifications.jsp';
            
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
                        
                        // Load the system notifications JavaScript
                        const script = document.createElement('script');
                        script.src = basePath + 'assets/js/system-notifications.js';
                        script.onload = function() {
                            console.log('System notifications script loaded');
                            // Initialize system notifications
                            if (typeof window.initSystemNotifications === 'function') {
                                window.initSystemNotifications();
                            } else if (typeof window.waitForSystemNotificationsInit === 'function') {
                                window.waitForSystemNotificationsInit();
                            }
                        };
                        script.onerror = function() {
                            console.error('Failed to load system notifications script');
                        };
                        document.head.appendChild(script);
                    }
                })
                .catch(error => {
                    console.error('Error loading system notifications section:', error);
                    showError('Lỗi khi tải trang quản lý thông báo');
                });
        } else if (sectionId === 'user-accounts') {
            // Load user accounts section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/user-account.jsp';
            
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
                        
                        // Load the admin-2.js script for user management functionality
                        const script = document.createElement('script');
                        script.src = basePath + 'assets/js/admin-2.js';
                        script.onload = function() {
                            console.log('User accounts script loaded');
                            // Initialize user management functionality
                            if (typeof window.setupSearchAndFilter === 'function') {
                                window.setupSearchAndFilter();
                            }
                            if (typeof window.loadUserDataWithFilters === 'function') {
                                window.loadUserDataWithFilters('', '');
                            }
                        };
                        script.onerror = function() {
                            console.error('Failed to load user accounts script');
                        };
                        document.head.appendChild(script);
                    }
                })
                .catch(error => {
                    console.error('Error loading user accounts section:', error);
                    showError('Lỗi khi tải trang quản lý tài khoản');
                });
        } else if (sectionId === 'content-section') {
            // Load content management section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/content-management.jsp';
            
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
                        console.log('Content management section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading content management section:', error);
                    showError('Lỗi khi tải trang phê duyệt bài đăng');
                });
        } else if (sectionId === 'company-jobs') {
            // Load job postings section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/job-postings.jsp';
            
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
                        
                        // Load the job postings JavaScript
                        const script = document.createElement('script');
                        script.src = basePath + 'assets/js/job-postings.js';
                        script.onload = function() {
                            console.log('Job postings script loaded');
                        };
                        script.onerror = function() {
                            console.error('Failed to load job postings script');
                        };
                        document.head.appendChild(script);
                        
                        console.log('Job postings section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading job postings section:', error);
                    showError('Lỗi khi tải trang quản lý tuyển dụng');
                });
        } else if (sectionId === 'categories') {
            // Load categories section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/category.jsp';
            
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
                        
                        // Load the category JavaScript
                        const script = document.createElement('script');
                        script.src = basePath + 'assets/js/category.js';
                        script.onload = function() {
                            console.log('Category script loaded');
                            // Initialize category management
                            if (typeof window.initCategoryManagement === 'function') {
                                window.initCategoryManagement();
                            }
                        };
                        script.onerror = function() {
                            console.error('Failed to load category script');
                        };
                        document.head.appendChild(script);
                        
                        console.log('Categories section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading categories section:', error);
                    showError('Lỗi khi tải trang quản lý danh mục');
                });
        } else if (sectionId === 'alerts') {
            // Load alerts section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/alert.jsp';
            
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
                        console.log('Alerts section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading alerts section:', error);
                    showError('Lỗi khi tải trang cảnh báo');
                });
        } else if (sectionId === 'settings') {
            // Load settings section
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/settings.jsp';
            
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
                        console.log('Settings section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading settings section:', error);
                    showError('Lỗi khi tải trang cài đặt');
                });
        } else if (sectionId === 'permissions') {
            // Load permissions section (commented in sidebar but might be needed)
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/user-management.jsp';
            
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
                        console.log('Permissions section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading permissions section:', error);
                    showError('Lỗi khi tải trang gán quyền tài khoản');
                });
        } else if (sectionId === 'user-activity') {
            // Load user activity section (commented in sidebar but might be needed)
            const basePath = getBasePath();
            const jspUrl = basePath + 'views/sections/user-activity.jsp';
            
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
                        console.log('User activity section loaded');
                    }
                })
                .catch(error => {
                    console.error('Error loading user activity section:', error);
                    showError('Lỗi khi tải trang nhật ký hoạt động');
                });
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
                                // Khởi tạo section với data hiện có, không load chart
                                setTimeout(() => {
                                    if (typeof window.initializeAccessStatsWithRealData === 'function') window.initializeAccessStatsWithRealData();
                                }, 100);
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