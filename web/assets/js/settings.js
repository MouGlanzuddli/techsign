document.getElementById('settingsForm').onsubmit = function(e) {
  e.preventDefault();
  const form = this;
  const formData = new FormData(form);
  fetch('settings', {
    method: 'POST',
    body: formData
  })
  .then(res => {
    if (res.ok) {
      sectionLoader.showSuccessMessage('Lưu cài đặt thành công!');
      sectionLoader.reloadCurrentSection();
    } else {
      sectionLoader.showErrorMessage('Lỗi khi lưu cài đặt');
    }
  });
}; 