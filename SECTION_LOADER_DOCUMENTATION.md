# Section Loader System Documentation

## Overview
The Section Loader system is a centralized data loading mechanism that maps sidebar navigation with corresponding data loading functions. It provides a clean, organized way to handle different sections of the admin panel.

## Architecture

### File Structure
```
src/main/webapp/js/
├── admin.js              # Main admin functionality
├── section-loader.js     # Section data loading system
└── chatbox.js           # Chat functionality
```

### Core Components

#### 1. SectionLoader Class
- **Location**: `section-loader.js`
- **Purpose**: Centralized data loading for all admin sections
- **Features**:
  - Automatic sidebar event handling
  - Section content loading
  - Data fetching for each section
  - Error handling and loading states

#### 2. Sidebar Mapping
- **Location**: `views/components/sidebar.jsp`
- **Purpose**: Defines navigation structure with data attributes
- **Attributes**:
  - `data-file`: JSP file to load
  - `data-section`: Section ID within the JSP
  - `data-breadcrumb`: Optional breadcrumb text

## Sidebar Configuration

### Current Sidebar Structure
```jsp
<nav class="sidebar">
    <h3>System Management</h3>
    <ul>
        <li>
            <a href="#" class="menu-link" data-file="user-account.jsp" data-section="user-accounts">
                <i class="fas fa-users-cog"></i> Quản lý tài khoản
            </a>
        </li>
        <li>
            <a href="#" class="menu-link" data-file="user-management.jsp" data-section="access-history">
                <i class="fas fa-history"></i> Lịch sử truy cập
            </a>
        </li>
        <!-- More menu items... -->
    </ul>
</nav>
```

### Section Mapping Table

| Section ID | JSP File | Description | Data Loading Function |
|------------|----------|-------------|----------------------|
| `user-accounts` | `user-account.jsp` | User management | `loadUserAccountsData()` |
| `access-history` | `user-management.jsp` | Access logs | `loadAccessHistoryData()` |
| `content-section` | `content-management.jsp` | Post approval | `loadPostApprovalData()` |
| `notifications` | `support-notifications.jsp` | Notifications | `loadNotificationsData()` |
| `company-jobs` | `job-postings.jsp` | Job management | `loadCompanyJobsData()` |
| `industry-data` | `content-management.jsp` | Industry data | `loadIndustryData()` |
| `categories` | `content-management.jsp` | Categories | `loadCategoriesData()` |
| `search-verify` | `content-management.jsp` | Search & verify | `loadSearchVerifyData()` |
| `alerts` | `support-notifications.jsp` | Alerts | `loadAlertsData()` |
| `account-stats` | `statistics-reports.jsp` | Account statistics | `loadAccountStats()` |
| `access-stats` | `statistics-reports.jsp` | Access statistics | `loadAccessStats()` |
| `activity-reports` | `statistics-reports.jsp` | Activity reports | `loadActivityReports()` |
| `job-posting-reports` | `statistics-reports.jsp` | Job reports | `loadJobPostingReports()` |
| `application-analysis` | `statistics-reports.jsp` | Application analysis | `loadApplicationAnalysis()` |
| `settings` | `settings.jsp` | Settings | `loadSettingsData()` |

## Usage

### 1. Automatic Initialization
The section loader automatically initializes when the page loads:

```javascript
document.addEventListener('DOMContentLoaded', function() {
    sectionLoader.init();
});
```

### 2. Manual Section Loading
You can manually load a section:

```javascript
// Load specific section
sectionLoader.loadDataForSection('user-accounts');

// Load section with content and data
sectionLoader.loadSectionWithData('user-account.jsp', 'user-accounts', 'User Management');
```

### 3. Reloading Current Section
```javascript
// Reload data for current section
sectionLoader.reloadCurrentSection();
```

### 4. Getting Current Section
```javascript
const currentSection = sectionLoader.getCurrentSection();
```

## Data Loading Functions

### User Accounts
```javascript
loadUserAccountsData() {
    // Fetches user data from UserServlet
    // Calls populateUserTable() function
    // Updates dashboard stats
}
```

