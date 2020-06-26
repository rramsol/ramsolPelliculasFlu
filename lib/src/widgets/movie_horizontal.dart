import 'package:flutter/material.dart';
import 'package:flutterappramsolpeliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas , @required this.siguientePagina});

  final _pageControleer = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );


  @override
  Widget build(BuildContext context) {

    _pageControleer.addListener(() {
      if(_pageControleer.position.pixels >= _pageControleer.position.maxScrollExtent){
          siguientePagina();
      }
    });

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height *0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageControleer,
       itemCount: peliculas.length,
       itemBuilder: (context, index){
          return _tarjeta(context, peliculas[index]);
       },
       // children: _tarjetas(context),
      ),
    );
  }


Widget _tarjeta( BuildContext context, Pelicula pelicula){

  final tarjeta = Container(
    margin: EdgeInsets.only(right: 15.0),
    child: Column(
      children: <Widget>[
        Hero(
          tag: pelicula.id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(pelicula.getPostImg()),
              placeholder:AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 170.0,
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Text(pelicula.title,
          overflow: TextOverflow.ellipsis,
          style:Theme.of(context).textTheme.caption,
        ),
      ],
    ),
  );

  return GestureDetector(
    child: tarjeta,
    onTap: (){
      Navigator.pushNamed(context, 'detalle', arguments: pelicula);
    },
  );
}


List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map( (pelicula){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPostImg()),
                placeholder:AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 170.0,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(pelicula.title,
              overflow: TextOverflow.ellipsis,
              style:Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
}


}
