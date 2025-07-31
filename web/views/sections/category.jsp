<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div id="categories" class="section-container">
    <div class="section-header d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0"><i class="fas fa-list"></i> Quản lý danh mục</h2>
        <button id="addCategoryBtn" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#categoryModal">
            <i class="fas fa-plus"></i> Thêm danh mục
        </button>
    </div>

    <!-- Category Modal -->
    <div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="categoryModalLabel">Thêm danh mục mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="categoryForm">
                    <div class="modal-body">
                        <input type="hidden" id="categoryId" name="id">
                        <div class="mb-3">
                            <label for="parentCategory" class="form-label">Danh mục cha</label>
                            <select class="form-select" id="parentCategory" name="parent_id">
                                <option value="">(Không có - Danh mục gốc)</option>
                                <!-- Populated by JS -->
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="categoryName" class="form-label">Tên danh mục <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="categoryName" name="name" required 
                                   placeholder="Nhập tên danh mục">
                        </div>
                        <div class="mb-3">
                            <label for="categoryDescription" class="form-label">Mô tả</label>
                            <textarea class="form-control" id="categoryDescription" name="description" 
                                      rows="3" placeholder="Nhập mô tả danh mục"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="categoryIconUrl" class="form-label">Icon URL</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="categoryIconUrl" name="iconUrl" 
                                       placeholder="https://example.com/icon.png">
                                <button class="btn btn-outline-secondary" type="button" id="previewIconBtn">
                                    <i class="fas fa-eye"></i> Xem trước
                                </button>
                            </div>
                            <div id="iconPreview" class="mt-2" style="display: none;">
                                <img id="previewImage" src="" alt="Icon preview" style="width: 32px; height: 32px; border: 1px solid #ddd; border-radius: 4px;">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Lưu
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Categories Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-light fw-bold">
            <i class="fas fa-table"></i> Danh sách danh mục
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0" id="categoriesTable">
                    <thead class="table-light">
                        <tr>
                            <th style="width: 50px" class="text-center">
                                <i class="fas fa-grip-vertical"></i>
                            </th>
                            <th style="width: 80px">ID</th>
                            <th><i class="fas fa-tag"></i> Tên danh mục</th>
                            <th><i class="fas fa-align-left"></i> Mô tả</th>
                            <th style="width: 80px"><i class="fas fa-image"></i> Icon</th>
                            <th style="width: 140px" class="text-center"><i class="fas fa-cogs"></i> Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="categoriesTableBody">
                        <!-- Populated by JS -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
