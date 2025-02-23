let logoutButton = document.getElementById('logoutButton');

logoutButton.addEventListener('click', () => {
    fetch("logout.php", {
        method: 'GET',
    })
        .then(response => {
            if (response.redirected) {
                window.location.href = response.url;
            }
        })
        .catch(error => {
            console.error('Ошибка при выходе:', error);
        });
});