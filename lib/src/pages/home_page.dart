import 'package:flutter/material.dart';
import 'package:flutterappramsolpeliculas/src/widgets/card_swiper_widget.dart';



class HomePage  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines RAMSOL'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
        ],

      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _SwiperTarjetas()
          ],
        )
      )
    );
  }

  _SwiperTarjetas() {

    return CardSwiperWidget(
      peliculas: [1,2,3],
    );

  }



}
