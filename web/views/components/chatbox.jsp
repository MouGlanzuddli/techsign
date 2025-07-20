<div id="chatbox-bg-gradient"></div>
<div id="chatbox-container" style="display:none;">
  <!-- Sidebar: Danh sách user -->
  <div id="chatbox-sidebar">
    <div id="chatbox-search">
      <input type="text" placeholder="Search...">
      <i class="fas fa-search"></i>
    </div>
    <div id="chatbox-user-list"></div>
  </div>
  <!-- Main chat area -->
  <div id="chatbox-main">
    <div id="chatbox-header">
      <div id="chatbox-header-avatar"><i class="fas fa-user"></i></div>
      <div id="chatbox-header-info">
        <div id="chatbox-header-name">server-server</div>
        <div id="chatbox-header-status">Online</div>
      </div>
      <div id="chatbox-header-actions">
        <i class="fas fa-ellipsis-v"></i>
        <i class="fas fa-times" id="chatbox-close"></i>
      </div>
    </div>
    <div id="chatbox-messages"></div>
    <div id="chatbox-footer">
      <i class="fas fa-paperclip" id="chatbox-upload"></i>
      <input type="file" id="chatbox-file" style="display:none;" />
      <input type="text" id="chatbox-input" placeholder="Type your message..." autocomplete="off">
      <i class="fas fa-paper-plane" id="chatbox-send"></i>
    </div>
  </div>
</div>
<!-- Modal xem ảnh lớn -->
<div id="chatbox-img-modal" style="display:none;position:fixed;z-index:9999;top:0;left:0;width:100vw;height:100vh;background:rgba(0,0,0,0.7);align-items:center;justify-content:center;">
  <span id="chatbox-img-modal-close" style="position:absolute;top:24px;right:36px;font-size:36px;color:#fff;cursor:pointer;z-index:10001;">&times;</span>
  <img id="chatbox-img-modal-img" src="" style="max-width:90vw;max-height:90vh;border-radius:12px;box-shadow:0 4px 24px #0008;display:block;margin:auto;z-index:10000;" />
</div>
<!-- Nhớ include FontAwesome và chatbox.css ở trang chính --> 