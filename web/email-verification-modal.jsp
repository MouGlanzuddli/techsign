<!-- Modal xác thực email -->
<div class="modal fade" id="emailVerificationModal" tabindex="-1" role="dialog" aria-labelledby="emailVerificationLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold text-success" id="emailVerificationLabel">
                    <i class="fa-solid fa-envelope-circle-check me-2"></i> Email Authentication
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body pt-0">
                <div class="text-center mb-3">
                    <i class="fa-solid fa-envelope-circle-check text-success" style="font-size: 48px;"></i>
                    <h6 class="mt-3 fw-semibold"></h6>
                    <p class="text-muted mb-2">Enter email to receive OTP verification code</p>
                </div>
                <div id="emailVerificationAlert"></div>
                <form id="emailVerificationForm" autocomplete="off">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="verificationEmail" placeholder="name@example.com" required>
                        <label for="verificationEmail">Email Address</label>
                    </div>
                    <button type="submit" class="btn btn-success w-100 shadow-sm" id="sendOtpBtn">
                        <span id="sendOtpText">Send OTP code</span>
                        <span id="sendOtpSpinner" class="spinner-border spinner-border-sm d-none" role="status"></span>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#emailVerificationForm').on('submit', function(e) {
        e.preventDefault();
        const email = $('#verificationEmail').val();
        if (!email) {
            showVerificationAlert('Please enter email address', 'danger');
            return;
        }
        setVerificationLoading(true);
        $.ajax({
            url: '${pageContext.request.contextPath}/SendOtpServlet',
            method: 'POST',
            data: { email: email },
            success: function(response) {
                if (response.success) {
                    $('#emailVerificationModal').modal('hide');
                    window.location.href = '${pageContext.request.contextPath}/email-verification.jsp?email=' + encodeURIComponent(email);
                } else {
                    showVerificationAlert(response.message, 'danger');
                }
            },
            error: function() {
                showVerificationAlert('An error occurred please try again.', 'danger');
            },
            complete: function() {
                setVerificationLoading(false);
            }
        });
    });
    function showVerificationAlert(message, type) {
        const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
        const alertHtml = `<div class="alert ${alertClass} mt-2 mb-0 py-2 px-3">${message}</div>`;
        $('#emailVerificationAlert').html(alertHtml);
        setTimeout(function() {
            $('#emailVerificationAlert').empty();
        }, 5000);
    }
    function setVerificationLoading(loading) {
        if (loading) {
            $('#sendOtpText').addClass('d-none');
            $('#sendOtpSpinner').removeClass('d-none');
            $('#sendOtpBtn').prop('disabled', true);
        } else {
            $('#sendOtpText').removeClass('d-none');
            $('#sendOtpSpinner').addClass('d-none');
            $('#sendOtpBtn').prop('disabled', false);
        }
    }
});
</script>