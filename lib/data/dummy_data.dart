import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/game_model.dart';

Future<List<Game>> loadGamesJson() async {
  final String response = await rootBundle.loadString('assets/data/games.json');
  final data = await json.decode(response);
  return (data as List).map((e) => Game.fromJson(e)).toList();
}