### Access History
```javascript
loadAccessHistoryData() {
    // Fetches access history from loginHistory endpoint
    // Updates content area with HTML response
}
```

### Post Approval
```javascript
loadPostApprovalData() {
    // Fetches posts from post?action=getAll
    // Calls populatePostApprovalTable() function
}
```

### Company Jobs
```javascript
loadCompanyJobsData() {
    // Fetches companies and industries
    // Calls populateCompanySelect() and populateIndustrySelect()
}
```

### Statistics and Reports
```javascript
loadAccountStats() {
    // Fetches account statistics
    // Calls populateAccountStats() function
}
```

## Error Handling

### Built-in Error Handling
```javascript
showErrorMessage(message) {
    // Displays error message in section content
    // Uses consistent styling
}

showSuccessMessage(message) {
    // Displays success message in section content
    // Uses consistent styling
}
```

### Loading States
```javascript
showLoading() {
    // Shows spinner and loading text
    // Replaces section content temporarily
}
```

## Integration with Existing Code

### Compatibility
- **Existing Functions**: All existing `populate*Table()` functions are called by the section loader
- **Event Listeners**: Sidebar click events are automatically handled
- **Error Handling**: Consistent error messages across all sections

### Migration Benefits
- **Centralized Loading**: All data loading logic in one place
- **Consistent UX**: Loading states and error handling
- **Maintainable**: Easy to add new sections or modify existing ones
- **Performance**: Efficient loading with proper error handling

## Adding New Sections

### 1. Add Sidebar Item
```jsp
<li>
    <a href="#" class="menu-link" data-file="new-section.jsp" data-section="new-section">
        <i class="fas fa-icon"></i> New Section
    </a>
</li>
```

### 2. Add Data Loading Function
```javascript
loadNewSectionData() {
    fetch(this.basePath + 'NewServlet?action=getData')
        .then(response => response.json())
        .then(data => {
            if (typeof populateNewSectionTable === 'function') {
                populateNewSectionTable(data.items);
            }
        })
        .catch(error => {
            console.error('Error loading new section data:', error);
            this.showErrorMessage('Lỗi khi tải dữ liệu new section');
        });
}
```

### 3. Add to Switch Statement
```javascript
case 'new-section':
    this.loadNewSectionData();
    break;
```

## Best Practices

### 1. Function Naming
- Use consistent naming: `load[SectionName]Data()`
- Keep function names descriptive and clear

### 2. Error Handling
- Always include `.catch()` blocks
- Use `showErrorMessage()` for user feedback
- Log errors to console for debugging

### 3. Data Population
- Check if population functions exist before calling
- Use `typeof functionName === 'function'` checks

### 4. Loading States
- Show loading indicators for better UX
- Handle both success and error states

## Troubleshooting

### Common Issues

1. **Section Not Loading**
   - Check if JSP file exists in `views/sections/`
   - Verify section ID matches in JSP file
   - Check browser console for errors

2. **Data Not Loading**
   - Verify backend endpoints are working
   - Check if population functions exist
   - Review network tab for failed requests

3. **Sidebar Not Working**
   - Ensure `section-loader.js` is included
   - Check if menu links have correct classes
   - Verify data attributes are set correctly

### Debug Mode
```javascript
// Enable debug logging
console.log('Current section:', sectionLoader.getCurrentSection());
console.log('Base path:', sectionLoader.getBasePath());
```

## Performance Considerations

### 1. Lazy Loading
- Sections load only when accessed
- Reduces initial page load time
- Improves overall performance

### 2. Caching
- Consider implementing section caching
- Cache frequently accessed data
- Implement cache invalidation strategies

### 3. Error Recovery
- Graceful degradation on errors
- Retry mechanisms for failed requests
- User-friendly error messages

## Future Enhancements

### 1. Caching System
- Implement section content caching
- Cache API responses
- Smart cache invalidation

### 2. Progressive Loading
- Load critical content first
- Progressive enhancement
- Better loading indicators

### 3. Offline Support
- Service worker integration
- Offline data access
- Sync when online

The Section Loader system provides a robust, maintainable foundation for the admin panel's data loading needs. 