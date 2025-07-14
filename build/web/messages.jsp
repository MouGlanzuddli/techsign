<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Messages - TechSign</title>
    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <style>
        .chat-container {
            display: flex;
            height: calc(100vh - 180px); /* Adjust based on header/footer height */
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 20px;
            margin-bottom: 20px;
        }
        .conversation-list {
            width: 300px;
            border-right: 1px solid #e0e0e0;
            overflow-y: auto;
            background-color: #f8f9fa;
        }
        .conversation-item {
            padding: 15px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .conversation-item:hover {
            background-color: #e9ecef;
        }
        .conversation-item.active {
            background-color: #e2e6ea;
            font-weight: bold;
        }
        .conversation-item img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        .conversation-info {
            flex-grow: 1;
        }
        .conversation-info .name {
            font-size: 1.1em;
            color: #333;
        }
        .conversation-info .last-message {
            font-size: 0.9em;
            color: #666;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .conversation-info .unread-count {
            background-color: #007bff;
            color: white;
            border-radius: 50%;
            padding: 2px 7px;
            font-size: 0.75em;
            margin-left: auto;
        }
        .chat-window {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .chat-header {
            padding: 15px;
            border-bottom: 1px solid #e0e0e0;
            background-color: #f1f1f1;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .chat-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        .chat-header .name {
            font-size: 1.2em;
            font-weight: bold;
        }
        .message-area {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            background-color: #fff;
        }
        .message {
            display: flex;
            margin-bottom: 15px;
        }
        .message.sent {
            justify-content: flex-end;
        }
        .message.received {
            justify-content: flex-start;
        }
        .message-bubble {
            max-width: 70%;
            padding: 10px 15px;
            border-radius: 20px;
            line-height: 1.4;
            word-wrap: break-word;
        }
        .message.sent .message-bubble {
            background-color: #007bff;
            color: white;
            border-bottom-right-radius: 5px;
        }
        .message.received .message-bubble {
            background-color: #e9ecef;
            color: #333;
            border-bottom-left-radius: 5px;
        }
        .message-time {
            font-size: 0.75em;
            color: #999;
            margin-top: 5px;
            text-align: right;
        }
        .message.received .message-time {
            text-align: left;
        }
        .message-input-area {
            padding: 15px;
            border-top: 1px solid #e0e0e0;
            background-color: #f1f1f1;
            display: flex;
            gap: 10px;
        }
        .message-input-area input {
            flex-grow: 1;
            border-radius: 20px;
            padding: 10px 15px;
            border: 1px solid #ccc;
        }
        .message-input-area button {
            border-radius: 20px;
            padding: 10px 20px;
        }
        .no-conversation-selected {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
            color: #6c757d;
            font-size: 1.2em;
        }
    </style>
</head>
<body>
    <div class="container-xxl bg-white p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
            <a href="${pageContext.request.contextPath}/index.jsp" class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5">
                <h1 class="m-0 text-primary">TechSign</h1>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="nav-item nav-link">Home</a>
                    <a href="${pageContext.request.contextPath}/job-list" class="nav-item nav-link">Jobs</a>
                    <a href="${pageContext.request.contextPath}/messages" class="nav-item nav-link active">Messages</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                        <div class="dropdown-menu rounded-0 m-0">
                            <a href="category.html" class="dropdown-item">Job Category</a>
                            <a href="testimonial.html" class="dropdown-item">Testimonial</a>
                            <a href="404.html" class="dropdown-item">404 Page</a>
                        </div>
                    </div>
                    <a href="contact.html" class="nav-item nav-link">Contact</a>
                </div>
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <div class="nav-item dropdown">
                            <a href="#" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block dropdown-toggle" data-bs-toggle="dropdown">
                                Welcome, ${sessionScope.user.fullName}
                            </a>
                            <div class="dropdown-menu rounded-0 m-0">
                                <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">Profile</a>
                                <a href="${pageContext.request.contextPath}/my-jobs" class="dropdown-item">My Jobs</a>
                                <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Login<i class="fa fa-arrow-right ms-3"></i></a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>
        <!-- Navbar End -->

        <!-- Header End -->
        <div class="container-xxl py-5 bg-dark page-header mb-5">
            <div class="container my-5 pb-4">
                <h1 class="display-3 text-white mb-3 animated slideInDown">Messages</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb text-uppercase">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                        <li class="breadcrumb-item text-white active" aria-current="page">Messages</li>
                    </ol>
                </nav>
            </div>
        </div>
        <!-- Header End -->

        <!-- Messages Section Start -->
        <div class="container">
            <div class="chat-container">
                <div class="conversation-list">
                    <div class="p-3 border-bottom">
                        <h5 class="mb-0">Conversations</h5>
                    </div>
                    <c:if test="${empty conversations}">
                        <div class="p-3 text-center text-muted">No conversations yet.</div>
                    </c:if>
                    <c:forEach var="conv" items="${conversations}">
                        <c:set var="otherParticipant" value="${conv.participant1Id == sessionScope.user.id ? conv.participant2 : conv.participant1}" />
                        <a href="${pageContext.request.contextPath}/messages?id=${conv.id}" class="conversation-item <c:if test="${currentConversation != null && currentConversation.id == conv.id}">active</c:if>">
                            <img src="${otherParticipant.avatarUrl != null && !otherParticipant.avatarUrl.isEmpty() ? otherParticipant.avatarUrl : 'img/user.jpg'}" alt="Avatar">
                            <div class="conversation-info">
                                <div class="name">${otherParticipant.fullName}</div>
                                <div class="last-message">
                                    <c:if test="${conv.lastMessage != null}">
                                        <c:if test="${conv.lastMessage.senderId == sessionScope.user.id}">You: </c:if>
                                        ${conv.lastMessage.content}
                                    </c:if>
                                    <c:if test="${conv.lastMessage == null}">
                                        <em>No messages yet.</em>
                                    </c:if>
                                </div>
                            </div>
                            <c:if test="${conv.unreadCount > 0}">
                                <span class="unread-count">${conv.unreadCount}</span>
                            </c:if>
                        </a>
                    </c:forEach>
                </div>

                <div class="chat-window">
                    <c:if test="${currentConversation != null}">
                        <div class="chat-header">
                            <img src="${recipientUser.avatarUrl != null && !recipientUser.avatarUrl.isEmpty() ? recipientUser.avatarUrl : 'img/user.jpg'}" alt="Avatar">
                            <div class="name">${recipientUser.fullName}</div>
                        </div>
                        <div class="message-area" id="messageArea">
                            <c:if test="${empty messages}">
                                <div class="text-center text-muted mt-5">Start a conversation!</div>
                            </c:if>
                            <c:forEach var="msg" items="${messages}">
                                <div class="message <c:if test="${msg.senderId == sessionScope.user.id}">sent</c:if><c:if test="${msg.senderId != sessionScope.user.id}">received</c:if>">
                                    <div class="message-bubble">
                                        ${msg.content}
                                        <div class="message-time">
                                            <fmt:formatDate value="${msg.sentAt}" pattern="HH:mm dd/MM" />
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="message-input-area">
                            <form action="${pageContext.request.contextPath}/messages" method="post" style="display: flex; width: 100%; gap: 10px;">
                                <input type="hidden" name="conversationId" value="${currentConversation.id}">
                                <input type="text" name="messageContent" placeholder="Type your message..." required>
                                <button type="submit" class="btn btn-primary">Send</button>
                            </form>
                        </div>
                    </c:if>
                    <c:if test="${currentConversation == null}">
                        <div class="no-conversation-selected">
                            Select a conversation or start a new one.
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        <!-- Messages Section End -->

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5 wow fadeIn" data-wow-delay="0.1s">
            <div class="container py-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Company</h5>
                        <a class="btn btn-link text-white-50" href="">About Us</a>
                        <a class="btn btn-link text-white-50" href="">Contact Us</a>
                        <a class="btn btn-link text-white-50" href="">Our Services</a>
                        <a class="btn btn-link text-white-50" href="">Privacy Policy</a>
                        <a class="btn btn-link text-white-50" href="">Terms & Condition</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Quick Links</h5>
                        <a class="btn btn-link text-white-50" href="">About Us</a>
                        <a class="btn btn-link text-white-50" href="">Contact Us</a>
                        <a class="btn btn-link text-white-50" href="">Our Services</a>
                        <a class="btn btn-link text-white-50" href="">Privacy Policy</a>
                        <a class="btn btn-link text-white-50" href="">Terms & Condition</a>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Contact</h5>
                        <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                        <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                        <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                        <div class="d-flex pt-2">
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                            <a class="btn btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-white mb-4">Newsletter</h5>
                        <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                        <div class="position-relative mx-auto" style="max-width: 400px;">
                            <input class="form-control bg-transparent w-100 py-3 ps-4 pe-5" type="text" placeholder="Your Email">
                            <button type="button" class="btn btn-primary py-2 px-3 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="copyright">
                    <div class="row">
                        <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                            &copy; <a class="border-bottom" href="#">Your Site Name</a>, All Right Reserved. 
							
							<!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
							Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                        </div>
                        <div class="col-md-6 text-center text-md-end">
                            <div class="footer-menu">
                                <a href="">Home</a>
                                <a href="">Cookies</a>
                                <a href="">Help</a>
                                <a href="">FQAs</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>

    <script>
        // Scroll to the bottom of the message area when loaded or new message sent
        function scrollToBottom() {
            var messageArea = document.getElementById('messageArea');
            if (messageArea) {
                messageArea.scrollTop = messageArea.scrollHeight;
            }
        }
        window.onload = scrollToBottom;
        // You might want to call scrollToBottom() after sending a message via AJAX if you implement that later
    </script>
</body>
</html>
