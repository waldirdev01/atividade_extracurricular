import 'package:flutter/material.dart';

class BusLogo extends StatelessWidget {
  const BusLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/bus.jpg', width: 200, height: 200),
          const Text('Atividade Extracurricular',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
