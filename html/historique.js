function loadBorrowHistory() {
    fetch('http://localhost:8080/ords/restscott/bookshare/historique/')
        .then(response => response.json())
        .then(data => {
            const borrowHistory = document.getElementById('borrowHistory');
            borrowHistory.innerHTML = '';
            data.items.forEach(record => {
                const li = document.createElement('li');
                li.textContent = `Emprunt ID: ${record.emprunt_id}, Utilisateur ID: ${record.utilisateur_id}`;
                borrowHistory.appendChild(li);
            });
        });
}

document.addEventListener('DOMContentLoaded', loadBorrowHistory);
