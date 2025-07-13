import 'package:flutter/material.dart';

class ComputeAmountsPage extends StatefulWidget {
  const ComputeAmountsPage({super.key});

  @override
  State<ComputeAmountsPage> createState() => _ComputeAmountsPageState();
}

class _ComputeAmountsPageState extends State<ComputeAmountsPage> {
  List<PlatPrice> platsJoris = [PlatPrice()];
  List<PlatPrice> platsLouis = [PlatPrice()];
  List<PlatPrice> platsMatteo = [PlatPrice()];
  List<PlatPrice> platsVincent = [PlatPrice()];

  final TextEditingController totalController = new TextEditingController(); 

  @override
  void dispose() {
    for (final p in platsJoris) p.dispose();
    for (final p in platsLouis) p.dispose();
    for (final p in platsMatteo) p.dispose();
    for (final p in platsVincent) p.dispose();
    super.dispose();
  }

  Widget buildDishSection(String name, List<PlatPrice> plats, VoidCallback onAddPlat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        for (int i = 0; i < plats.length; i++)
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: plats[i].priceController,
                  decoration: InputDecoration(labelText: "Dish ${i + 1}"),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              if (plats.length > 1)
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      plats.removeAt(i);
                    });
                  },
                )
            ],
          ),
        TextButton.icon(
          onPressed: onAddPlat,
          icon: Icon(Icons.add),
          label: Text("Add a dish"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildDishSection("Joris", platsJoris, () {
                  setState(() => platsJoris.add(PlatPrice()));
                }),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: buildDishSection("Louis", platsLouis, () {
                  setState(() => platsLouis.add(PlatPrice()));
                }),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: buildDishSection("Matteo", platsMatteo, () {
                  setState(() => platsMatteo.add(PlatPrice()));
                }),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: buildDishSection("Vincent", platsVincent, () {
                  setState(() => platsVincent.add(PlatPrice()));
                }),
              ),
            ],
          ),
          const SizedBox(height: 24),
          TextField(
            controller: totalController,
            decoration: InputDecoration(labelText: "Total"),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              double totalJoris = platsJoris.fold(0.0, (sum, p) {
                final value = double.tryParse(p.priceController.text) ?? 0.0;
                return sum + value;
              });
              double totalLouis = platsLouis.fold(0.0, (sum, p) {
                final value = double.tryParse(p.priceController.text) ?? 0.0;
                return sum + value;
              });
              double totalMatteo = platsMatteo.fold(0.0, (sum, p) {
                final value = double.tryParse(p.priceController.text) ?? 0.0;
                return sum + value;
              });
              double totalVincent = platsVincent.fold(0.0, (sum, p) {
                final value = double.tryParse(p.priceController.text) ?? 0.0;
                return sum + value;
              });
              double expectedTotal = totalJoris + totalLouis + totalMatteo + totalVincent;
              double realTotal = double.tryParse(totalController.text) ?? 0.0;

              double realJoris = totalJoris / expectedTotal * realTotal;
              double realLouis = totalLouis / expectedTotal * realTotal;
              double realMatteo = totalMatteo / expectedTotal * realTotal;
              double realVincent = totalVincent / expectedTotal * realTotal;

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("Recap"),
                  content: Text("Joris : ${realJoris.toStringAsFixed(2)}"
                      "\nLouis : ${realLouis.toStringAsFixed(2)}"
                      "\nMatteo : ${realMatteo.toStringAsFixed(2)}"
                      "\nVincent : ${realVincent.toStringAsFixed(2)}"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"))
                  ],
                ),
              );
            },
            child: const Text("Split!"),
          ),
        ],
      ),
    ),
  );
}
}

class PlatPrice {
  TextEditingController priceController = TextEditingController();

  void dispose() {
    priceController.dispose();
  }
}