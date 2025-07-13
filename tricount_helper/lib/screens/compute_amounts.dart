import 'package:flutter/material.dart';

class ComputeAmountsPage extends StatefulWidget {
  const ComputeAmountsPage({super.key});

  @override
  State<ComputeAmountsPage> createState() => _ComputeAmountsPageState();
}

class _ComputeAmountsPageState extends State<ComputeAmountsPage> {
  final _formKey = GlobalKey<FormState>();

  List<DishPrice> dishesJoris = [DishPrice()];
  List<DishPrice> dishesLouis = [DishPrice()];
  List<DishPrice> dishesMatteo = [DishPrice()];
  List<DishPrice> dishesVincent = [DishPrice()];

  final TextEditingController totalController = new TextEditingController(); 

  @override
  void dispose() {
    for (final p in dishesJoris) p.dispose();
    for (final p in dishesLouis) p.dispose();
    for (final p in dishesMatteo) p.dispose();
    for (final p in dishesVincent) p.dispose();
    super.dispose();
  }

  Widget buildDishSection(String name, List<DishPrice> dishes, VoidCallback onAddDish) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (int i = 0; i < dishes.length; i++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: dishes[i].priceController,
                  decoration: InputDecoration(labelText: "Dish ${i + 1}"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: dishes[i].partController,
                  decoration: const InputDecoration(labelText: "Part"),
                ),
              ),
              if (dishes.length > 1)
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      dishes.removeAt(i);
                    });
                  },
                )
            ],
          ),
        TextButton.icon(
          onPressed: onAddDish,
          icon: const Icon(Icons.add),
          label: const Text("Add a dish"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildDishSection("Joris", dishesJoris, () {
                      setState(() => dishesJoris.add(DishPrice()));
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildDishSection("Louis", dishesLouis, () {
                      setState(() => dishesLouis.add(DishPrice()));
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: buildDishSection("Matteo", dishesMatteo, () {
                      setState(() => dishesMatteo.add(DishPrice()));
                    }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: buildDishSection("Vincent", dishesVincent, () {
                      setState(() => dishesVincent.add(DishPrice()));
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: totalController,
                decoration: const InputDecoration(labelText: "Total"),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a total amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;
                  
                  double getTotalFor(List<DishPrice> dishes) {
                    return dishes.fold(0.0, (sum, p) {
                      final price = double.tryParse(p.priceController.text) ?? 0.0;
                      final part = parseFraction(p.partController.text) ?? 1.0;
                      return sum + (price * (part / 100));
                    });
                  }

                  double totalJoris = getTotalFor(dishesJoris);
                  double totalLouis = getTotalFor(dishesLouis);
                  double totalMatteo = getTotalFor(dishesMatteo);
                  double totalVincent = getTotalFor(dishesVincent);
                  double expectedTotal = totalJoris + totalLouis + totalMatteo + totalVincent;
                  double realTotal = double.tryParse(totalController.text) ?? 0.0;

                  double realJoris = totalJoris / expectedTotal * realTotal;
                  double realLouis = totalLouis / expectedTotal * realTotal;
                  double realMatteo = totalMatteo / expectedTotal * realTotal;
                  double realVincent = totalVincent / expectedTotal * realTotal;

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Recap"),
                      content: Text("Joris : ${realJoris.toStringAsFixed(2)}"
                          "\nLouis : ${realLouis.toStringAsFixed(2)}"
                          "\nMatteo : ${realMatteo.toStringAsFixed(2)}"
                          "\nVincent : ${realVincent.toStringAsFixed(2)}"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK")
                        )
                      ],
                    ),
                  );
                },
                child: const Text("Split!"),
              ),
            ],
          )
        ),
      ),
    );
  }
}

class DishPrice {
  TextEditingController priceController = TextEditingController();
  TextEditingController partController = TextEditingController(text: "100");

  void dispose() {
    priceController.dispose();
  }
}

double? parseFraction(String input) {
  input = input.trim();
  if (input.contains('/')) {
    final parts = input.split('/');
    if (parts.length == 2) {
      final numerator = double.tryParse(parts[0]);
      final denominator = double.tryParse(parts[1]);
      if (numerator != null && denominator != null && denominator != 0) {
        return numerator / denominator;
      }
    }
    return 0.0; // Valeur par défaut en cas d'erreur
  }
  return double.tryParse(input);
}