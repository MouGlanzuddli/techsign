<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User tempUser = (User) session.getAttribute("tempUser");
    if (tempUser == null) {
        response.sendRedirect("index.jsp?error=session_expired");
        return;
    }
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Select Your Role - TechSign</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/img/favicon.png">
    <link href="${pageContext.request.contextPath}/assets/css/styles.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/colors.css" rel="stylesheet">
</head>

<body class="green-theme">
    <div id="main-wrapper">
        <!-- Navigation -->
        <div class="header header-transparent change-logo">
            <div class="container">
                <nav id="navigation" class="navigation navigation-landscape">
                    <div class="nav-header">
                        <a class="nav-brand static-logo" href="index.jsp">
                            <img src="${pageContext.request.contextPath}/assets/img/logo-light.png" class="logo" alt="">
                        </a>
                        <a class="nav-brand fixed-logo" href="index.jsp">
                            <img src="${pageContext.request.contextPath}/assets/img/logo.png" class="logo" alt="">
                        </a>
                    </div>
                </nav>
            </div>
        </div>

        <!-- Role Selection Section -->
        <section class="min-vh-100 d-flex align-items-center primary-bg-dark">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-8 col-md-10">
                        <div class="card border-0 shadow-lg">
                            <div class="card-body p-5">
                                <div class="text-center mb-4">
                                    <div class="mb-3">
                                        <img src="<%= tempUser.getAvatarUrl() %>" class="rounded-circle" width="80" height="80" alt="Profile">
                                    </div>
                                    <h3 class="mb-2">Welcome, <%= tempUser.getFullName() %>!</h3>
                                    <p class="text-muted">Please select your role to continue</p>
                                </div>

                                <% if (request.getParameter("error") != null) { %>
                                    <div class="alert alert-danger text-center">
                                        <% 
                                            String error = request.getParameter("error");
                                            String details = request.getParameter("details");
                                            if ("please_select_role".equals(error)) {
                                                out.print("Please select a role to continue.");
                                            } else if ("invalid_role".equals(error)) {
                                                out.print("Invalid role selected. Please try again.");
                                            } else if ("update_failed".equals(error)) {
                                                out.print("Failed to update your profile. Please try again.");
                                            } else if ("internal_error".equals(error)) {
                                                out.print("An internal error occurred. Please try again.");
                                                if (details != null) {
                                                    out.print("<br><small>Details: " + details + "</small>");
                                                }
                                            }
                                        %>
                                    </div>
                                <% } %>

                                <form action="${pageContext.request.contextPath}/RoleSelectionServlet" method="POST">
                                    <div class="row g-4">
                                        <!-- Candidate Option -->
                                        <div class="col-md-6">
                                            <div class="role-option">
                                                <input type="radio" class="btn-check" name="role" id="candidate" value="candidate" required>
                                                <label class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4" for="candidate">
                                                    <i class="fas fa-user fa-3x mb-3"></i>
                                                    <h5 class="mb-2">I'm a Candidate</h5>
                                                    <p class="text-muted small mb-0">Looking for job opportunities</p>
                                                </label>
                                            </div>
                                        </div>

                                        <!-- Company Option -->
                                        <div class="col-md-6">
                                            <div class="role-option">
                                                <input type="radio" class="btn-check" name="role" id="company" value="company" required>
                                                <label class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4" for="company">
                                                    <i class="fas fa-building fa-3x mb-3"></i>
                                                    <h5 class="mb-2">I'm a Company</h5>
                                                    <p class="text-muted small mb-0">Looking to hire talent</p>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn btn-primary btn-lg px-5">
                                            Continue <i class="fas fa-arrow-right ms-2"></i>
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Scripts -->
    <script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    
    <style>
        .role-option label {
            min-height: 200px;
            transition: all 0.3s ease;
            border: 2px solid #e9ecef;
        }
        
        .role-option label:hover {
            border-color: #007bff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,123,255,0.15);
        }
        
        .role-option input[type="radio"]:checked + label {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }
        
        .role-option input[type="radio"]:checked + label .text-muted {
            color: rgba(255,255,255,0.8) !important;
        }
    </style>
</body>
</html>
