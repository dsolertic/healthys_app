// Com que la vista dependrà d'un Future (la llista de productes que obteniim de l'API)
// la implementarem com un widget amb estat

import 'package:flutter/material.dart';

class CallToActionButton extends StatefulWidget {
  const CallToActionButton({super.key});

  @override
  State<CallToActionButton> createState() => _CallToActionButtonState();
}

class _CallToActionButtonState extends State<CallToActionButton> {
  int _quantitat = 0;

  @override
  Widget build(BuildContext context) {
    return _quantitat == 0
        ? InkWell(
            onTap: () {
              setState(() {
                _quantitat++;
              });
            },
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Afig al carret',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        : Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.outlined(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  onPressed: () {
                    setState(() {
                      _quantitat--;
                    });
                  },
                  icon: const Icon(Icons.remove, color: Colors.white),
                ),
                Text(
                  '$_quantitat',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton.outlined(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                  ),
                  onPressed: () {
                    setState(() {
                      _quantitat++;
                    });
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          );
  }
}
