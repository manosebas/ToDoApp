import 'package:apptareas/app/view/components/h1.dart';
import 'package:apptareas/app/view/components/shape.dart';
import 'package:apptareas/app/view/task_list/lista_tareas_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              children: [
                Shape(),
              ],
            ),
            const SizedBox(height: 73),
            Image.asset(
              'assets/images/onboarding-image.png',
              height: 180,
              width: 168,
            ),
            const SizedBox(height: 99),
            const H1('Lista de Tarea'),
            const SizedBox(height: 21),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return TaskListPage(); //View
                }));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'La mejor forma para que no se te olvide nada es anotarlo. Guardar tus tareas y ve completando poco a poco para aumentar tu productividad',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
