import 'package:flutter/material.dart';

class AppBarIcons extends StatelessWidget {
   const AppBarIcons({
    Key? key,
     required this.function,
    required this.icon,
  }) : super(key: key);

   // Делаем динамический виджет на основе этих двух атрибутов (параметров)
   final Function function;
   final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Передаю функцию
        function();
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon),
        ),
        // child: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Icon(icon),
        // ),
      ),
    );
  }
}
