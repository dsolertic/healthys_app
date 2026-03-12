// TO-DO 2:
// classe GridItem: Widget sense estat per representar 
// amb una targeta el producte (imatge i nom)

/*
L'estructura del widget serà la següent:

Card
├─ elevation: 4                                        // Altura 4, per posar-li ombra
├─ clipBehavior: Clip.antiAlias                        // Retalla la imatge amb les vores arrodonides
└─ child: Column
   ├─ crossAxisAlignment: CrossAxisAlignment.stretch   // Estira el contingut
   └─ children:
      │
      ├─ Flexible
      │  ├─ flex: 8                                    // Ocupa aproximadament el 72% de l'altura (8 de 11)
      │  └─ child:
      │     ├─ (if producte.img != null)               // Segons el contingut de img afegim una o altra imatge
      │     │    └─ Image.network                      // (igual que en el ListView)
      │     │       ├─ src: producte.img ?? ""
      │     │       └─ fit: BoxFit.cover
      │     │
      │     └─ (else)
      │          └─ Image.asset
      │             ├─ asset: "assets/img/not_found.png"
      │             └─ fit: BoxFit.cover
      │
      └─ Flexible
         ├─ flex: 3                                  //  Ocupa aproximadament el 28% de l'altura (3 de 11)
         └─ child:
            └─ Text
               ├─ data: producte.name
               └─ style


Recordeu que teniu l'snippen statelessW que vos genera l'esquelet 
d'un widget sense estat.

*/