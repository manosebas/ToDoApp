import 'package:flutter/material.dart';

class Contador extends StatefulWidget {
  const Contador({super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador'),
      ),
      body: Center(
          child: Text('Hola, el contador es: $count')),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              if (count < 10){
                count++;
              }
              setState(() {});
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              if (count > 0){
                count--;
              }
              setState(() {});
            },
            child: const Icon(Icons.exposure_minus_1),
          ),
        ],
      ),
    );
  }
}
