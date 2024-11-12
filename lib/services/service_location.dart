import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  // Verificar permisos
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Los servicios de ubicación están desactivados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Los permisos de ubicación fueron denegados');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.');
    }

    return true;
  }

  // Obtener ubicación actual
  Future<String> getCurrentLocation() async {
    try {
      // Verificar permisos primero
      await _handleLocationPermission();

      // Obtener posición actual
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
      );

      // Convertir coordenadas a dirección
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Formatear dirección
        return '${place.locality}, ${place.administrativeArea}, ${place.country}';
      }

      // Si no se puede obtener la dirección, retornar coordenadas
      return '${position.latitude}, ${position.longitude}';

    } catch (e) {
      print('Error al obtener ubicación: $e');
      return 'No disponible';
    }
  }
}