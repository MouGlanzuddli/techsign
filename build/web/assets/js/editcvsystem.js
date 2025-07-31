function updatePreview() {
  // Phần cơ bản
  document.getElementById('preview-fullname').innerText = document.getElementById('fullname')?.value || "";
  document.getElementById('preview-jobtitle').innerText = document.getElementById('jobtitle')?.value || "";
  document.getElementById('preview-email').innerText = document.getElementById('email')?.value || "";
  document.getElementById('preview-phone').innerText = document.getElementById('phone')?.value || "";
  document.getElementById('preview-dob').innerText = document.getElementById('dob')?.value || "";
  document.getElementById('preview-address').innerText = document.getElementById('address')?.value || "";
  document.getElementById('preview-objective').innerText = document.getElementById('objective')?.value || "";

  // Kỹ năng
  const skills = document.getElementById('skills')?.value.split('\n') || [];
  const skillsList = document.getElementById('preview-skills');
  skillsList.innerHTML = "";
  skills.forEach(skill => {
    if (skill.trim() !== "") {
      const li = document.createElement('li');
      li.textContent = skill.trim();
      skillsList.appendChild(li);
    }
  });

  // Kinh nghiệm làm việc
  const expContainer = document.getElementById('preview-experience');
  expContainer.innerHTML = "";
  const exps = document.querySelectorAll('.exp-block');
  exps.forEach(block => {
    const company = block.querySelector('.exp-company')?.value || "";
    const position = block.querySelector('.exp-position')?.value || "";
    const period = block.querySelector('.exp-period')?.value || "";
    const detail = block.querySelector('.exp-detail')?.value || "";

    if (company.trim() === "" && position.trim() === "" && detail.trim() === "") return;

    const div = document.createElement('div');
    div.classList.add('mb-3');
    div.innerHTML = `
      <div class="d-flex justify-content-between">
        <h6 class="fw-bold mb-0">${company}</h6>
        <small>${period}</small>
      </div>
      <em>${position}</em>
      <ul>${detail.split('\n').map(line => `<li>${line}</li>`).join('')}</ul>
    `;
    expContainer.appendChild(div);
  });
}

// Thêm mới block kinh nghiệm
function addExperience() {
  const expList = document.getElementById('experience-list');
  const newBlock = document.createElement('div');
  newBlock.classList.add('exp-block', 'mb-3');
  newBlock.innerHTML = `
    <input type="text" name="company" placeholder="Company name" class="form-control exp-company mb-2" oninput="updatePreview()">
    <input type="text" name="position" placeholder="Position" class="form-control exp-position mb-2" oninput="updatePreview()">
    <input type="text" name="period" placeholder="Period (e.g., 03/2019 - 09/2020)" class="form-control exp-period mb-2" oninput="updatePreview()">
    <textarea name="detail" placeholder="One line per idea" class="form-control exp-detail" oninput="updatePreview()"></textarea>
  `;
  expList.appendChild(newBlock);
}

// Xem trước Avatar (nếu có)
function previewAvatar() {
  const file = document.getElementById('avatar')?.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = function (e) {
      document.getElementById('preview-avatar').src = e.target.result;
    };
    reader.readAsDataURL(file);
  }
}

// Khi load trang, tự cập nhật lại preview
window.onload = () => {
  updatePreview();
};