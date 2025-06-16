<!-- Modal xác th?c email ?? thêm vào index.jsp -->
<div class="modal fade" id="emailVerificationModal" tabindex="-1" role="dialog" aria-labelledby="emailVerificationLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="emailVerificationLabel">Xác th?c Email</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="text-center mb-3">
                    <i class="fas fa-envelope-circle-check text-primary" style="font-size: 48px;"></i>
                    <h6 class="mt-3">Xác th?c ??a ch? email c?a b?n</h6>
                    <p class="text-muted">Nh?p email ?? nh?n mã OTP xác th?c</p>
                </div>
                
                <div id="emailVerificationAlert"></div>
                
                <form id="emailVerificationForm">
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="verificationEmail" placeholder="name@example.com" required>
                        <label for="verificationEmail">??a ch? Email</label>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100" id="sendOtpBtn">
                        <span id="sendOtpText">G?i mã OTP</span>
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
            showVerificationAlert('Vui lòng nh?p ??a ch? email', 'danger');
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
                showVerificationAlert('Có l?i x?y ra. Vui lòng th? l?i.', 'danger');
            },
            complete: function() {
                setVerificationLoading(false);
            }
        });
    });
    
    function showVerificationAlert(message, type) {
        const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
        const alertHtml = `<div class="alert ${alertClass}">${message}</div>`;
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
