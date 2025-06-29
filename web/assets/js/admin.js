document.addEventListener('DOMContentLoaded', function() {
    const menuLinks = document.querySelectorAll('.menu-link');
    const sectionContent = document.getElementById('section-content');
    const breadcrumbText = document.getElementById('breadcrumb-text');

    function showLoading() {
        sectionContent.innerHTML = '<div style="text-align:center;padding:40px"><i class="fas fa-spinner fa-spin fa-2x"></i><br>Đang tải...</div>';
    }

    function getBasePath() {
        // Get the base path for the app (context root)
        const path = window.location.pathname;
        const idx = path.indexOf('/', 1);
        return idx > 0 ? path.substring(0, idx + 1) : '/';
    }

    function loadSection(file, sectionId, breadcrumb) {
        showLoading();
        const basePath = getBasePath();
        fetch(basePath + 'views/sections/' + file)
            .then(response => {
                if (!response.ok) throw new Error('HTTP error ' + response.status);
                return response.text();
            })
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                const section = doc.querySelector('#' + sectionId);
                if (section) {
                    sectionContent.innerHTML = section.innerHTML;
                } else {
                    sectionContent.innerHTML = '<p>Không tìm thấy nội dung.</p>';
                }
                if (breadcrumbText && breadcrumb) {
                    breadcrumbText.textContent = breadcrumb;
                }
            })
            .catch(() => {
                sectionContent.innerHTML = '<p>Lỗi khi tải nội dung.</p>';
                if (breadcrumbText && breadcrumb) {
                    breadcrumbText.textContent = breadcrumb;
                }
            });
    }

    menuLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            menuLinks.forEach(l => l.parentElement.classList.remove('active'));
            link.parentElement.classList.add('active');

            const file = link.getAttribute('data-file');
            const section = link.getAttribute('data-section');
            const breadcrumb = link.getAttribute('data-breadcrumb') || link.textContent.trim();

            loadSection(file, section, breadcrumb);
        });
    });

    // Set default breadcrumb on page load
    if (breadcrumbText) {
        breadcrumbText.textContent = 'Dashboard Tổng Quan';
    }
});
