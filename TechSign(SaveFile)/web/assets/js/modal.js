window.openModal = function() {
    document.getElementById("addUserModal").style.display = "block";
};

window.closeModal = function() {
    document.getElementById("addUserModal").style.display = "none";
};

window.onclick = function(event) {
    const modal = document.getElementById("addUserModal");
    if (event.target === modal) {
        modal.style.display = "none";
    }
};
