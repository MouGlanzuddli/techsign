function validateForm() {
    let isValid = true;

    // Xóa lỗi cũ

    ["jobtitle", "fullname", "email", "phone", "dob", "avatar", "address"].forEach(id => {
        document.getElementById(`error-${id}`).innerText = "";
    });

    const jobtitle = document.getElementById('jobtitle').value.trim();
    const fullname = document.getElementById('fullname').value.trim();
    const email = document.getElementById('email').value.trim();
    const phone = document.getElementById('phone').value.trim();
    const dob = document.getElementById('dob').value.trim();
    const avatar = document.getElementById('avatar').value.trim();
    const address = document.getElementById('address').value.trim();
    const mode = document.getElementById("formMode").value;


    const onlyLetters = /^[A-Za-z\s]+$/;
    const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
    const phoneRegex = /^[0-9]+$/;

    if (mode === "create" && !avatar) {
        document.getElementById('error-avatar').innerText = "Please choose an avatar.";
        isValid = false;
    }
    if (!jobtitle) {
        document.getElementById('error-jobtitle').innerText = "Profile Title is required.";
        isValid = false;
    } else if (!onlyLetters.test(jobtitle)) {
        document.getElementById('error-jobtitle').innerText = "Profile Title must contain letters only.";
        isValid = false;
    }

    if (!fullname) {
        document.getElementById('error-fullname').innerText = "Full name is required.";
        isValid = false;
    } else if (!onlyLetters.test(fullname)) {
        document.getElementById('error-fullname').innerText = "Full name must contain letters only.";
        isValid = false;
    }


    if (!email) {
        document.getElementById('error-email').innerText = "Email is required.";
        isValid = false;
    } else if (!emailRegex.test(email)) {
        document.getElementById('error-email').innerText = "Email must be a valid Gmail address.";
        isValid = false;
    }


    if (!phone) {
        document.getElementById('error-phone').innerText = "Phone number is required.";
        isValid = false;
    } else if (!phoneRegex.test(phone)) {
        document.getElementById('error-phone').innerText = "Phone number must contain numbers only.";
        isValid = false;
    }


    if (!dob) {
        document.getElementById('error-dob').innerText = "Please select date of birth and cannot be blank.";
        isValid = false;
    }

    if (!address) {
        document.getElementById('error-address').innerText = "Address is required.";
        isValid = false;
    }


    

    return isValid;
}
function clearField(fieldId) {
    document.getElementById(fieldId).value = "";
    updatePreview(); // Gọi lại preview nếu bạn cần cập nhật bên phải
}