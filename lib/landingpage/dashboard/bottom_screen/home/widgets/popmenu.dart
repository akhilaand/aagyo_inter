// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:aagyo/const/constString.dart';

class ConstantPopMenu extends StatelessWidget {
  const ConstantPopMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        // Handle menu item selection
        switch (result) {
          case 'Item 1':
          // Perform action for Item 1
            break;
          case 'Item 2':
          // Perform action for Item 2
            break;
          case 'Item 3':
          // Perform action for Item 3
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Item 1',
          child: ListTile(
            leading: Image.asset(call),
            title: const Text("Call Customer"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Item 2',
          child: ListTile(
            leading: Image.asset(call),
            title: const Text("Call Customer"),
          ),
        ),
        PopupMenuItem<String>(
          value: 'Item 3',
          child: ListTile(
            leading: Image.asset(call),
            title: const Text("Call Customer"),
          ),
        ),
      ],
    );
  }
}
