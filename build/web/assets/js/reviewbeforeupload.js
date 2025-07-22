function displayFileName() {
    const fileInput = document.getElementById("resumeFile");
    const fileNameDisplay = document.getElementById("fileName");
    const fileError = document.getElementById("fileError");
    const pdfPreview = document.getElementById("pdfPreview");
    const uploadBtnLabel = document.getElementById("uploadBtnLabel");
    const cancelBtn = document.getElementById("cancelBtn");

    if (fileInput.files.length > 0) {
        const file = fileInput.files[0];
        fileNameDisplay.textContent = "Selected: " + file.name;

        if (!file.name.toLowerCase().endsWith(".pdf")) {
            fileError.style.display = "block";
            pdfPreview.style.display = "none";
            pdfPreview.src = "";
            uploadBtnLabel.innerText = "Upload Resume";
            cancelBtn.style.display = "none";
        } else {
            fileError.style.display = "none";
            const fileURL = URL.createObjectURL(file);
            pdfPreview.src = fileURL;
            pdfPreview.style.display = "block";
            uploadBtnLabel.innerText = "Other CVs";
            cancelBtn.style.display = "inline-block"; // ✅ Show cancel
        }
    } else {
        fileNameDisplay.textContent = "";
        fileError.style.display = "none";
        pdfPreview.style.display = "none";
        pdfPreview.src = "";
        uploadBtnLabel.innerText = "Upload Resume";
        cancelBtn.style.display = "none";
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
function cancelFileUpload() {
    const fileInput = document.getElementById("resumeFile");
    const fileNameDisplay = document.getElementById("fileName");
    const pdfPreview = document.getElementById("pdfPreview");
    const uploadBtnLabel = document.getElementById("uploadBtnLabel");
    const cancelBtn = document.getElementById("cancelBtn");

    // Reset input file
    fileInput.value = "";
    fileNameDisplay.textContent = "";
    pdfPreview.src = "";
    pdfPreview.style.display = "none";
    uploadBtnLabel.innerText = "Upload Resume";
    cancelBtn.style.display = "none";
}
