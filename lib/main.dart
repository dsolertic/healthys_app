import 'package:flutter/material.dart';
import 'package:healthys_app/ui/screens/product_grid_screen.dart';
import 'package:healthys_app/ui/screens/product_list_screen.dart';
import 'package:healthys_app/ui/screens/producte_screen.dart';
// Llibreria del sistema per obtenir i forçar l'orientació
import 'package:flutter/services.dart';

void main() async {
  // Incialitzem Flutter de forma manual, abans de llançar runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Forcem el mode horitzontal
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Normal Portrait
    DeviceOrientation.portraitDown, // Upside-Down Portrait
  ]);

  // I ara llancem l'aplicació
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthys',
      debugShowCheckedModeBanner: false,
      home: LauncherScreen(),
    );
  }
}

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selecció de pantalla")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProductListScreen(),
                  ),
                );
              },
              child: const Text("Llista de productes"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProductGridScreen(),
                  ),
                );
              },
              child: const Text("Grid de productes"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProducteScreen(),
                  ),
                );
              },
              child: const Text("Informació d'un producte"),
            ),
          ],
        ),
      ),
    );
  }
}
