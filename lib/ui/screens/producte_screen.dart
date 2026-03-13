// Com que la vista dependrà d'un Future (la llista de productes que obteniim de l'API)
// la implementarem com un widget amb estat
import 'package:flutter/material.dart';
import 'package:healthys_app/domain/entities/beguda.dart';
import 'package:healthys_app/domain/entities/entrant.dart';
import 'package:healthys_app/domain/entities/principal.dart';
import 'package:healthys_app/domain/entities/producte.dart';
import 'package:healthys_app/ui/widgets/call_to_action_button.dart';
import 'package:healthys_app/ui/widgets/llista_alergens.dart';
import 'package:healthys_app/ui/widgets/llista_dietes.dart';

class ProducteScreen extends StatelessWidget {
  ProducteScreen({super.key});

  // Des d'aci podem provar diferents tipus de productes
  // Com que Entrant, Principal i Beguda deriven de Producte,
  // podem er ús de la classe genèrica.
  final Producte producte = obtenirEntrant();
  //final Producte producte = obtenirPrincipal();
  //final Producte producte = obtenirBeguda();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Healthys')),
      // El cos principal dependrà de la llista de productes, que és un
      // Future. Per tant fem ús del FutureBuilder:
      body: Column(
        children: [
          Stack(
            children: [
              producte.img != null
                  ? Image.network(producte.img!, fit: BoxFit.cover)
                  : Image.asset(
                      "assets/img/not_found.png",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
              Positioned(
                // Posicionem el títol a 32 píxels lògics de dalt i els costats
                left: 32,
                top: 32,
                right: 32,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        producte.name,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 8.0),
                              ],
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      width:
                          16, // Deixem 16 píxels lògics entre nom i preu del producte
                    ),
                    Text(
                      "${producte.price}€",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: Colors.amberAccent,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 8.0),
                            ],
                          ),
                    ),
                  ],
                ),
              ),
              Positioned(
                // La informació del producte a 32 píxels
                // lògics d'esquerra, dreta i part inferior
                left: 32,
                right: 32,
                bottom: 32,
                child: Text(
                  producte.additionalInfo ?? "",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 8.0)],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          Expanded(
            // Hem d'afegir un Expanded per a que ocupe tota la mida possible. Si no, no sap restriccions i dóna error.
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  LiniaProducte(
                    clau: "Ingredients",
                    valor: producte.description,
                  ),
                  LlistaAlergens(alergens: producte.allergens),
                  producte.getClass() == ProductsType.entrant
                      ? LlistaDietes(dietes: (producte as Entrant).dietType)
                      : producte.getClass() == ProductsType.principal
                      ? LlistaDietes(dietes: (producte as Principal).dietType)
                      : (producte as Beguda).isAlcoholic
                      ? Text("Beguda amb alcohol")
                      : Text("Beguda sense alcohol"),
                  LiniaProducte(
                    clau: "Calories",
                    valor: "${producte.calories} cal",
                  ),

                  // Al final afegim un botó per afegir el producte al carret
                  CallToActionButton(), // Aquest serà el widget que haurem d'implementar
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LiniaProducte extends StatelessWidget {
  const LiniaProducte({super.key, required this.clau, required this.valor});

  final String clau;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          clau,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
          child: Text(valor, style: Theme.of(context).textTheme.bodyMedium),
        ),

        // Fila 2
      ],
    );
  }
}

// Funcions per crear un plat de cada tipus. En versions posteriors aquesta
// informació vindrà d'altra vista

Entrant obtenirEntrant() {
  return Entrant.fromJson({
    "id": "ENT01",
    "name": "Amanida mediterrània",
    "description":
        "Enciam, tomàquet, cogombre, olives, formatge feta i vinagreta.",
    "tipus": "amanides",
    "allergens": ["Llet"],
    "price": 9,
    "calories": 220,
    "dietType": ["Sense gluten", "Vegetarià"],
    "additionalInfo": "Fresca i lleugera.",
    "img": "img/amanida_mediterrania.png",
  }, "https://healthys-express-backend-production.up.railway.app");
}

Principal obtenirPrincipal() {
  return Principal.fromJson({
    "id": "PRI01",
    "name": "Poke de tonyina",
    "description":
        "Poke de tonyina fresca amb alvocat, ceba, alga nori, i salsa de soja.",
    "tipus": "pokes",
    "allergens": ["Peix", "Sèsam"],
    "price": 12,
    "calories": 350,
    "dietType": ["Sense gluten", "Alta en proteïnes"],
    "additionalInfo":
        "Ric en omega 3 i perfecte per a una dieta alta en proteïnes.",
    "img": "img/poke_tonyina.png",
  }, "https://healthys-express-backend-production.up.railway.app");
}

Beguda obtenirBeguda() {
  return Beguda.fromJson({
    "id": "BEG01",
    "name": "Kombucha de gingebre i llimona",
    "description":
        "Kombucha refrescant amb gingebre natural i un toc de llimona.",
    "tipus": "kombuches",
    "allergens": [],
    "price": 3.5,
    "calories": 60,
    "isAlcoholic": false,
    "additionalInfo": "Una opció ideal per millorar la digestió.",
    "img": "img/kombucha_gingebre.png",
  }, "https://healthys-express-backend-production.up.railway.app");
}
