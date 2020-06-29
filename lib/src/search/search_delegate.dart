import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate{

  String seleccion = '';

  final peliculas = [
    'spiderman',
    'dark',
    'infinity',
    'star wars',
    'ironman',
    'ironman 2',
    'ironman 3',
    'ironman 4',
    'Capitan 5',
    'Thor',

  ];

  final peliculasRecientes = [
    'spiderman',
    'Capitan'
  ];





  @override
  List<Widget> buildActions(BuildContext context) {
    // las acciones de nuestro appbar cancelar cerrar

   return [
     IconButton(
       icon: Icon(Icons.clear),
       onPressed: (){
         query='';
       },
     )
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del appbar

   return IconButton(
     icon: AnimatedIcon(
       icon: AnimatedIcons.menu_arrow,
       progress: transitionAnimation,
     ),
     onPressed: (){
      close(context, null);
     },
   );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar

    return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencia que aparecen cuando las personas escriben

    final listaSugerida = (query.isEmpty)
                            ? peliculasRecientes
                            : peliculas.where((element) => element.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
        itemBuilder: (context,i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            seleccion = listaSugerida[i];
            showResults(context);
          },
        );
        }
    );

  }

}