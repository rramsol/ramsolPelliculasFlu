import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterappramsolpeliculas/src/models/pelicula_model.dart';

class CardSwiperWidget extends StatelessWidget {

  final List<Pelicula> peliculas;
  CardSwiperWidget({@required this.peliculas});


  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Swiper(
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width*0.6,
        itemHeight: _screenSize.height*0.4,
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uniqueId = '${ peliculas[index].id}-tarjeta';



          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child:  GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
                },
                child: FadeInImage(
                  image: NetworkImage( peliculas[index].getPostImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              )
            ),
          );
        },
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
