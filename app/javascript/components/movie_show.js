const movieShow = () => {

  const movies = document.querySelectorAll('.movie-card');

  if (movies !=undefined || null) {
    movies.forEach((movie) => {
      console.log("hello from js")
      movie.addEventListener('click', (event) => {
        event.preventDefault();
        const imbdId = movie.dataset.imdb;
        window.location.href = `/movies/movie?imdbid=${imbdId}`;
      });
    })
  }

};

export { movieShow}
