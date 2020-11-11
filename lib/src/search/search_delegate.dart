import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:movies_app/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  final peliculasProvider = new PeliculasProvider();

  String selection = '';
  final peliculas = [
    'Iron Man',
    'Spiderman',
    'Avengers',
    'Thor',
    'La roca',
    'Putos 2',
    'Putos 1'
  ];

  final peliculasRecientes = ['Avengers', 'Putos 2'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar (icono 'X' o cancelar)
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            // Limpia el input
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          // Permite volver a la pantalla anterior
          close(context, null);
        });
  }

  // No utilizado> Se puede dibujar nuevos widgets despues de buscar
  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.amber,
      child: Text(selection),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando la persona escribe
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          final peliculas = snapshot.data;

          return ListView(
              children: peliculas.map((peli) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(peli.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                width: 50.0,
                fit: BoxFit.cover,
              ),
              title: Text(peli.title),
              subtitle: Text(peli.originalTitle),
              onTap: () {
                close(context, null);
                peli.uniqueId = '';
                Navigator.pushNamed(context, 'detalle', arguments: peli);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /*
  // Test
  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias que aparecen cuando la persona escribe
    // TODO Filtro search
    final listaSugerida = (query.isEmpty)
        ? peliculasRecientes
        : peliculas
            .where(
                (movie) => movie.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: () {
            // Setea el nombre seleccionado de la lista
            selection = listaSugerida[i];
            showResults(context);
          },
        );
      },
    );
  } */
}
