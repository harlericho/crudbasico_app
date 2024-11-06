import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/computadora.dart';
import 'agregar_editar_screen.dart';
import '../widgets/computadora_tile.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late Future<List<Computadora>> _computadoras;

  @override
  void initState() {
    super.initState();
    _refreshComputadoras();
  }

  void _refreshComputadoras() {
    setState(() {
      _computadoras = DatabaseHelper.instance.getComputadoras();
    });
  }

  // Función para eliminar la computadora con confirmación
  void _deleteComputadora(int id) async {
    // Mostrar cuadro de confirmación antes de eliminar
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar eliminación'),
          content:
              Text('¿Estás seguro de que deseas eliminar esta computadora?'),
          actions: [
            TextButton(
              onPressed: () {
                // Si el usuario cancela, cerrar el cuadro de diálogo
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                // Eliminar el producto si el usuario confirma
                await DatabaseHelper.instance.delete(id);
                _refreshComputadoras();

                // Mostrar mensaje de éxito con Snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Computadora eliminada correctamente')),
                );

                // Cerrar el cuadro de diálogo
                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _editComputadora(Computadora computadora) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => AgregarEditarScreen(computadora: computadora),
          ),
        )
        .then((_) => _refreshComputadoras());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computadoras'),
      ),
      body: FutureBuilder<List<Computadora>>(
        future: _computadoras,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final computadoras = snapshot.data!;

          return ListView.builder(
            itemCount: computadoras.length,
            itemBuilder: (context, index) {
              final computadora = computadoras[index];
              return ComputadoraTile(
                computadora: computadora,
                onDelete: () => _deleteComputadora(computadora.id!),
                onEdit: () => _editComputadora(computadora),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => AgregarEditarScreen(),
                ),
              )
              .then((_) => _refreshComputadoras());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
