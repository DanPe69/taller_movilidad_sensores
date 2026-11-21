
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ParkService {
  static Future<List<dynamic>> fetchNearbyParks(
    double lat,
    double lon,
  ) async {
    final query =
        '[out:json]; node["leisure"="park"](around:3000,$lat,$lon); out 20;';

    final url = Uri.parse(
      'https://overpass-api.de/api/interpreter?data=${Uri.encodeComponent(query)}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(utf8.decode(response.bodyBytes));

        final List<dynamic> elements = data['elements'] ?? [];

        return elements.map((e) {
          final Map<dynamic, dynamic> tags =
              e['tags'] is Map ? e['tags'] : {};

          return {
            'name': tags['name'] ?? 'Parque Público',
            'lat': e['lat'],
            'lon': e['lon'],
          };
        }).toList();
      }
    } catch (e) {
      debugPrint('Error al consultar API de parques: $e');
    }

    return [];
  }
}
