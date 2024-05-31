document.getElementById('addBookForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const title = document.getElementById('title').value;
    const author = document.getElementById('author').value;
    const genre = document.getElementById('genre').value;

    fetch('http://localhost:8080/ords/restscott/bookshare/livre/', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            titre: title,
            auteur: author,
            genre: genre,
            statut: 'Disponible'
        })
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        loadBooks();
    })
    .catch((error) => {
        console.error('Error:', error);
    });
});

function loadBooks() {
    fetch('http://localhost:8080/ords/restscott/bookshare/livre/')
        .then(response => response.json())
        .then(data => {
            const bookList = document.getElementById('bookList');
            bookList.innerHTML = '';
            data.items.forEach(book => {
                const li = document.createElement('li');
                li.textContent = `${book.titre} by ${book.auteur} (${book.genre}) - ${book.statut}`;
                bookList.appendChild(li);
            });
        });
}

document.addEventListener('DOMContentLoaded', loadBooks);
