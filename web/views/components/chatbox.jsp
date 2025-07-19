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
<!-- Nhớ include FontAwesome và chatbox.css ở trang chính --> 