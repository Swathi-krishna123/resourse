import 'package:flutter/material.dart';

class ShareResources extends StatelessWidget {
  const ShareResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Correct way to access ScaffoldState
          Scaffold.of(context).showBottomSheet(
            (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.blue,
                child: const Center(
                  child: Text('This is a persistent bottom sheet'),
                ),
              );
            },
          );
        },
        child: const Text('Show Persistent Bottom Sheet'),
      ),
    );
  }
}