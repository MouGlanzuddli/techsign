/**
 * Section Loader - Centralized data loading system for admin panel
 * Handles dynamic content loading and data fetching for all sections
 */
class SectionLoader {
    constructor() {
        this.basePath = this.getBasePath();
        this.currentSection = null;
        console.log('SectionLoader initialized with basePath:', this.basePath);
    }

    /**
     * Get the correct base path for API calls
     */
    getBasePath() {
        const path = window.location.pathname;
        console.log('Current pathname:', path);
        
        // Handle different URL patterns
        if (path.includes('/adminscreen/')) {
            return '/adminscreen/';
        } else if (path.includes('/')) {
            const parts = path.split('/');
            if (parts.length > 1) {
                return '/' + parts[1] + '/';
            }
        }
        return '/';
    }

    /**
     * Initialize the section loader with event listeners
     */
    init() {
        console.log('Initializing SectionLoader...');
        this.setupSidebarListeners();
        this.loadInitialSection();
    }

    /**
     * Setup sidebar navigation event listeners
     */
    setupSidebarListeners() {
        const menuLinks = document.querySelectorAll('.menu-link');
        console.log('Found menu links:', menuLinks.length);

        menuLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                
                // Update active state
                menuLinks.forEach(l => l.parentElement.classList.remove('active'));
                link.parentElement.classList.add('active');

                const file = link.getAttribute('data-file');
                const section = link.getAttribute('data-section');
                const breadcrumb = link.getAttribute('data-breadcrumb') || link.textContent.trim();

                console.log('Menu clicked:', { file, section, breadcrumb });
                this.loadSectionWithData(file, section, breadcrumb);
            });
        });
    }

    /**
     * Load initial section based on URL hash or default to dashboard
     */
    loadInitialSection() {
        const currentSection = window.location.hash.substring(1);
        if (currentSection) {
            this.loadDataForSection(currentSection);
        } else {
            // Load dashboard overview
            this.loadDashboardOverview();
        }
    }

    /**
     * Load section content and data
     */
    loadSectionWithData(file, sectionId, breadcrumb) {
        console.log('Loading section:', { file, sectionId, breadcrumb });
        this.showLoading();
        
        // First load the JSP file
        const jspUrl = this.basePath + 'views/sections/' + file;
        console.log('Loading JSP from:', jspUrl);
        
        fetch(jspUrl)
            .then(response => {
                console.log('JSP response status:', response.status);
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.text();
            })
            .then(jspContent => {
                console.log('JSP loaded successfully, length:', jspContent.length);
                const parser = new DOMParser();
                const doc = parser.parseFromString(jspContent, 'text/html');
                const section = doc.querySelector('#' + sectionId);
                
                if (section) {
                    document.getElementById('section-content').innerHTML = section.innerHTML;
                    console.log('Section content loaded');
                    attachModalListeners();
                } else {
                    document.getElementById('section-content').innerHTML = '<p>Không tìm thấy nội dung.</p>';
                    console.error('Section not found in JSP:', sectionId);
                }
                
                // Update breadcrumb
                const breadcrumbElement = document.getElementById('breadcrumb-text');
                if (breadcrumbElement && breadcrumb) {
                    breadcrumbElement.textContent = breadcrumb;
                }
                
                // Manually find and execute scripts within the loaded content
                this.executeScriptsInContent(document.getElementById('section-content'));
                
                // Then load data for the section
                this.loadDataForSection(sectionId);
                
                // Explicitly trigger loadPosts() after section is added to DOM for content-section
                if (sectionId === 'content-section' && typeof window.loadPosts === 'function') {
                    window.loadPosts();
                }
            })
            .catch(error => {
                console.error('Error loading section content:', error);
                document.getElementById('section-content').innerHTML = '<p>Lỗi khi tải nội dung.</p>';
            });
    }

    /**
     * Finds and executes all script tags within a given element.
     * This is necessary because scripts loaded via innerHTML are not run by default.
     * @param {HTMLElement} element The container element with the new content.
     */
    executeScriptsInContent(element) {
        const scripts = element.querySelectorAll('script');
        scripts.forEach(oldScript => {
            const newScript = document.createElement('script');
            
            // Copy all attributes from the old script to the new one
            Array.from(oldScript.attributes).forEach(attr => {
                newScript.setAttribute(attr.name, attr.value);
            });
            
            // Copy the script content
            newScript.appendChild(document.createTextNode(oldScript.innerHTML));
            
            // Append the new script to the document head to execute it
            document.head.appendChild(newScript);
            // Clean up by removing the script from the head after it has run
            document.head.removeChild(newScript);
        });
        console.log(`Found and executed ${scripts.length} script(s) in the loaded section.`);
    }

    /**
     * Show loading indicator
     */
    showLoading() {
        const sectionContent = document.getElementById('section-content');
        sectionContent.innerHTML = '<div style="text-align:center;padding:40px"><i class="fas fa-spinner fa-spin fa-2x"></i><br>Đang tải...</div>';
    }

    /**
     * Load data for specific section
     */
    loadDataForSection(sectionId) {
        console.log('Loading data for section:', sectionId);
        this.currentSection = sectionId;
        
        switch(sectionId) {
            case 'user-accounts':
                this.loadUserAccountsData();
                break;
                
            case 'user-management':
                this.loadUserManagementData();
                break;
                
            case 'access-history':
                this.loadAccessHistoryData();
                break;
                
            case 'content-section':
                this.loadPostApprovalData();
                break;
                
            case 'notifications':
                this.loadNotificationsData();
                break;
                
            case 'company-jobs':
                this.loadCompanyJobsData();
                break;
                
            case 'categories':
                this.loadCategoriesData();
                break;
                
            case 'search-verify':
                this.loadSearchVerifyData();
                break;
                
            case 'alert':
                this.loadAlertsData();
                break;
                
            case 'account-stats':
                this.loadAccountStats();
                break;
                
            case 'access-stats':
                this.loadAccessStats();
                break;
                
            case 'activity-reports':
                this.loadActivityReports();
                break;
                
            case 'job-posting-reports':
                this.loadJobPostingReports();
                break;
                
            case 'application-analysis':
                this.loadApplicationAnalysis();
                break;
                
            case 'settings':
                this.loadSettingsData();
                break;
                
            default:
                console.log('Unknown section:', sectionId);
                break;
        }
    }

    /**
     * Load dashboard overview data
     */
    loadDashboardOverview() {
        console.log('Loading dashboard overview...');
        // Load dashboard statistics
        fetch(this.basePath + 'StatisticsServlet?action=getDashboardStats')
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    this.updateDashboardStats(data.stats);
                }
            })
            .catch(error => {
                console.error('Error loading dashboard stats:', error);
            });
    }

    /**
     * Load user accounts data
     */
    loadUserAccountsData() {
        console.log('Loading user accounts data...');
        fetch(this.basePath + 'UserServlet?action=getData')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateUserTable === 'function') {
                    populateUserTable(data.users);
                    this.updateDashboardStats(data.totalUsers);
                    // Initialize search and filter after data is loaded
                    setTimeout(() => {
                        if (typeof setupSearchAndFilter === 'function') {
                            setupSearchAndFilter();
                        }
                    }, 100);
                }
            })
            .catch(error => {
                console.error('Error loading user data:', error);
                this.showErrorMessage('Lỗi khi tải dữ liệu người dùng');
            });
    }

    /**
     * Load user management data (access history) - FIXED VERSION
     */
    loadUserManagementData() {
        console.log('=== LOADING USER MANAGEMENT DATA ===');
        console.log('Base path:', this.basePath);
        
        // Try different URL patterns to find the correct one
        const urls = [
            this.basePath + 'loginHistory?action=getData',
            '/adminscreen/loginHistory?action=getData',
            '/loginHistory?action=getData',
            'loginHistory?action=getData'
        ];
        
        console.log('Trying URLs:', urls);
        
        // Use the first URL (most likely to work)
        const url = urls[0];
        console.log('Using URL:', url);
        
        fetch(url)
            .then(response => {
                console.log('Response received:', response);
                console.log('Status:', response.status);
                console.log('OK:', response.ok);
                
                if (!response.ok) {
                    throw new Error('HTTP error ' + response.status + ' - ' + response.statusText);
                }
                
                // Get response as text first to debug
                return response.text();
            })
            .then(text => {
                console.log('Raw response (first 500 chars):', text.substring(0, 500));
                
                try {
                    const data = JSON.parse(text);
                    console.log('Parsed data:', data);
                    
                    if (typeof populateUserManagementTable === 'function') {
                        console.log('Calling populateUserManagementTable...');
                        populateUserManagementTable(data.loginHistory);
                    } else {
                        console.error('populateUserManagementTable function not found!');
                        this.showErrorMessage('Function populateUserManagementTable not found');
                    }
                } catch (e) {
                    console.error('JSON parse error:', e);
                    console.error('Response was:', text);
                    this.showErrorMessage('Invalid JSON response from server');
                }
            })
            .catch(error => {
                console.error('Fetch error:', error);
                this.showErrorMessage('Lỗi khi tải dữ liệu quản lý người dùng: ' + error.message);
            });
    }

    /**
     * Load access history data
     */
    loadAccessHistoryData() {
        console.log('Loading access history data...');
        fetch(this.basePath + 'loginHistory')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.text();
            })
            .then(html => {
                const contentArea = document.getElementById('contentArea');
                if (contentArea) {
                    contentArea.innerHTML = html;
                }
            })
            .catch(error => {
                console.error('Error loading access history:', error);
                this.showErrorMessage('Lỗi khi tải lịch sử truy cập');
            });
    }

    /**
     * Load post approval data
     */
    loadPostApprovalData() {
        console.log('Loading post approval data...');
        fetch(this.basePath + 'job-posting?action=getAll')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (data.success && typeof loadPosts === 'function') {
                    // Call the loadPosts function that exists in content-management.jsp
                    loadPosts();
                } else if (data.success && typeof populatePostsGrid === 'function') {
                    // Fallback to populatePostsGrid if loadPosts doesn't exist
                    populatePostsGrid(data.data);
                } else {
                    this.showErrorMessage(data.message || 'Lỗi khi tải dữ liệu bài đăng');
                }
            })
            .catch(error => {
                console.error('Error loading post approval data:', error);
                this.showErrorMessage('Lỗi khi tải dữ liệu phê duyệt bài đăng');
            });
    }

    /**
     * Load notifications data
     */
    loadNotificationsData() {
        console.log('Loading notifications data...');
        fetch(this.basePath + 'NotificationServlet?action=getData')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateNotificationsTable === 'function') {
                    populateNotificationsTable(data.notifications);
                }
            })
            .catch(error => {
                console.error('Error loading notifications:', error);
                this.showErrorMessage('Lỗi khi tải thông báo');
            });
    }

    /**
     * Load company jobs data
     */
    loadCompanyJobsData() {
        console.log('Loading company jobs data...');
        // Load companies only
        fetch(this.basePath + 'CompanyPostingServlet?action=getCompanies')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateCompanySelect === 'function') {
                    populateCompanySelect(data.companies);
                }
            })
            .catch(error => {
                console.error('Error loading company jobs data:', error);
                this.showErrorMessage('Lỗi khi tải dữ liệu công việc theo công ty');
            });
    }

    /**
     * Load categories data
     */
    loadCategoriesData() {
        console.log('Loading categories data...');
        fetch(this.basePath + 'category?action=getAll')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (data.success && typeof populateCategoriesTable === 'function') {
                    populateCategoriesTable(data.data);
                } else {
                    this.showErrorMessage(data.message || 'Lỗi khi tải dữ liệu danh mục');
                }
            })
            .catch(error => {
                console.error('Error loading categories:', error);
                this.showErrorMessage('Lỗi khi tải dữ liệu danh mục');
            });
    }

    /**
     * Load search verify data
     */
    loadSearchVerifyData() {
        console.log('Loading search verify data...');
        fetch(this.basePath + 'SearchVerifyServlet?action=getData')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateSearchVerifyTable === 'function') {
                    populateSearchVerifyTable(data.searchResults);
                }
            })
            .catch(error => {
                console.error('Error loading search verify data:', error);
                this.showErrorMessage('Lỗi khi tải dữ liệu tìm kiếm và xác minh');
            });
    }

    /**
     * Load alerts data
     */
    loadAlertsData() {
        console.log('Loading alerts data...');
        fetch(this.basePath + 'AuditLogServlet?action=getData')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateAlertsTable === 'function') {
                    populateAlertsTable(data.alerts);
                }
            })
            .catch(error => {
                console.error('Error loading alerts:', error);
                this.showErrorMessage('Lỗi khi tải cảnh báo');
            });
    }

    /**
     * Load account statistics
     */
    loadAccountStats() {
        console.log('Loading account stats...');
        fetch(this.basePath + 'StatisticsServlet?action=getAccountStats')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateAccountStats === 'function') {
                    populateAccountStats(data.stats);
                }
            })
            .catch(error => {
                console.error('Error loading account statistics:', error);
                this.showErrorMessage('Lỗi khi tải thống kê tài khoản');
            });
    }

    /**
     * Load access statistics
     */
    loadAccessStats() {
        console.log('Loading access stats...');
        fetch(this.basePath + 'StatisticsServlet?action=getAccessStats')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateAccessStats === 'function') {
                    populateAccessStats(data.stats);
                }
            })
            .catch(error => {
                console.error('Error loading access statistics:', error);
                this.showErrorMessage('Lỗi khi tải thống kê truy cập');
            });
    }

    /**
     * Load activity reports
     */
    loadActivityReports() {
        console.log('Loading activity reports...');
        fetch(this.basePath + 'StatisticsServlet?action=getActivityReports')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateActivityReports === 'function') {
                    populateActivityReports(data.reports);
                }
            })
            .catch(error => {
                console.error('Error loading activity reports:', error);
                this.showErrorMessage('Lỗi khi tải báo cáo hoạt động');
            });
    }

    /**
     * Load job posting reports
     */
    loadJobPostingReports() {
        console.log('Loading job posting reports...');
        fetch(this.basePath + 'StatisticsServlet?action=getJobPostingReports')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateJobPostingReports === 'function') {
                    populateJobPostingReports(data.reports);
                }
            })
            .catch(error => {
                console.error('Error loading job posting reports:', error);
                this.showErrorMessage('Lỗi khi tải báo cáo tuyển dụng');
            });
    }

    /**
     * Load application analysis
     */
    loadApplicationAnalysis() {
        console.log('Loading application analysis...');
        fetch(this.basePath + 'StatisticsServlet?action=getApplicationAnalysis')
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.json();
            })
            .then(data => {
                if (typeof populateApplicationAnalysis === 'function') {
                    populateApplicationAnalysis(data.analysis);
                }
            })
            .catch(error => {
                console.error('Error loading application analysis:', error);
                this.showErrorMessage('Lỗi khi tải phân tích ứng dụng');
            });
    }

    /**
     * Load settings data
     */
    loadSettingsData() {
        console.log('Loading settings data...');
        // Settings might not need data loading, just show the form
        const sectionContent = document.getElementById('section-content');
        if (sectionContent) {
            // Settings content should already be loaded from JSP
            console.log('Settings section loaded');
        }
    }

    /**
     * Update dashboard statistics
     */
    updateDashboardStats(stats) {
        // Update dashboard statistics if they exist
        const statsElements = document.querySelectorAll('.stats-cards .number');
        if (statsElements.length > 0 && stats) {
            // Update specific stats based on the data
            console.log('Updating dashboard stats:', stats);
        }
    }

    /**
     * Show error message
     */
    showErrorMessage(message) {
        console.error('Error:', message);
        const errorDiv = document.createElement('div');
        errorDiv.className = 'message message-error';
        errorDiv.textContent = message;
        errorDiv.style.cssText = `
            background: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
        `;
        
        const sectionContent = document.getElementById('section-content');
        if (sectionContent) {
            sectionContent.insertBefore(errorDiv, sectionContent.firstChild);
        }
    }

    /**
     * Show success message
     */
    showSuccessMessage(message) {
        console.log('Success:', message);
        const successDiv = document.createElement('div');
        successDiv.className = 'message message-success';
        successDiv.textContent = message;
        successDiv.style.cssText = `
            background: #d4edda;
            color: #155724;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #c3e6cb;
            border-radius: 4px;
        `;
        
        const sectionContent = document.getElementById('section-content');
        if (sectionContent) {
            sectionContent.insertBefore(successDiv, sectionContent.firstChild);
        }
    }

    /**
     * Reload current section
     */
    reloadCurrentSection() {
        if (this.currentSection) {
            console.log('Reloading current section:', this.currentSection);
            this.loadDataForSection(this.currentSection);
        }
    }

    /**
     * Get current section
     */
    getCurrentSection() {
        return this.currentSection;
    }
}

