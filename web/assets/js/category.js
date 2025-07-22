/**
 * Category Management JavaScript
 * Handles CRUD operations and drag-and-drop reordering for categories
 */

// Global variables
let editingId = null;
let categories = [];
let categoryModal = null;

/**
 * Initialize category management functionality
 */
function initCategoryManagement() {
    console.log('Initializing category management...');
    const modalElement = document.getElementById('categoryModal');
    if (modalElement && window.bootstrap && bootstrap.Modal) {
        categoryModal = new bootstrap.Modal(modalElement);
    }
    
    const addBtn = document.getElementById('addCategoryBtn');
    const form = document.getElementById('categoryForm');
    const previewIconBtn = document.getElementById('previewIconBtn');

    if (addBtn) {
        addBtn.addEventListener('click', showAddForm);
    }
    
    if (form) {
        form.addEventListener('submit', handleFormSubmit);
    }
    
    if (previewIconBtn) {
        previewIconBtn.addEventListener('click', previewIcon);
    }
    
    // Handle modal events
    if (modalElement) {
        modalElement.addEventListener('hidden.bs.modal', function () {
            resetForm();
        });
    }
}

/**
 * Show the add category form
 */
function showAddForm() {
    const modalTitle = document.getElementById('categoryModalLabel');
    if (modalTitle) {
        modalTitle.textContent = 'Thêm danh mục mới';
    }
    resetForm();
    populateParentDropdown();
    categoryModal.show();
}

/**
 * Reset the form
 */
function resetForm() {
    const form = document.getElementById('categoryForm');
    if (form) {
        form.reset();
    }
    editingId = null;
    hideIconPreview();
}

/**
 * Hide icon preview
 */
function hideIconPreview() {
    const iconPreview = document.getElementById('iconPreview');
    if (iconPreview) {
        iconPreview.style.display = 'none';
    }
}

/**
 * Preview icon
 */
function previewIcon() {
    const iconUrl = document.getElementById('categoryIconUrl').value;
    const iconPreview = document.getElementById('iconPreview');
    const previewImage = document.getElementById('previewImage');
    
    if (iconUrl && iconPreview && previewImage) {
        previewImage.src = iconUrl;
        iconPreview.style.display = 'block';
        
        // Handle image load error
        previewImage.onerror = function() {
            iconPreview.innerHTML = '<div class="text-danger"><i class="fas fa-exclamation-triangle"></i> Không thể tải hình ảnh</div>';
        };
        
        previewImage.onload = function() {
            iconPreview.innerHTML = '<img id="previewImage" src="' + iconUrl + '" alt="Icon preview" style="width: 32px; height: 32px; border: 1px solid #ddd; border-radius: 4px;">';
        };
    }
}

/**
 * Handle form submission for add/edit
 */
function handleFormSubmit(e) {
    e.preventDefault();
    
    const form = e.target;
    const formData = new FormData(form);
    const action = editingId ? 'update' : 'add';
    
    // Add action to form data
    formData.append('action', action);
    
    // Show loading state
    const submitBtn = form.querySelector('button[type="submit"]');
    const originalText = submitBtn ? submitBtn.textContent : 'Lưu';
    if (submitBtn) {
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';
        submitBtn.disabled = true;
    }
    
    const basePath = getBasePath();
    fetch(basePath + 'category', {
        method: 'POST',
        body: new URLSearchParams(formData)
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            categoryModal.hide();
            showSuccessMessage(data.message || 'Danh mục đã được lưu thành công');
            // Reload the current section to refresh the table
            if (window.sectionLoader && typeof window.sectionLoader.reloadCurrentSection === 'function') {
                window.sectionLoader.reloadCurrentSection();
            }
        } else {
            showErrorMessage(data.message || 'Lỗi khi lưu danh mục');
        }
    })
    .catch(error => {
        console.error('Error saving category:', error);
        showErrorMessage('Lỗi khi lưu danh mục. Vui lòng thử lại.');
    })
    .finally(() => {
        // Reset button state
        if (submitBtn) {
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
        }
    });
}

