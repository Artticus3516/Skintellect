import "package:flutter/logger.dart"
import "package:flutter/material.dart";


void main(){
  runApp(const Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "SlinTellect",
      home:Scaffold(
          appBar:AppBar(
            title: const Text("Skintellect")
          ),
      body: const Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: const <Widget>[
             Icon(Icons.star,color:Colors.blue),
             Icon(Icons.hail,color:Colors.green),
             Icon(Icons.favorite,color:Colors.red),

             ]
         ),
         Text('SO COOL '),
         Text('ME SO COOL>'),
       ],
      )
      ),
    );
  }

}