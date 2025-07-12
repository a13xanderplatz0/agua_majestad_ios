import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/address_model.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  // Verificar y solicitar permisos de ubicación
  Future<bool> requestLocationPermission() async {
    try {
      // Verificar si los servicios de ubicación están habilitados
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Los servicios de ubicación están deshabilitados');
      }

      // Verificar permisos
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Permisos de ubicación denegados');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Los permisos de ubicación están permanentemente denegados');
      }

      return true;
    } catch (e) {
      print('Error al solicitar permisos de ubicación: $e');
      return false;
    }
  }

  // Obtener ubicación actual
  Future<Position?> getCurrentLocation() async {
    try {
      bool hasPermission = await requestLocationPermission();
      if (!hasPermission) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
    } catch (e) {
      print('Error al obtener ubicación actual: $e');
      return null;
    }
  }

  // Obtener dirección desde coordenadas
  Future<AddressModel?> getAddressFromCoordinates(
    double latitude, 
    double longitude,
    String userId,
  ) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        
        return AddressModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          userId: userId,
          street: '${place.street ?? ''} ${place.subThoroughfare ?? ''}'.trim(),
          city: place.locality ?? '',
          state: place.administrativeArea ?? '',
          postalCode: place.postalCode ?? '',
          country: place.country ?? '',
          latitude: latitude,
          longitude: longitude,
          fullAddress: '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }
      return null;
    } catch (e) {
      print('Error al obtener dirección desde coordenadas: $e');
      return null;
    }
  }

  // Obtener coordenadas desde dirección
  Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return Position(
          latitude: locations.first.latitude,
          longitude: locations.first.longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
      }
      return null;
    } catch (e) {
      print('Error al obtener coordenadas desde dirección: $e');
      return null;
    }
  }

  // Calcular distancia entre dos puntos
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2);
  }

  // Verificar si una ubicación está dentro del área de servicio
  bool isWithinServiceArea(double latitude, double longitude) {
    // Coordenadas del centro de servicio (ejemplo)
    const double serviceCenterLat = 19.4326; // Ciudad de México
    const double serviceCenterLon = -99.1332;
    const double serviceRadius = 50000; // 50 km en metros

    double distance = calculateDistance(
      latitude, 
      longitude, 
      serviceCenterLat, 
      serviceCenterLon,
    );

    return distance <= serviceRadius;
  }

  // Obtener dirección actual del usuario
  Future<AddressModel?> getCurrentUserAddress(String userId) async {
    try {
      Position? position = await getCurrentLocation();
      if (position != null) {
        return await getAddressFromCoordinates(
          position.latitude,
          position.longitude,
          userId,
        );
      }
      return null;
    } catch (e) {
      print('Error al obtener dirección actual del usuario: $e');
      return null;
    }
  }

  // Validar dirección
  bool validateAddress(AddressModel address) {
    return address.isComplete && 
           address.latitude != 0.0 && 
           address.longitude != 0.0;
  }

  // Formatear distancia para mostrar
  String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()} m';
    } else {
      double distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(1)} km';
    }
  }
} 