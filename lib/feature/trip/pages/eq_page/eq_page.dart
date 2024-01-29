import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/base/base_state.dart';
import '../../../../domain/model/model/eq_model.dart';
import 'eq_vm.dart';

class EquipmentPage extends StatefulWidget {
  final String tripId;
  const EquipmentPage({super.key, required this.tripId});

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends BaseState<EquipmentPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final vm = Provider.of<EquipmentVM>(context, listen: false);
      vm.getEqItems(widget.tripId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<EquipmentVM>(context);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            onAddEqItem();
          },
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: vm.eqItems.length,
          itemBuilder: (context, index) {
            final item = vm.eqItems[index];
            return ListTile(
              title: Text(item.name),
              trailing: IconButton(
                onPressed: () {
                  vm.deleteEqItem(item.id, widget.tripId);
                },
                icon: const Icon(Icons.delete),
              ),
            );
          },
        ));
  }

  onAddEqItem() {
    final vm = Provider.of<EquipmentVM>(context, listen: false);

    showDialog(
        context: context,
        builder: (context) {
          final form = fb.group({
            'name': ['', Validators.required],
            'amount': ['', Validators.required, Validators.number],
          });
          return AlertDialog(
            title: const Text('Додати спорядження'),
            content: ReactiveForm(
              formGroup: form,
              child: Column(
                children: [
                  ReactiveTextField(
                    formControlName: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Назва',
                    ),
                  ),
                  ReactiveTextField(
                    formControlName: 'amount',
                    decoration: const InputDecoration(
                      labelText: 'Вага',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    await vm.addOrUpdateEqItem(
                        EqModel(
                            id: const Uuid().v4(),
                            name: form.control('name').value,
                            amount:
                                double.tryParse(form.control('amount').value)),
                        widget.tripId);
                  },
                  child: const Text('Add'))
            ],
          );
        });
  }
}
