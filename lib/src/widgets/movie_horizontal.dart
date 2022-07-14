import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  // Constructor
  MovieHorizontal({required this.peliculas, required this.siguientePagina});
  // Controller
  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    // Tamaño screen dispositivo
    final _screenSize = MediaQuery.of(context).size;

    // Esta pendiente cuando casi llegue al final del scroll
    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 250) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      // TODO Builder renderiza widgets segun se vayan generando
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    // Validacion para que no se repita el id en la animacion Hero
    pelicula.uniqueId = '${pelicula.id}-poster';

    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 5.0),
      child: Column(
        children: [
          // Animacion tarjeta
          SizedBox(
            child: Hero(
              // Id unico de la animacion
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
          ),
          SizedBox(),
          Text(
            pelicula.title!,
            // Pone ... cuando ya no cabe
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    // Permite manejar evento
    return GestureDetector(
      child: peliculaTarjeta,
      onTap: () {
        // Navega a otra ruta
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        //print("Pelicula:${pelicula.title}");
      },
    );
  }
}
