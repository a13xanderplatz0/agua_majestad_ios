import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/address_model.dart';
import '../services/location_service.dart';

class AddressSelectionPage extends StatefulWidget {
  final String userId;
  const AddressSelectionPage({super.key, required this.userId});

  @override
  State<AddressSelectionPage> createState() => _AddressSelectionPageState();
}

class _AddressSelectionPageState extends State<AddressSelectionPage> {
  GoogleMapController? _mapController;
  LatLng? _selectedLatLng;
  String _selectedAddress = '';
  bool _isLoading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    setState(() => _isLoading = true);
    Position? position = await LocationService().getCurrentLocation();
    if (position != null) {
      _selectedLatLng = LatLng(position.latitude, position.longitude);
      await _updateAddressFromLatLng(_selectedLatLng!);
    }
    setState(() => _isLoading = false);
  }

  Future<void> _updateAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      setState(() {
        _selectedAddress = '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}';
      });
    } else {
      setState(() {
        _selectedAddress = 'Dirección no encontrada';
      });
    }
  }

  void _onCameraMove(CameraPosition position) {
    _selectedLatLng = position.target;
  }

  void _onCameraIdle() {
    if (_selectedLatLng != null) {
      _updateAddressFromLatLng(_selectedLatLng!);
    }
  }

  Future<void> _saveAddress() async {
    if (_selectedLatLng == null || _selectedAddress.isEmpty) return;
    setState(() => _saving = true);
    AddressModel? address = await LocationService().getAddressFromCoordinates(
      _selectedLatLng!.latitude,
      _selectedLatLng!.longitude,
      widget.userId,
    );
    setState(() => _saving = false);
    if (address != null) {
      // Aquí deberías guardar la dirección en tu base de datos
      if (mounted) {
        Navigator.pop(context, address);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo guardar la dirección.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu dirección'),
        backgroundColor: const Color(0xFF0066CC),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedLatLng!,
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (controller) => _mapController = controller,
                  onCameraMove: _onCameraMove,
                  onCameraIdle: _onCameraIdle,
                  markers: _selectedLatLng != null
                      ? {
                          Marker(
                            markerId: const MarkerId('selected'),
                            position: _selectedLatLng!,
                          ),
                        }
                      : {},
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Dirección seleccionada:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _selectedAddress,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: _saving
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                )
                              : const Icon(Icons.check),
                          label: const Text('Guardar dirección'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0066CC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: _saving ? null : _saveAddress,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
} 