import 'package:flutter/material.dart';
import '../models/computadora.dart';

class ComputadoraTile extends StatelessWidget {
  final Computadora computadora;
  final Function onDelete;
  final Function onEdit;

  ComputadoraTile(
      {required this.computadora,
      required this.onDelete,
      required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(computadora.procesador),
      subtitle:
          Text('Disco: ${computadora.discoDuro}, RAM: ${computadora.ram}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => onEdit(),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete(),
          ),
        ],
      ),
    );
  }
}
