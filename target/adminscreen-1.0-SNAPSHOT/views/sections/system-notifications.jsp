<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List, java.util.Map, com.mycompany.adminscreen.model.Notification" %>
<%
    List<Notification> pinnedNotifications = (List<Notification>) request.getAttribute("pinnedNotifications");
    if (pinnedNotifications == null) pinnedNotifications = new java.util.ArrayList<>();
    List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
    if (notifications == null) notifications = new java.util.ArrayList<>();
    Map<String, Integer> stats = (Map<String, Integer>) request.getAttribute("stats");
    if (stats == null) stats = new java.util.HashMap<>();
%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<style>
.notification-panel {
  background: linear-gradient(135deg, #e0e7ff 0%, #f0fdfa 100%);
  border-radius: 18px;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
  padding: 32px 24px;
  margin: 32px auto;
  max-width: 800px;
  transition: box-shadow 0.2s;
}
.panel-header {
  display: flex; justify-content: space-between; align-items: center;
}
.panel-header h3 { font-weight: bold; font-size: 1.5rem; margin: 0; }
.btn-toggle-panel { background: none; border: none; font-size: 1.2rem; cursor: pointer; }
.panel-stats { display: flex; gap: 18px; margin: 18px 0 12px 0; flex-wrap: wrap; }
.stat { background: #fff; border-radius: 10px; padding: 10px 18px; font-size: 1rem; display: flex; align-items: center; gap: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); }
.stat.important { color: #e53e3e; }
.stat.new { color: #2563eb; }
.stat.pinned { color: #f59e42; }
.pinned-list, .notification-list { margin-top: 18px; }
.notification { border-radius: 12px; margin-bottom: 16px; box-shadow: 0 2px 8px rgba(0,0,0,0.04); background: #fff; transition: box-shadow 0.2s; }
.notification.pinned { border: 2px solid #f59e42; }
.notif-header { display: flex; align-items: center; justify-content: space-between; padding: 12px 18px; font-weight: 500; }
.notif-header .notif-title { display: flex; align-items: center; gap: 10px; }
.notif-header .notif-type { font-size: 0.95em; border-radius: 6px; padding: 2px 10px; margin-left: 10px; }
.notif-body { padding: 0 18px 14px 54px; color: #444; font-size: 1.05em; }
.btn-pin, .btn-unpin { background: none; border: none; color: #f59e42; font-size: 1.1em; cursor: pointer; margin-left: 8px; }
.btn-unpin { color: #e53e3e; }
/* Type color */
.notification.system .notif-header { color: #2563eb; }
.notification.maintenance .notif-header { color: #f59e42; }
.notification.security .notif-header { color: #e53e3e; }
.notification.update .notif-header { color: #22c55e; }
/* Responsive */
@media (max-width: 600px) {
  .notification-panel { padding: 12px 2vw; }
  .panel-header h3 { font-size: 1.1rem; }
  .panel-stats { flex-direction: column; gap: 8px; }
  .notif-header { flex-direction: column; align-items: flex-start; gap: 4px; }
  .notif-body { padding-left: 18px; font-size: 0.98em; }
}
</style>
<div id="system-notifications">
  <div class="notification-panel" id="notificationPanel">
    <div class="panel-header">
      <h3><i class="fas fa-bell"></i> Thông báo hệ thống</h3>
      <button class="btn btn-toggle-panel" id="togglePanelBtn"><i class="fas fa-chevron-up"></i></button>
    </div>
    <div class="panel-stats">
      <div class="stat"><i class="fas fa-bell"></i> Tổng: <span>${stats.total}</span></div>
      <div class="stat important"><i class="fas fa-shield-alt"></i> Quan trọng: <span>${stats.important}</span></div>
      <div class="stat new"><i class="fas fa-bolt"></i> Mới: <span>${stats['new']}</span></div>
      <div class="stat pinned"><i class="fas fa-thumbtack"></i> Đã ghim: <span>${stats.pinned}</span></div>
    </div>
    <div class="pinned-list">
      <c:forEach var="n" items="${pinnedNotifications}">
        <div class="notification pinned ${n.type}">
          <div class="notif-header">
            <span class="notif-title">
              <i class="fas ${n.type == 'system' ? 'fa-info-circle' : n.type == 'maintenance' ? 'fa-tools' : n.type == 'security' ? 'fa-shield-alt' : 'fa-sync'}"></i>
              <b>${n.title}</b>
              <span class="notif-type" style="background:${n.type == 'system' ? '#e0e7ff' : n.type == 'maintenance' ? '#fff7ed' : n.type == 'security' ? '#fee2e2' : '#dcfce7'};color:${n.type == 'system' ? '#2563eb' : n.type == 'maintenance' ? '#f59e42' : n.type == 'security' ? '#e53e3e' : '#22c55e'};">
                ${n.type == 'system' ? 'Hệ thống' : n.type == 'maintenance' ? 'Bảo trì' : n.type == 'security' ? 'Bảo mật' : 'Cập nhật'}
              </span>
            </span>
            <button class="btn-unpin" data-id="${n.id}" title="Bỏ ghim"><i class="fas fa-times"></i></button>
          </div>
          <div class="notif-body">${n.message}</div>
        </div>
      </c:forEach>
    </div>
    <div class="notification-list">
      <c:forEach var="n" items="${notifications}">
        <div class="notification ${n.type}">
          <div class="notif-header">
            <span class="notif-title">
              <i class="fas ${n.type == 'system' ? 'fa-info-circle' : n.type == 'maintenance' ? 'fa-tools' : n.type == 'security' ? 'fa-shield-alt' : 'fa-sync'}"></i>
              <b>${n.title}</b>
              <span class="notif-type" style="background:${n.type == 'system' ? '#e0e7ff' : n.type == 'maintenance' ? '#fff7ed' : n.type == 'security' ? '#fee2e2' : '#dcfce7'};color:${n.type == 'system' ? '#2563eb' : n.type == 'maintenance' ? '#f59e42' : n.type == 'security' ? '#e53e3e' : '#22c55e'};">
                ${n.type == 'system' ? 'Hệ thống' : n.type == 'maintenance' ? 'Bảo trì' : n.type == 'security' ? 'Bảo mật' : 'Cập nhật'}
              </span>
            </span>
            <button class="btn-pin" data-id="${n.id}" title="Ghim"><i class="fas fa-thumbtack"></i></button>
          </div>
          <div class="notif-body">${n.message}</div>
        </div>
      </c:forEach>
    </div>
  </div>
</div>
<script src="js/system-notifications.js"></script> 