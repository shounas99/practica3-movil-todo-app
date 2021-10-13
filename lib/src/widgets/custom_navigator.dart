import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/src/providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int i){
        uiProvider.selectedMenuOpt = i;
      },
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: const Icon(Icons.assignment_outlined),
          label: 'Ver tareas'),
      BottomNavigationBarItem(
          icon: const Icon(Icons.assignment_turned_in_outlined),
          label: 'Tareas entregadas'),
     
    ]);
  }
}
