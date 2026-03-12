import 'package:flutter/material.dart';
import 'package:healthys_app/data/repositories/carta_repository.dart';
import 'package:healthys_app/domain/entities/producte.dart';
import 'package:healthys_app/ui/widgets/grid_item.dart';

// Com que la vista dependrà d'un Future (la llista de productes que obteniim de l'API)
// la implementarem com un widget amb estat
class ProductGridScreen extends StatefulWidget {
  const ProductGridScreen({super.key});

  // Definim la referència a l'estat
  @override
  State<ProductGridScreen> createState() => _ProductGridScreenState();
}

// Definim la classe estat (esta és la que fa implementa el build cada vegada
// que canvia l'estat)
class _ProductGridScreenState extends State<ProductGridScreen> {
  // Propietats de l'estat
  // La llista de productes vindrà en un Future. Com que li donarem valor en
  // la inicialització de l'estat (initState), l'hem de declarar com a "late"
  late Future<List<Producte>> _llistaProductes;
  // Referència al repositori, d'on obtindrem la llista de productes
  final CartaRepository _repository = CartaRepository(
    "https://healthys-express-backend-production.up.railway.app", // Definim la referència al repositori
  );

  @override
  void initState() {
    // Mètode per inicialitzar l'estat
    super.initState();
    // Inicialitzem la llista de productes, en aquest cas, agafem els entrants
    // Podeu provar també a fer ús de les begudes o els plats principals
    // (En una tasca posterior ja reutilitzarem estes vistes per mostrar els tres
    // tipus de productes)
    _llistaProductes = _repository.getEntrants();
  }

  @override
  Widget build(BuildContext context) {
    // Mètode per construir el widget. Retornem un Scaffold complet, amb
    // barra superior, i un Body.
    return Scaffold(
      appBar: AppBar(title: const Text('Healthys')),
      // El cos principal dependrà de la llista de productes, que és un
      // Future. Per tant fem ús del FutureBuilder:
      body: Padding(
        padding: const EdgeInsets.all(8.0),

        // TO-DO 1:
        // Reemplaçar pel FutureBuilder, que cree un GridView amb
        // les diferents targetes
        child: Placeholder(),
      ),
    );
  }
}
