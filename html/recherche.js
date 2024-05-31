document.getElementById('searchBookForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const query = document.getElementById('searchQuery').value;

    fetch(`http://localhost:8080/ords/restscott/bookshare/livre/?q=${query}`)
        .then(response => response.json())
        .then(data => {
            const searchResults = document.getElementById('searchResults');
            searchResults.innerHTML = '';
            data.items.forEach(book => {
                const li = document.createElement('li');
                li.textContent = `${book.titre} by ${book.auteur} (${book.genre}) - ${book.statut}`;
                searchResults.appendChild(li);
            });
        });
});
