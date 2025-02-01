import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String mensagem;
  const EmptyWidget({super.key, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.warning_amber,
            size: 80,
            color: Colors.grey,
          ),
          Align(
            child: Text(
              "Você não possui $mensagem",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
