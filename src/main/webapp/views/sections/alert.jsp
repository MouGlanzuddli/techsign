<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section id="alert">


<!-- Bảng merged alerts -->
<div id="alerts" class="section-container mt-5">
    <div class="section-header d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0"><i class="fas fa-exclamation-triangle"></i> Cảnh báo hoạt động</h2>
    </div>
    <button onclick="sectionLoader.reloadCurrentSection()" class="btn btn-primary mb-3">
      <i class="fas fa-sync-alt"></i> Reload Alerts
    </button>
    <div class="card">
        <div class="card-header">
            <h5 class="card-title mb-0"><i class="fas fa-bell"></i> Danh sách cảnh báo</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0" id="alertsTable">
                    <thead class="table-light">
                        <tr>
                            <th>Action</th>
                            <th>Entity</th>
                            <th>Entity ID</th>
                            <th>Old Value</th>
                            <th>New Value</th>
                            <th>Audit IP</th>
                            <th>Audit Time</th>
                            <th>Device</th>
                            <th>Login Time</th>
                            <th>Session Status</th>
                            <th>Severity</th>
                        </tr>
                    </thead>
                    <tbody id="alertsTableBody">
                        <!-- Populated by JS -->
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
// Auto-reload alerts every 60 seconds if this section is active
if (typeof sectionLoader !== 'undefined' && sectionLoader.getCurrentSection && sectionLoader.getCurrentSection() === 'alert') {
  setInterval(() => {
    sectionLoader.reloadCurrentSection();
  }, 60000);
}
</script>
</section>
