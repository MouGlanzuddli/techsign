// Toggle panel
const panel = document.getElementById('notificationPanel');
const toggleBtn = document.getElementById('togglePanelBtn');
let panelHidden = false;
if (toggleBtn && panel) {
  toggleBtn.onclick = function() {
    panelHidden = !panelHidden;
    panel.style.display = panelHidden ? 'none' : '';
  };
}
// Pin/Unpin AJAX
function ajaxPinUnpin(id, action) {
  fetch('notifications', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'action=' + action + '&id=' + id
  }).then(() => location.reload());
}
document.querySelectorAll('.btn-pin').forEach(btn => {
  btn.onclick = function() {
    ajaxPinUnpin(this.dataset.id, 'pin');
  };
});
document.querySelectorAll('.btn-unpin').forEach(btn => {
  btn.onclick = function() {
    ajaxPinUnpin(this.dataset.id, 'unpin');
  };
}); 