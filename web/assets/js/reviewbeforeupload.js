
function displayFileName() {
    const fileInput = document.getElementById("resumeFile");
    const fileNameDisplay = document.getElementById("fileName");
    const fileError = document.getElementById("fileError");
    const pdfPreview = document.getElementById("pdfPreview");
    const uploadBtn = document.getElementById("uploadBtn");
    const otherCVBtn = document.getElementById("otherCVBtn");


    if (fileInput.files.length > 0) {
        const file = fileInput.files[0];
        fileNameDisplay.textContent = "Selected: " + file.name;

        // Kiểm tra định dạng PDF
        if (!file.name.toLowerCase().endsWith(".pdf")) {
            fileError.style.display = "block";
            pdfPreview.style.display = "none";
            pdfPreview.src = "";
            uploadBtn.textContent = "Upload Resume";
            otherCVBtn.style.display = "none";
        } else {
            fileError.style.display = "none";

            // Xem trước nội dung PDF
            const fileURL = URL.createObjectURL(file);
            pdfPreview.src = fileURL;
            pdfPreview.style.display = "block";

            // Đổi nút
            uploadBtn.textContent = "Other CVs";
            otherCVBtn.style.display = "block";
        }
    } else {
        // Nếu chưa chọn file, reset mọi thứ
        fileNameDisplay.textContent = "";
        fileError.style.display = "none";
        pdfPreview.style.display = "none";
        pdfPreview.src = "";
        uploadBtn.textContent = "Upload Resume";
        otherCVBtn.style.display = "none";
    }
}

function validateFileType() {
    const fileInput = document.getElementById("resumeFile");
    const file = fileInput.files[0];

    if (!file || !file.name.endsWith(".pdf")) {
        document.getElementById("fileError").style.display = "block";
        return false;
    }

    return true;
}
function toggleApplyOption() {
  const isUpload = document.getElementById('uploadOption').checked;
  document.getElementById('uploadSection').style.display = isUpload ? 'block' : 'none';
  document.getElementById('selectSection').style.display = isUpload ? 'none' : 'block';
}

// Hiển thị tên file + preview PDF
function displayFileName() {
  const input = document.getElementById('resumeFile');
  const fileName = input.files[0].name;
  document.getElementById('fileName').innerText = "Selected: " + fileName;

  if (fileName.endsWith(".pdf")) {
    const file = input.files[0];
    const reader = new FileReader();
    reader.onload = function(e) {
      const iframe = document.getElementById('pdfPreview');
      iframe.src = e.target.result;
      iframe.style.display = "block";
      document.getElementById('fileError').style.display = "none";
    };
    reader.readAsDataURL(file);
  } else {
    document.getElementById('fileError').style.display = "block";
  }
}

function toggleCVSelect() {
  const choice = document.querySelector('input[name="cvChoice"]:checked').value;

  const candidateBlock = document.getElementById('candidateBlock');
  const systemBlock = document.getElementById('systemBlock');

  const candidateSelect = document.getElementById('candidateCvSelect');
  const systemSelect = document.getElementById('systemCvSelect');

  if (choice === 'candidate') {
    candidateBlock.classList.remove('disabled-block');
    systemBlock.classList.add('disabled-block');

    candidateSelect.disabled = false;
    systemSelect.disabled = true;
    systemSelect.value = "";

  } else {
    candidateBlock.classList.add('disabled-block');
    systemBlock.classList.remove('disabled-block');

    candidateSelect.disabled = true;
    systemSelect.disabled = false;
    candidateSelect.value = "";
  }
}

