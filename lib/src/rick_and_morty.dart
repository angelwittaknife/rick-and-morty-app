import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/router/router.dart';

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

