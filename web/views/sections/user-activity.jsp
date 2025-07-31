<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="user-activity-section" class="section-container">
    <div class="section-header mb-4">
        <h2><i class="fas fa-user-shield"></i> User Sessions & Activity Logs</h2>
    </div>

    <!-- Sessions Table -->
    <div class="card mb-4">
        <div class="card-header">Active & Recent Sessions</div>
        <div class="table-responsive">
            <table class="table table-hover" id="sessionsTable">
                <thead>
                    <tr>
                        <th>Device</th>
                        <th>IP Address</th>
                        <th>Login Time</th>
                        <th>Last Active</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="sessionsTableBody"></tbody>
            </table>
        </div>
    </div>

    <!-- System Logs Table -->
    <div class="card mb-4">
        <div class="card-header">System Logs</div>
        <div class="table-responsive">
            <table class="table table-hover" id="systemLogsTable">
                <thead>
                    <tr>
                        <th>Action</th>
                        <th>Description</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody id="systemLogsTableBody"></tbody>
            </table>
        </div>
    </div>

    <!-- Audit Logs Table -->
    <div class="card mb-4">
        <div class="card-header">Audit Logs</div>
        <div class="table-responsive">
            <table class="table table-hover" id="auditLogsTable">
                <thead>
                    <tr>
                        <th>Action Type</th>
                        <th>Entity</th>
                        <th>Entity ID</th>
                        <th>Old Value</th>
                        <th>New Value</th>
                        <th>IP</th>
                        <th>Time</th>
                    </tr>
                </thead>
                <tbody id="auditLogsTableBody"></tbody>
            </table>
        </div>
    </div>
</div>