// Create global instance
const sectionLoader = new SectionLoader();

// Initialize when document is ready
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded, initializing SectionLoader...');
    sectionLoader.init();
});

// Also try to initialize immediately if DOM is already loaded
if (document.readyState === 'loading') {
    console.log('DOM is still loading, waiting for DOMContentLoaded');
} else {
    console.log('DOM is already loaded, initializing SectionLoader immediately');
    sectionLoader.init();
}

function loadSectionFromHash() {
    const section = window.location.hash.substring(1) || 'user-accounts';
    sectionLoader.loadDataForSection(section);
}

window.addEventListener('DOMContentLoaded', loadSectionFromHash);
window.addEventListener('hashchange', loadSectionFromHash);

// Modal logic for SPA using Bootstrap Modal API
window.openModal = function() {
  var modalEl = document.getElementById('userAddModal');
  if (modalEl) {
    var myModal = bootstrap.Modal.getOrCreateInstance(modalEl);
    myModal.show();
  } else {
    console.error('userAddModal not found');
  }
};
window.closeModal = function() {
  var modalEl = document.getElementById('userAddModal');
  if (modalEl) {
    var myModal = bootstrap.Modal.getOrCreateInstance(modalEl);
    myModal.hide();
  } else {
    console.error('userAddModal not found');
  }
};
function attachModalListeners() {
  document.getElementById('addUserBtn')?.addEventListener('click', window.openModal);
  // Bootstrap handles close buttons and backdrop automatically
}