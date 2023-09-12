// Flutter imports:
import 'package:flutter/material.dart';

class ContainerExample extends StatefulWidget {
  const ContainerExample({super.key});

  @override
  _ContainerExampleState createState() => _ContainerExampleState();
}

class _ContainerExampleState extends State<ContainerExample> {
  int tapCount = 0;

  void changeContent() {
    setState(() {
      tapCount++;
    });
  }

  Widget _buildContent() {
    if (tapCount  == 0) {
      return Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Tap to Change',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }
    if(tapCount == 1){
      return Container(
        width: 200,
        height: 200,
        color: Colors.blue,
        child: const Center(
          child: Text(
            'Tap to Change1',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }
    else {
      return Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Center(
          child: Text(
            'Changed!',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container Example'),
      ),
      body: GestureDetector(
        onTap: () {
          changeContent();
        },
        child: Center(
          child: _buildContent(),
        ),
      ),
    );
  }
}
