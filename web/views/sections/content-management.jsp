<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý Nội dung & Dữ liệu</title>
    <link href="css/admin.css" rel="stylesheet" /> <%-- Keep your external CSS link --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* General Body and Heading Styles */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f7fc;
            padding: 30px;
            color: #333;
            line-height: 1.6; /* Ensure consistent line height */
        }

        h2 {
            color: #1e3a8a;
            margin-bottom: 25px;
            font-size: 2.2em; /* Larger main title */
            font-weight: bold;
        }

        h3 {
            color: #1e3a8a;
            margin-bottom: 20px;
            border-bottom: 2px solid #e0e7ff; /* Subtle separator */
            padding-bottom: 10px;
            font-size: 1.8em; /* Consistent subheading size */
            font-weight: bold;
        }
        h4 {
            color: #1e3a8a;
            margin-bottom: 15px;
            font-size: 1.5em; /* Consistent form/card title size */
            font-weight: bold;
        }


        /* --- Base Card & Form Container Styles (Re-used & Unified) --- */
        .base-card {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            padding: 25px; /* Consistent padding */
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            margin-bottom: 20px;
        }

        .base-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .form-container {
            /* Now often contained within a base-card or modal-content */
            padding: 25px; /* Match base-card padding */
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05); /* Lighter shadow for forms */
            margin-bottom: 20px;
        }

        .form-container label,
        .modal-content label { /* Labels in forms and modals */
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
            font-size: 0.95em;
        }

        .form-container input[type="text"],
        .form-container textarea,
        .modal-content input[type="text"],
        .modal-content textarea {
            width: calc(100% - 20px); /* Account for padding */
            padding: 10px;
            margin-bottom: 18px; /* Consistent margin */
            border: 1px solid #ddd;
            border-radius: 6px; /* Slightly more rounded corners */
            box-sizing: border-box;
            font-size: 1em;
        }
        .form-container textarea,
        .modal-content textarea {
            resize: vertical;
            min-height: 100px; /* Minimum height for textareas */
        }


        /* --- Action Buttons (General) --- */
        .action-button-primary {
            background-color: #007bff; /* Primary blue for main action */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            display: inline-block;
            margin-bottom: 30px;
            transition: background-color 0.3s ease, transform 0.1s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .action-button-primary:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        .action-button-primary:active {
            transform: translateY(0);
        }

        .submit-btn { /* For form submission buttons (e.g., in modals or add forms) */
            background-color: #28a745; /* Green for submit/add */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            transition: background-color 0.3s ease, transform 0.1s ease;
        }

        .submit-btn:hover {
            background-color: #218838;
            transform: translateY(-1px);
        }
        .submit-btn:active {
            transform: translateY(0);
        }


        /* --- Content Card Specific Styles --- */
        .card-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .content-card {
            display: flex;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
            padding: 20px;
            gap: 20px;
            align-items: center;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .content-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .content-card img {
            width: 160px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            background-color: #e5e7eb;
            flex-shrink: 0;
        }

        .card-details {
            flex: 1;
        }

        .card-details h4 {
            font-size: 20px;
            color: #1e3a8a;
            margin-bottom: 8px;
        }

        .card-details p {
            margin: 4px 0;
            font-size: 14px;
            color: #555;
        }

        .card-details p strong {
            color: #333;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            margin-left: 5px;
            text-transform: uppercase;
        }

        /* Specific Status Colors (Content) */
        .status-draft { background-color: #fca5a5; color: #dc2626; } /* Red for Draft */
        .status-pending { background-color: #fcd34d; color: #a16207; } /* Yellow for Pending */
        .status-published { background-color: #a7f3d0; color: #065f46; } /* Green for Published */
        .status-unpublished { background-color: #bfdbfe; color: #1e40af; } /* Blue for Unpublished */


        .action-buttons {
            margin-top: 15px;
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 9px 18px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            font-size: 14px;
            transition: background-color 0.2s ease, transform 0.1s ease;
        }

        .action-btn:active {
            transform: translateY(1px);
        }

        .edit-btn {
            background: #3b82f6;
            color: white;
        }

        .edit-btn:hover {
            background: #1e40af;
        }

        .delete-btn {
            background: #ef4444;
            color: white;
        }

        .delete-btn:hover {
            background: #b91c1c;
        }

        .preview-btn {
            background: #6b7280; /* Gray for Preview */
            color: white;
        }

        .preview-btn:hover {
            background: #4b5563;
        }

        /* --- Table Styles (for Industry Data & Search/Verify) --- */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            border-radius: 8px;
            overflow: hidden; /* Ensures rounded corners on table elements */
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        thead th {
            background-color: #e0e7ff; /* Light blue header */
            color: #1e3a8a;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 0.9em;
        }

        tbody tr:nth-child(even) {
            background-color: #f8faff; /* Lighter background for even rows */
        }

        tbody tr:hover {
            background-color: #eef2ff; /* Hover effect for rows */
        }

        /* Adjust action buttons in tables */
        table .action-btn {
            padding: 6px 12px;
            font-size: 0.85em;
            margin-right: 5px; /* Space between table buttons */
        }

        /* --- Category List (Drag and Drop) Styles --- */
        .category-list {
            list-style: none;
            padding: 0;
            margin: 0;
            /* background-color: #fff; */ /* Handled by parent base-card */
            /* border-radius: 12px; */ /* Handled by parent base-card */
            /* box-shadow: 0 2px 8px rgba(0,0,0,0.08); */ /* Handled by parent base-card */
            overflow: hidden; /* Ensures rounded corners apply to children */
        }

        .category-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 25px;
            border-bottom: 1px solid #eee;
            background-color: #fff;
            cursor: grab; /* Indicates draggable */
            transition: background-color 0.2s ease, transform 0.1s ease, box-shadow 0.2s ease;
        }

        .category-item:last-child {
            border-bottom: none; /* No border for the last item */
        }

        .category-item:hover {
            background-color: #f9f9f9;
        }

        .category-item.dragging {
            opacity: 0.7;
            background-color: #e6f7ff;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
            transform: translateY(-3px);
        }

        .category-item-info {
            display: flex;
            align-items: center;
            flex-grow: 1; /* Allows info to take available space */
        }

        .category-item-info .handle {
            margin-right: 15px;
            color: #ccc;
            font-size: 1.2em;
            cursor: grab;
        }
        .category-item-info .handle:active {
            cursor: grabbing;
        }

        .category-item-info .category-name {
            font-weight: bold;
            color: #333;
            font-size: 1.1em;
            flex-shrink: 0; /* Prevent name from shrinking too much */
        }

        .category-item-description {
             color: #666;
             font-size: 0.95em;
             margin-left: 20px; /* Space between name and description */
             flex-grow: 1;
             overflow: hidden;
             text-overflow: ellipsis;
             white-space: nowrap; /* Keep description on one line */
             max-width: 300px; /* Limit description width */
        }

        .category-item-actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0; /* Prevent actions from shrinking */
        }

        /* Specific styles for category action buttons (aligned with main action-btn) */
        .category-item-actions .action-btn {
            padding: 8px 15px; /* Adjust padding for smaller category buttons */
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: bold; /* Use bold for consistency */
            font-size: 0.9em; /* Slightly smaller font for category buttons */
            transition: background-color 0.2s ease, transform 0.1s ease;
        }
        .category-item-actions .edit-btn { background-color: #ffc107; color: #333; }
        .category-item-actions .edit-btn:hover { background-color: #e0a800; }
        .category-item-actions .delete-btn { background-color: #dc3545; color: white; }
        .category-item-actions .delete-btn:hover { background-color: #c82333; }


        /* --- Modal (Popup) Styles (Unified) --- */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.5); /* Darker overlay */
            display: flex; /* Use flex to center */
            justify-content: center;
            align-items: center;
            animation: fadeInOverlay 0.3s ease-out;
        }

        .modal-content {
            background-color: #fefefe;
            padding: 30px;
            border: 1px solid #ccc;
            border-radius: 12px;
            width: 90%;
            max-width: 550px; /* Adjusted for category form */
            box-shadow: 0 8px 25px rgba(0,0,0,0.25);
            position: relative;
            animation: fadeInScale 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .close-button {
            color: #888;
            font-size: 32px;
            font-weight: normal;
            position: absolute;
            top: 10px;
            right: 20px;
            cursor: pointer;
            transition: color 0.2s ease;
        }

        .close-button:hover,
        .close-button:focus {
            color: #333;
            text-decoration: none;
        }


        /* Animations */
        @keyframes fadeInOverlay {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes fadeInScale {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }

        /* Responsive adjustments */
        @media (max-width: 992px) {
            .category-item-description {
                max-width: 200px; /* Adjust for smaller screens */
            }
        }

        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            h2 {
                font-size: 1.8em;
            }
            h3 {
                font-size: 1.4em;
            }
            h4 {
                font-size: 1.2em;
            }
            .content-card {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            .content-card img {
                width: 100%;
                height: 150px;
            }
            .action-buttons {
                flex-wrap: wrap;
                justify-content: flex-start;
            }
            .action-btn {
                width: auto; /* Allow buttons to size naturally */
                flex-grow: 1; /* Allow them to grow */
            }

            .category-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
                padding: 15px;
            }
            .category-item-info {
                width: 100%;
            }
            .category-item-description {
                margin-left: 0;
                white-space: normal; /* Allow description to wrap */
                max-width: none;
            }
            .category-item-actions {
                width: 100%;
                justify-content: flex-end;
            }
            table, thead, tbody, th, td, tr {
                display: block; /* Make table responsive by stacking */
            }
            thead tr {
                position: absolute;
                top: -9999px;
                left: -9999px;
            }
            tr { border: 1px solid #f0f0f0; margin-bottom: 10px; border-radius: 8px; }
            td {
                border: none;
                border-bottom: 1px solid #eee;
                position: relative;
                padding-left: 50%; /* Space for pseudo-element label */
                text-align: right;
            }
            td:before {
                position: absolute;
                left: 6px;
                width: 45%;
                padding-right: 10px;
                white-space: nowrap;
                text-align: left;
                font-weight: bold;
                color: #444;
            }
            /* Data-title attributes for responsive tables */
            td:nth-of-type(1):before { content: "ID:"; }
            td:nth-of-type(2):before { content: "Tên:"; }
            td:nth-of-type(3):before { content: "Mô tả:"; }
            td:nth-of-type(4):before { content: "Hành động:"; }
            /* For industry data table: */
            /* The generic rules above will conflict with specific ones.
               If you want specific labels for different tables, you'd need to use
               more specific selectors or data-label attributes in HTML.
               For now, the generic ones will apply.
            */
            /* For search & verify table: */
            /* td:nth-of-type(2):before { content: "Tên:"; } // Overridden by generic ID label
            td:nth-of-type(3):before { content: "Email:"; }
            td:nth-of-type(4):before { content: "Trạng thái xác minh:"; } */
        }

        @media (max-width: 480px) {
            .base-card, .form-container, .modal-content {
                padding: 15px;
            }
            .action-button-primary {
                width: 100%;
                text-align: center;
                padding: 10px 20px;
            }
            .submit-btn {
                width: 100%;
                padding: 10px 20px;
            }
             .modal-content input[type="text"],
             .modal-content textarea {
                 width: calc(100% - 10px); /* Adjust for smaller padding */
                 padding: 8px;
             }
        }
    </style>
</head>
<body>

<h2>Quản lý Nội dung & Dữ liệu</h2>

<section id="manage-content">
    <h3>Quản lý Nội dung</h3>
    <div class="card-list">
        <div class="content-card">
            <img src="https://via.placeholder.com/160x100.png?text=Thumb+1" alt="Thumbnail">
            <div class="card-details">
                <h4>Tuyển dụng tháng 6</h4>
                <p><strong>Danh mục:</strong> Tuyển dụng</p>
                <p><strong>Ngày đăng:</strong> 2025-06-01</p>
                <p><strong>Người đăng:</strong> Nguyễn Văn A</p>
                <p><strong>Trạng thái:</strong> <span class="status-badge status-published">Đã xuất bản</span></p>
                <p><strong>Lượt xem:</strong> 1250</p>
                <div class="action-buttons">
                    <button class="action-btn preview-btn">Xem trước</button>
                    <button class="action-btn edit-btn">Sửa</button>
                    <button class="action-btn delete-btn">Xóa</button>
                </div>
            </div>
        </div>

        <div class="content-card">
            <img src="https://via.placeholder.com/160x100.png?text=Thumb+2" alt="Thumbnail">
            <div class="card-details">
                <h4>5 Lợi ích khi làm việc tại công ty X</h4>
                <p><strong>Danh mục:</strong> Văn hóa doanh nghiệp</p>
                <p><strong>Ngày tạo:</strong> 2025-06-10</p>
                <p><strong>Người đăng:</strong> Trần Thị B</p>
                <p><strong>Trạng thái:</strong> <span class="status-badge status-draft">Bản nháp</span></p>
                <p><strong>Lượt xem:</strong> 0</p>
                <div class="action-buttons">
                    <button class="action-btn preview-btn">Xem trước</button>
                    <button class="action-btn edit-btn">Sửa</button>
                    <button class="action-btn delete-btn">Xóa</button>
                </div>
            </div>
        </div>

        <div class="content-card">
            <img src="https://via.placeholder.com/160x100.png?text=Thumb+3" alt="Thumbnail">
            <div class="card-details">
                <h4>Quy trình tuyển dụng mới 2025</h4>
                <p><strong>Danh mục:</strong> Thông báo nội bộ</p>
                <p><strong>Ngày tạo:</strong> 2025-06-12</p>
                <p><strong>Người đăng:</strong> Lê Văn C</p>
                <p><strong>Trạng thái:</strong> <span class="status-badge status-pending">Chờ duyệt</span></p>
                <p><strong>Lượt xem:</strong> 0</p>
                <div class="action-buttons">
                    <button class="action-btn preview-btn">Xem trước</button>
                    <button class="action-btn edit-btn">Sửa</button>
                    <button class="action-btn delete-btn">Xóa</button>
                </div>
            </div>
        </div>

    </div>
</section>

<section id="industry-data">
    <h3>Dữ liệu ngành</h3>
    <div class="form-container">
        <h4>Thêm dữ liệu ngành</h4>
        <label>Tên ngành</label>
        <input type="text" placeholder="Nhập tên ngành..." />
        <label>Mô tả</label>
        <textarea placeholder="Nhập mô tả ngành..." rows="5"></textarea>
        <button class="submit-btn">Thêm ngành</button> <%-- Added submit-btn class --%>
    </div>
    <div class="base-card"> <%-- Wrap table in base-card for consistent styling --%>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên ngành</th>
                    <th>Mô tả</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>I001</td>
                    <td>Công nghệ thông tin</td>
                    <td>Ngành phát triển phần mềm và dịch vụ công nghệ</td>
                    <td>
                        <button class="action-btn edit-btn">Sửa</button>
                        <button class="action-btn delete-btn">Xóa</button>
                    </td>
                </tr>
                <tr>
                    <td>I002</td>
                    <td>Tài chính - Ngân hàng</td>
                    <td>Các hoạt động liên quan đến tài chính, ngân hàng và đầu tư</td>
                    <td>
                        <button class="action-btn edit-btn">Sửa</button>
                        <button class="action-btn delete-btn">Xóa</button>
                    </td>
                </tr>
                <tr>
                    <td>I003</td>
                    <td>Y tế - Dược phẩm</td>
                    <td>Các vị trí trong lĩnh vực y tế, bệnh viện, và công nghiệp dược phẩm</td>
                    <td>
                        <button class="action-btn edit-btn">Sửa</button>
                        <button class="action-btn delete-btn">Xóa</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</section>

<section id="categories">
    <h3>Quản lý Danh mục</h3>

    <button class="action-button-primary" onclick="openCategoryModal()">+ Tạo danh mục mới</button>

    <div class="base-card">
        <h4>Danh sách Danh mục</h4>
        <ul class="category-list" id="sortable-category-list">
            <li class="category-item" draggable="true" data-id="cat1">
                <div class="category-item-info">
                    <span class="handle"><i class="fas fa-grip-lines"></i></span>
                    <span class="category-name">Thiết kế UI/UX</span>
                    <span class="category-item-description">Danh mục cho các vị trí thiết kế giao diện người dùng và trải nghiệm người dùng.</span>
                </div>
                <div class="category-item-actions">
                    <button class="action-btn edit-btn" onclick="editCategory('cat1', 'Thiết kế UI/UX', 'Danh mục cho các vị trí thiết kế giao diện người dùng và trải nghiệm người dùng.')">Sửa</button>
                    <button class="action-btn delete-btn" onclick="deleteCategory('cat1')">Xóa</button>
                </div>
            </li>
            <li class="category-item" draggable="true" data-id="cat2">
                <div class="category-item-info">
                    <span class="handle"><i class="fas fa-grip-lines"></i></span>
                    <span class="category-name">Lập trình Frontend</span>
                    <span class="category-item-description">Các vị trí phát triển giao diện người dùng web và di động.</span>
                </div>
                <div class="category-item-actions">
                    <button class="action-btn edit-btn" onclick="editCategory('cat2', 'Lập trình Frontend', 'Các vị trí phát triển giao diện người dùng web và di động.')">Sửa</button>
                    <button class="action-btn delete-btn" onclick="deleteCategory('cat2')">Xóa</button>
                </div>
            </li>
            <li class="category-item" draggable="true" data-id="cat3">
                <div class="category-item-info">
                    <span class="handle"><i class="fas fa-grip-lines"></i></span>
                    <span class="category-name">Lập trình Backend</span>
                    <span class="category-item-description">Các vị trí phát triển hệ thống phía server, API và cơ sở dữ liệu.</span>
                </div>
                <div class="category-item-actions">
                    <button class="action-btn edit-btn" onclick="editCategory('cat3', 'Lập trình Backend', 'Các vị trí phát triển hệ thống phía server, API và cơ sở dữ liệu.')">Sửa</button>
                    <button class="action-btn delete-btn" onclick="deleteCategory('cat3')">Xóa</button>
                </div>
            </li>
            <li class="category-item" draggable="true" data-id="cat4">
                <div class="category-item-info">
                    <span class="handle"><i class="fas fa-grip-lines"></i></span>
                    <span class="category-name">Quản lý Dự án</span>
                    <span class="category-item-description">Dành cho các vị trí quản lý, điều phối và giám sát dự án công nghệ.</span>
                </div>
                <div class="category-item-actions">
                    <button class="action-btn edit-btn" onclick="editCategory('cat4', 'Quản lý Dự án', 'Dành cho các vị trí quản lý, điều phối và giám sát dự án công nghệ.')">Sửa</button>
                    <button class="action-btn delete-btn" onclick="deleteCategory('cat4')">Xóa</button>
                </div>
            </li>
            <li class="category-item" draggable="true" data-id="cat5">
                <div class="category-item-info">
                    <span class="handle"><i class="fas fa-grip-lines"></i></span>
                    <span class="category-name">Kiểm thử phần mềm</span>
                    <span class="category-item-description">Tuyển dụng các chuyên viên kiểm thử chất lượng phần mềm, QA/QC.</span>
                </div>
                <div class="category-item-actions">
                    <button class="action-btn edit-btn" onclick="editCategory('cat5', 'Kiểm thử phần mềm', 'Tuyển dụng các chuyên viên kiểm thử chất lượng phần mềm, QA/QC.')">Sửa</button>
                    <button class="action-btn delete-btn" onclick="deleteCategory('cat5')">Xóa</button>
                </div>
            </li>
        </ul>
        <button class="action-button-primary" style="margin-top: 20px; float: right;" onclick="saveCategoryOrder()">Lưu thứ tự</button>
        <div class="clear-float"></div>
    </div>
</section>

<section id="search-verify">
    <h3>Tìm & xác minh</h3>
    <div class="form-container">
        <h4>Tìm kiếm người dùng</h4>
        <label>Email hoặc Tên</label>
        <input type="text" placeholder="Nhập email hoặc tên..." />
        <button class="submit-btn">Tìm kiếm</button> <%-- Added submit-btn class --%>
    </div>
    <div class="base-card"> <%-- Wrap table in base-card for consistent styling --%>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>Email</th>
                    <th>Trạng thái xác minh</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1001</td>
                    <td>Nguyễn Văn A</td>
                    <td>nguyenvana@mail.com</td>
                    <td>Đã xác minh</td>
                    <td>
                        <button class="action-btn edit-btn">Xem</button>
                        <button class="action-btn delete-btn">Hủy xác minh</button>
                    </td>
                </tr>
                 <tr>
                    <td>1002</td>
                    <td>Trần Thị B</td>
                    <td>tranthib@mail.com</td>
                    <td>Chưa xác minh</td>
                    <td>
                        <button class="action-btn edit-btn">Xem</button>
                        <button class="action-btn submit-btn" style="background-color: #1a73e8;">Xác minh</button> <%-- Custom color for verify --%>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</section>

<div id="categoryModal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeCategoryModal()">&times;</span>
        <h4 id="modalTitle">Tạo danh mục mới</h4>
        <label for="categoryName">Tên danh mục</label>
        <input type="text" id="categoryName" placeholder="Nhập tên danh mục..." />
        <label for="categoryDescription">Mô tả</label>
        <textarea id="categoryDescription" placeholder="Nhập mô tả danh mục..." rows="5"></textarea>
        <input type="hidden" id="categoryId" value="" /> <%-- Hidden input for category ID when editing --%>
        <button class="submit-btn" onclick="saveCategory()">Lưu danh mục</button>
    </div>
</div>


<script>
    // --- Modal Functions (for Category) ---
    const categoryModal = document.getElementById('categoryModal');
    const modalTitle = document.getElementById('modalTitle');
    const categoryNameInput = document.getElementById('categoryName');
    const categoryDescriptionInput = document.getElementById('categoryDescription');
    const categoryIdInput = document.getElementById('categoryId');
    const sortableList = document.getElementById('sortable-category-list');


    function openCategoryModal() {
        modalTitle.textContent = 'Tạo danh mục mới';
        categoryNameInput.value = '';
        categoryDescriptionInput.value = '';
        categoryIdInput.value = ''; // Clear ID for new category
        categoryModal.style.display = 'flex';
    }

    function editCategory(id, name, description) {
        modalTitle.textContent = 'Sửa danh mục';
        categoryNameInput.value = name;
        categoryDescriptionInput.value = description;
        categoryIdInput.value = id; // Set ID for editing
        categoryModal.style.display = 'flex';
    }

    function closeCategoryModal() {
        categoryModal.style.display = 'none';
    }

    // Close the modal if the user clicks outside of it
    window.onclick = function(event) {
        if (event.target == categoryModal) {
            closeCategoryModal();
        }
    }

    function saveCategory() {
        const id = categoryIdInput.value;
        const name = categoryNameInput.value.trim();
        const description = categoryDescriptionInput.value.trim();

        if (name === '') {
            alert('Tên danh mục không được để trống!');
            return;
        }

        if (id) {
            // Logic to update existing category (e.g., via AJAX to your servlet)
            console.log(`Cập nhật danh mục ID: ${id}, Tên: ${name}, Mô tả: ${description}`);
            alert(`Đã cập nhật danh mục: ${name}`);
            // Find the item in the list and update its name and description
            const itemToUpdate = document.querySelector(`#sortable-category-list .category-item[data-id="${id}"]`);
            if (itemToUpdate) {
                itemToUpdate.querySelector('.category-name').textContent = name;
                itemToUpdate.querySelector('.category-item-description').textContent = description;
                // Update onclick attributes to reflect new name/description
                itemToUpdate.querySelector('.edit-btn').setAttribute('onclick', `editCategory('${id}', '${name}', '${description}')`);
            }
        } else {
            // Logic to create new category (e.g., via AJAX to your servlet)
            const newId = `cat${Date.now()}`; // Simple unique ID for demo
            console.log(`Tạo danh mục mới: ${name} (ID: ${newId}), Mô tả: ${description}`);
            alert(`Đã tạo danh mục mới: ${name}`);

            // Create new list item HTML
            const newItemHtml = `
                <li class="category-item" draggable="true" data-id="${newId}">
                    <div class="category-item-info">
                        <span class="handle"><i class="fas fa-grip-lines"></i></span>
                        <span class="category-name">${name}</span>
                        <span class="category-item-description">${description}</span>
                    </div>
                    <div class="category-item-actions">
                        <button class="action-btn edit-btn" onclick="editCategory('${newId}', '${name}', '${description}')">Sửa</button>
                        <button class="action-btn delete-btn" onclick="deleteCategory('${newId}')">Xóa</button>
                    </div>
                </li>
            `;

            // Append new item to the list
            sortableList.insertAdjacentHTML('beforeend', newItemHtml);

            // Get the newly created element and add drag and drop listeners to it
            const newItem = sortableList.lastElementChild;
            addDragAndDropListeners(newItem);
        }
        closeCategoryModal(); // Close modal after saving
    }

    function deleteCategory(id) {
        if (confirm('Bạn có chắc chắn muốn xóa danh mục này không?')) {
            // Logic to delete category (e.g., via AJAX to your servlet)
            console.log(`Xóa danh mục ID: ${id}`);
            alert(`Đã xóa danh mục ID: ${id}`);
            // Remove the item from the DOM
            const itemToDelete = document.querySelector(`#sortable-category-list .category-item[data-id="${id}"]`);
            if (itemToDelete) {
                itemToDelete.remove();
            }
        }
    }

    function saveCategoryOrder() {
        const categoryOrder = [];
        document.querySelectorAll('#sortable-category-list .category-item').forEach(item => {
            categoryOrder.push(item.dataset.id);
        });
        console.log('Thứ tự danh mục đã lưu:', categoryOrder);
        alert('Thứ tự danh mục đã được lưu!');
        // Here you would typically send `categoryOrder` to your server via AJAX
        // for example: fetch('/api/saveCategoryOrder', { method: 'POST', body: JSON.stringify(categoryOrder) });
    }


    // --- Drag and Drop Logic for Categories ---
    let draggedItem = null;

    function addDragAndDropListeners(item) {
        item.addEventListener('dragstart', () => {
            draggedItem = item;
            setTimeout(() => {
                item.classList.add('dragging');
            }, 0);
        });

        item.addEventListener('dragend', () => {
            draggedItem.classList.remove('dragging');
            draggedItem = null;
        });
    }

    // Add drag and drop listeners to existing items on page load
    document.querySelectorAll('.category-item').forEach(item => {
        addDragAndDropListeners(item);
    });

    sortableList.addEventListener('dragover', (e) => {
        e.preventDefault(); // Crucial to allow dropping
        const afterElement = getDragAfterElement(sortableList, e.clientY);
        const draggable = document.querySelector('.dragging');
        if (draggable) { // Ensure there is an item being dragged
            if (afterElement == null) {
                sortableList.appendChild(draggable);
            } else {
                sortableList.insertBefore(draggable, afterElement);
            }
        }
    });

    function getDragAfterElement(container, y) {
        const draggableElements = [...container.querySelectorAll('.category-item:not(.dragging)')];

        return draggableElements.reduce((closest, child) => {
            const box = child.getBoundingClientRect();
            const offset = y - box.top - box.height / 2;
            if (offset < 0 && offset > closest.offset) {
                return { offset: offset, element: child };
            } else {
                return closest;
            }
        }, { offset: -Infinity }).element;
    }

</script>

</body>
</html>