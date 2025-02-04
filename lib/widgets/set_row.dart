import 'package:flutter/material.dart';

class SetRow extends StatelessWidget {
  final int setIndex;
  final TextEditingController controller;
  final int reps;

  const SetRow({
    super.key,
    required this.setIndex,
    required this.controller,
    required this.reps,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text('Set ${setIndex + 1}'),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: false,
              ),
              textInputAction: TextInputAction.done,
              onEditingComplete: () => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                labelText: 'Reps',
                hintText: reps.toString(),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}