// Flutter imports:
import 'package:flutter/material.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        body: PopupMenuButton<String>(
          // Define the items in the menu
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'option1',
                child: Text('Option 1'),
              ),
              const PopupMenuItem<String>(
                value: 'option2',
                child: Text('Option 2'),
              ),
              const PopupMenuItem<String>(
                value: 'option3',
                child: Text('Option 3'),
              ),
            ];
          },
          // Define the behavior when an item is selected
          onSelected: (String value) {
            // Perform the desired action based on the selected value
            switch (value) {
              case 'option1':
              // Do something for Option 1
                break;
              case 'option2':
              // Do something for Option 2
                break;
              case 'option3':
              // Do something for Option 3
                break;
            }
          },
        ),
        // Adding the PopupMenuButton to the app bar actions
        appBar: AppBar(
          title: const Text('PopupMenuButton Example'),
          actions: const [

          ],
        ),
      ),
    );
  }
}