/**
 * Populate the categories table
 * This function is called by section-loader.js
 */
function populateCategoriesTable(categoriesData) {
    console.log('Populating categories table with:', categoriesData);
    categories = categoriesData || [];
    
    const tbody = document.getElementById('categoriesTableBody');
    const table = document.getElementById('categoriesTable');
    const emptyState = document.getElementById('emptyState');
    
    if (!tbody) {
        console.error('Categories table body not found');
        return;
    }

    if (!categories || categories.length === 0) {
        if (table) table.style.display = 'none';
        if (emptyState) emptyState.style.display = 'block';
        return;
    }

    if (table) table.style.display = 'table';
    if (emptyState) emptyState.style.display = 'none';

    let html = '';
    categories.forEach(category => {
        html += `
            <tr data-id="${category.id}">
                <td class="text-center">
                    <div class="drag-handle" style="cursor: move; color: #6c757d;">
                        <i class="fas fa-grip-vertical"></i>
                    </div>
                </td>
                <td><span class="badge bg-secondary">${category.id}</span></td>
                <td>
                    <div class="d-flex align-items-center">
                        ${category.iconUrl ? `<img src="${escapeHtml(category.iconUrl)}" alt="icon" class="me-2" style="width: 24px; height: 24px; border-radius: 4px;">` : ''}
                        <strong>${escapeHtml(category.name)}</strong>
                    </div>
                </td>
                <td>${escapeHtml(category.description || '-')}</td>
                <td class="text-center">
                    ${category.iconUrl ? `<img src="${escapeHtml(category.iconUrl)}" alt="icon" style="width: 24px; height: 24px; border-radius: 4px;">` : '<span class="text-muted">-</span>'}
                </td>
                <td class="text-center">
                    <div class="btn-group btn-group-sm" role="group">
                        <button class="btn btn-outline-primary" title="Chỉnh sửa" onclick="editCategory(${category.id})">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-outline-danger" title="Xóa" onclick="deleteCategory(${category.id})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </td>
            </tr>
        `;
    });

    tbody.innerHTML = html;
    
    // Initialize drag and drop functionality
    initDragAndDrop();
}

/**
 * Edit a category
 */
function editCategory(categoryId) {
    const category = categories.find(cat => cat.id === categoryId);
    if (!category) {
        showErrorMessage('Không tìm thấy danh mục');
        return;
    }
    
    const modalTitle = document.getElementById('categoryModalLabel');
    const categoryIdInput = document.getElementById('categoryId');
    const categoryNameInput = document.getElementById('categoryName');
    const categoryDescriptionInput = document.getElementById('categoryDescription');
    const categoryIconUrlInput = document.getElementById('categoryIconUrl');
    
    if (modalTitle && categoryIdInput && categoryNameInput && categoryDescriptionInput && categoryIconUrlInput) {
        editingId = category.id;
        modalTitle.textContent = 'Chỉnh sửa danh mục';
        categoryIdInput.value = category.id;
        categoryNameInput.value = category.name;
        categoryDescriptionInput.value = category.description || '';
        categoryIconUrlInput.value = category.iconUrl || '';
        
        // Show icon preview if exists
        if (category.iconUrl) {
            const iconPreview = document.getElementById('iconPreview');
            const previewImage = document.getElementById('previewImage');
            if (iconPreview && previewImage) {
                previewImage.src = category.iconUrl;
                iconPreview.style.display = 'block';
            }
        }
        
        populateParentDropdown(category.id, category.parentId);
        categoryModal.show();
    }
}

/**
 * Delete a category
 */
