import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/computadora.dart';

class AgregarEditarScreen extends StatefulWidget {
  final Computadora? computadora;

  AgregarEditarScreen({this.computadora});

  @override
  _AgregarEditarScreenState createState() => _AgregarEditarScreenState();
}

class _AgregarEditarScreenState extends State<AgregarEditarScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _procesador;
  late String _discoDuro;
  late String _ram;

  @override
  void initState() {
    super.initState();
    if (widget.computadora != null) {
      _procesador = widget.computadora!.procesador;
      _discoDuro = widget.computadora!.discoDuro;
      _ram = widget.computadora!.ram;
    } else {
      _procesador = '';
      _discoDuro = '';
      _ram = '';
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Computadora computadora = Computadora(
        id: widget.computadora?.id, // Si estamos editando, mantener el ID.
        procesador: _procesador,
        discoDuro: _discoDuro,
        ram: _ram,
      );

      if (widget.computadora == null) {
        // Agregar nueva computadora
        await DatabaseHelper.instance.insert(computadora);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Computadora agregada correctamente')),
        );
      } else {
        // Editar computadora existente
        await DatabaseHelper.instance.update(computadora);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Computadora actualizada correctamente')),
        );
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.computadora == null
            ? 'Agregar Computadora'
            : 'Editar Computadora'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _procesador,
                decoration: InputDecoration(labelText: 'Procesador'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el procesador' : null,
                onSaved: (value) => _procesador = value!,
              ),
              TextFormField(
                initialValue: _discoDuro,
                decoration: InputDecoration(labelText: 'Disco Duro'),
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el disco duro' : null,
                onSaved: (value) => _discoDuro = value!,
              ),
              TextFormField(
                initialValue: _ram,
                decoration: InputDecoration(labelText: 'RAM'),
                validator: (value) => value!.isEmpty ? 'Ingrese la RAM' : null,
                onSaved: (value) => _ram = value!,
              ),
              SizedBox(height: 20),
              // Botón con icono para Agregar o Actualizar
              ElevatedButton.icon(
                onPressed: _submit,
                icon: Icon(widget.computadora == null
                    ? Icons.add // Icono de agregar si es nuevo
                    : Icons.edit), // Icono de editar si se está actualizando
                label:
                    Text(widget.computadora == null ? 'Agregar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
