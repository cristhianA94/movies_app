/* import 'package:flutter/material.dart';
import 'package:movies_app/src/models/actores_model.dart';

import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:movies_app/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO Recibe argumentos mandados
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitulo(pelicula, context),
                _descripcion(pelicula),
                Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text('Reparto',
                        style: Theme.of(context).textTheme.subtitle1)),
                SizedBox(height: 10.0),
                _crearCasting(pelicula),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    final Shader linearGradient = LinearGradient(
      colors: [Colors.white, Colors.white30],
    ).createShader(Rect.fromLTWH(50.0, 0.0, 500.0, 100.0));

    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.teal,
      expandedHeight: 200.0,
      // False: Aparece el bar cuando se regrese al inicio | True: Aparece el bar cuando se acerca al inicio
      floating: true,
      // False: Vuelve transparente el bar al scrollear | True: Deja fijo el bar
      pinned: true,
      // False: Sin efecto de recorte al volver | True: Efecto de recorte al volver
      snap: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          textAlign: TextAlign.center,
          // style: TextStyle(color: Colors.white, fontSize: 20.0),
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            SizedBox(
              child: Hero(
                tag: pelicula.uniqueId,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: NetworkImage(pelicula.getPosterImg()),
                    height: 150.0,
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.0),
            // Utiliza el espacio restando para el widget
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline6),
                Text(pelicula.originalTitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(width: 5.0),
                    Icon(Icons.favorite),
                    Text(pelicula.voteCount.toString(),
                        style: Theme.of(context).textTheme.subtitle1),
                    SizedBox(width: 5.0),
                    Icon(Icons.trending_up),
                    Text(pelicula.popularity.toString(),
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
                )
              ],
            ))
          ],
        ));
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontSize: 19.0,
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i], context),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor, context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(actor.getProfileImg()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
 */