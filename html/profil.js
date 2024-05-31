function loadProfile() {
    
    fetch(`http://localhost:8080/ords/restscott/bookshare/utilisateur`)
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
