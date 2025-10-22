import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/environment/service_locator.dart';
import 'package:rick_and_morty/src/rick_and_morty.dart';


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(const RickAndMorty());
}


