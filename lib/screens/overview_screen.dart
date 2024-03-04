import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  void _navigateToCreateTimer(BuildContext context) {
    context.push('/timer/10');
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Dein Timer"),
      ),
      body: const Column(
        children: [Text("welcome")],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreateTimer(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
