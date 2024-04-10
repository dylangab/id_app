import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IdError extends StatefulWidget {
  const IdError({super.key});

  @override
  State<IdError> createState() => _IdErrorState();
}

class _IdErrorState extends State<IdError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.error_outline,
            size: 110,
          ).animate(
              autoPlay: true,
              effects: [const ShakeEffect(duration: Duration(seconds: 1))]),
          const SizedBox(
            height: 10,
          ),
          const Center(child: Text("Id doesn't exists"))
        ],
      ),
    );
  }
}
