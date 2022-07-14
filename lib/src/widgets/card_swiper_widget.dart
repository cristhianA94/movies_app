import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

import 'package:movies_app/src/models/pelicula_model.dart';
// Transicion imagenes

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  // Constructor
  CardSwiper({required this.peliculas});

  @override
  Widget build(BuildContext context) {
    // Referencia del tamanio de pantalla del dispositivo
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        // 70%
        itemWidth: _screenSize.width * 0.7,
        // 50%
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          // Validacion para que no se repita el id en la animacion Hero
          peliculas[index].uniqueId = '${peliculas[index].id}-tarketa';

          return SizedBox(
            child: Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalle',
                      arguments: peliculas[index]),
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/img/no-image.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        //pagination: SwiperPagination(),
        //control: SwiperControl(),
      ),
    );
  }
}
