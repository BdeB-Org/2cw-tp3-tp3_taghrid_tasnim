function loadProfile() {
    const userId = 1; // Replace with dynamic user ID

    fetch(`http://localhost:8080/ords/restscott/bookshare/utilisateur/${userId}`)
        .then(response => response.json())
        .then(data => {
            const profileInfo = document.getElementById('profileInfo');
            profileInfo.innerHTML = '';
            const li = document.createElement('li');
            li.textContent = `Nom: ${data.nom}, Email: ${data.email}`;
            profileInfo.appendChild(li);
        });
}

document.addEventListener('DOMContentLoaded', loadProfile);
