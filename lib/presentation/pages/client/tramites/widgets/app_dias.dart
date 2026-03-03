import 'package:flutter/material.dart';

class AppDias extends StatelessWidget {
  const AppDias({super.key, required this.dia});
  final String dia;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 7),
          height: 25,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xfff2f2f3),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              dia,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
