const dropdown = document.querySelector('.dropdown');
const dropdownToggle = document.querySelector('.dropdown-toggle');

dropdownToggle.addEventListener('click', () => {
    dropdown.classList.toggle('show');
});

// Đóng dropdown khi click ra ngoài
window.addEventListener('click', (event) => {
    if (!event.target.matches('.dropdown-toggle')) {
        if (dropdown.classList.contains('show')) {
            dropdown.classList.remove('show');
        }
    }
});