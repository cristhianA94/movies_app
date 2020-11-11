class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  // Transforma el Json a una lista
  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      // Instancia de cada pelicula
      final pelicula = new Pelicula.fromJsonMap(item);
      // Agrega la pelicula mapeada
      items.add(pelicula);
    }
  }
}

class Pelicula {
  // Var para identificar id unico
  String uniqueId;

  int id;
  int voteCount;
  double popularity;
  bool video;
  String posterPath;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.id,
    this.voteCount,
    this.popularity,
    this.video,
    this.posterPath,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  // Permite mapear el json y asignar a las propiedades de la clase
  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    // json['variableAPI']
    id = json['id'];
    voteCount = json['vote_count'];
    popularity = json['popularity'] / 1;
    video = json['video'];
    posterPath = json['poster_path'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average'] / 1;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://sisterhoodofstyle.com/wp-content/uploads/2018/02/no-image-1.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if (backdropPath == null) {
      return 'https://sisterhoodofstyle.com/wp-content/uploads/2018/02/no-image-1.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}
