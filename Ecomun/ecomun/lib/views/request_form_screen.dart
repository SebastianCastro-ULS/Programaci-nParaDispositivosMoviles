import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/materials_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/requests_viewmodel.dart';
import '../models/request_model.dart';

class RequestFormScreen extends StatefulWidget {
  const RequestFormScreen({super.key});

  @override
  State<RequestFormScreen> createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMaterial;
  final _qtyCtrl = TextEditingController();
  DateTime _date = DateTime.now();
  final _obsCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final mv = context.read<MaterialsViewModel>();
      if (mv.materials.isEmpty) {
        mv.loadMaterials();
      }
    });
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    _obsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mv = context.watch<MaterialsViewModel>();
    final auth = context.read<AuthViewModel>();
    final rv = context.read<RequestsViewModel>();

    if (mv.loading && mv.materials.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nueva solicitud')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (mv.error != null && mv.materials.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Nueva solicitud')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${mv.error}'),
              ElevatedButton(
                onPressed: () => mv.loadMaterials(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva solicitud')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  items: mv.materials
                      .map((m) => DropdownMenuItem(
                            value: m.id,
                            child: Text(m.name),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedMaterial = v),
                  initialValue: _selectedMaterial,
                  decoration: const InputDecoration(labelText: 'Material'),
                  validator: (v) => v == null ? 'Selecciona un material' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _qtyCtrl,
                  decoration: const InputDecoration(labelText: 'Cantidad (kg)'),
                  keyboardType: TextInputType.number,
                  validator: (v) => (v == null || double.tryParse(v) == null)
                      ? 'Ingresa una cantidad válida'
                      : null,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('Fecha:'),
                    const SizedBox(width: 12),
                    Text(_date.toLocal().toString().split(' ')[0]),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (d != null) setState(() => _date = d);
                      },
                      child: const Text('Cambiar'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _obsCtrl,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: rv.loading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) return;
                            final user = auth.user!;
                            final r = RequestModel(
                              id: 'tmp',
                              userId: user.id,
                              materialId: _selectedMaterial!,
                              quantity: double.parse(_qtyCtrl.text),
                              date: _date,
                              observations: _obsCtrl.text,
                            );
                            final success = await rv.create(r);
                            if (!mounted) return;
                            
                            if (success) {
                              context.pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Solicitud creada exitosamente')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Error: ${rv.error}')),
                              );
                            }
                          },
                    child: rv.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Enviar solicitud'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}