function deleteCategory(categoryId) {
    if (!confirm('Bạn có chắc chắn muốn xóa danh mục này?')) {
        return;
    }
    
    const basePath = getBasePath();
    fetch(basePath + 'category', {
        method: 'POST',
        body: new URLSearchParams({
            action: 'delete',
            id: categoryId
        })
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (data.success) {
            showSuccessMessage(data.message || 'Danh mục đã được xóa thành công');
            // Reload the current section to refresh the table
            if (window.sectionLoader && typeof window.sectionLoader.reloadCurrentSection === 'function') {
                window.sectionLoader.reloadCurrentSection();
            }
        } else {
            showErrorMessage(data.message || 'Lỗi khi xóa danh mục');
        }
    })
    .catch(error => {
        console.error('Error deleting category:', error);
        showErrorMessage('Lỗi khi xóa danh mục. Vui lòng thử lại.');
    });
}

/**
 * Initialize drag and drop functionality for reordering
 */
function initDragAndDrop() {
    const tbody = document.getElementById('categoriesTableBody');
    if (!tbody) return;
    
    let dragSrcEl = null;
    
    tbody.querySelectorAll('tr').forEach(row => {
        row.draggable = true;
        
        row.addEventListener('dragstart', function(e) {
            dragSrcEl = this;
            e.dataTransfer.effectAllowed = 'move';
            this.classList.add('table-active');
        });
        
        row.addEventListener('dragend', function() {
            this.classList.remove('table-active');
        });
        
        row.addEventListener('dragover', function(e) {
            e.preventDefault();
            e.dataTransfer.dropEffect = 'move';
        });
        
        row.addEventListener('drop', function(e) {
            e.preventDefault();
            if (dragSrcEl !== this) {
                tbody.insertBefore(dragSrcEl, this.nextSibling);
                saveNewOrder();
            }
        });
    });
}

/**
 * Save the new order after drag and drop
 */
function saveNewOrder() {
    const tbody = document.getElementById('categoriesTableBody');
    if (!tbody) return;
    
    const newOrder = Array.from(tbody.querySelectorAll('tr'))
        .map(tr => tr.getAttribute('data-id'))
        .filter(id => id !== null);
    
    if (newOrder.length === 0) return;
    
    const basePath = getBasePath();
    fetch(basePath + 'category', {
        method: 'POST',
        body: new URLSearchParams({
            action: 'reorder',
            order: newOrder.join(',')
        })
    })
    .then(response => {
        if (!response.ok) throw new Error('HTTP error ' + response.status);
        return response.json();
    })
    .then(data => {
        if (!data.success) {
            showErrorMessage(data.message || 'Lỗi khi sắp xếp lại danh mục');
        }
    })
    .catch(error => {
        console.error('Error reordering categories:', error);
        showErrorMessage('Lỗi khi sắp xếp lại danh mục');
    });
}

/**
 * Utility function to escape HTML
 */
function escapeHtml(text) {
    if (!text) return '';
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

/**
 * Get base path for API calls
 */
function getBasePath() {
    const path = window.location.pathname;
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
 * Show success message
 */
function showSuccessMessage(message) {
    if (window.sectionLoader && typeof window.sectionLoader.showSuccessMessage === 'function') {
        window.sectionLoader.showSuccessMessage(message);
    } else {
        alert(message);
    }
}

/**
 * Show error message
 */
function showErrorMessage(message) {
    if (window.sectionLoader && typeof window.sectionLoader.showErrorMessage === 'function') {
        window.sectionLoader.showErrorMessage(message);
    } else {
        alert(message);
    }
}

function populateParentDropdown(currentId = null, selectedParentId = null) {
    const select = document.getElementById('parentCategory');
    if (!select) return;
    let html = '<option value="">(Không có - Danh mục gốc)</option>';
    categories.forEach(cat => {
        if (!currentId || cat.id !== currentId) {
            html += `<option value="${cat.id}"${selectedParentId == cat.id ? ' selected' : ''}>${cat.name}</option>`;
        }
    });
    select.innerHTML = html;
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    // Small delay to ensure all elements are loaded
    setTimeout(initCategoryManagement, 100);
});

// Also initialize immediately if DOM is already loaded
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCategoryManagement);
} else {
    initCategoryManagement();
}
