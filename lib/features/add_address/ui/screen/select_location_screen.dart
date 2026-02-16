import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

// ========================================
// MAP SCREEN WITH CUSTOM MARKERS
// ========================================

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final Completer<GoogleMapController> _controllerCompleter = Completer();

  // Map markers
  final Set<Marker> _markers = {};

  // Initial camera position (Cairo, Egypt as example)
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(30.0444, 31.2357), // Cairo coordinates
    zoom: 14.0,
  );

  // Current location (you'll add your location service here)
  LatLng? _currentLocation;

  // Custom marker icons
  BitmapDescriptor? _customMarkerIcon;
  BitmapDescriptor? _storeMarkerIcon;
  BitmapDescriptor? _currentLocationIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarkers();
    // TODO: Add your location service here
    // _getCurrentLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  // ========================================
  // LOAD CUSTOM MARKER ICONS
  // ========================================

  Future<void> _loadCustomMarkers() async {
    // Method 1: Load from assets
    _customMarkerIcon = await _createMarkerFromAsset(
      'assets/pin-location.png',
      size: 120,
    );

    _storeMarkerIcon = await _createMarkerFromAsset(
      'assets/pin-location.png',
      size: 100,
    );

    // Method 2: Create custom marker from widget
    _currentLocationIcon = await _createMarkerFromWidget(
      _CustomMarkerWidget(
        color: Colors.blue,
        icon: Icons.person_pin_circle,
        size: 60,
      ),
    );

    // Add sample markers
    _addSampleMarkers();
  }

  // Create marker from asset image
  Future<BitmapDescriptor> _createMarkerFromAsset(
      String assetPath, {
        int size = 100,
      }) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: size,
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ByteData? byteData = await fi.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
    } catch (e) {
      print('Error loading marker: $e');
      // Return default marker if asset fails
      return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
    }
  }

  // Create marker from widget (for custom designs)
  Future<BitmapDescriptor> _createMarkerFromWidget(Widget widget) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final size = Size(120, 120);

    //final widgetToImage = RenderRepaintBoundary();
    // widgetToImage.layout(BoxConstraints(
    //   maxWidth: size.width,
    //   maxHeight: size.height,
    // ));

    final painter = WidgetPainter(widget: widget, size: size);
    painter.paint(canvas, size);

    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(
      size.width.toInt(),
      size.height.toInt(),
    );
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }



  void _addSampleMarkers() {
    setState(() {
      // Store locations (example)
      _markers.addAll([
        Marker(
          markerId: MarkerId('store_1'),
          position: LatLng(30.0444, 31.2357),
          icon: _storeMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Main Store',
            snippet: 'Open 9 AM - 9 PM',
          ),
          onTap: () => _onMarkerTapped('store_1'),
        ),
        Marker(
          markerId: MarkerId('store_2'),
          position: LatLng(30.0544, 31.2457),
          icon: _customMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Branch Store',
            snippet: 'Open 10 AM - 8 PM',
          ),
          onTap: () => _onMarkerTapped('store_2'),
        ),
        Marker(
          markerId: MarkerId('store_3'),
          position: LatLng(30.0344, 31.2257),
          icon: _storeMarkerIcon ?? BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Downtown Store',
            snippet: 'Open 24/7',
          ),
          onTap: () => _onMarkerTapped('store_3'),
        ),
      ]);

      // Add current location marker (if available)
      if (_currentLocation != null) {
        _markers.add(
          Marker(
            markerId: MarkerId('current_location'),
            position: _currentLocation!,
            icon: _currentLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
            infoWindow: InfoWindow(title: 'You are here'),
          ),
        );
      }
    });
  }

  void _onMarkerTapped(String markerId) {
    print('Marker tapped: $markerId');
    // Show bottom sheet with store details
    _showStoreDetails(markerId);
  }

  Future<void> _getCurrentLocation() async {
    // Example:
    // final position = await Geolocator.getCurrentPosition();
    // setState(() {
    //   _currentLocation = LatLng(position.latitude, position.longitude);
    // });
    // _addCurrentLocationMarker();
    // _animateToLocation(_currentLocation!);
  }

  void _addCurrentLocationMarker() {
    if (_currentLocation == null) return;

    setState(() {
      _markers.removeWhere((m) => m.markerId.value == 'current_location');
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation!,
          icon: _currentLocationIcon ?? BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          infoWindow: InfoWindow(
            title: 'You are here',
            snippet: 'Current location',
          ),
        ),
      );
    });
  }

  // ========================================
  // MAP CONTROLS
  // ========================================

  Future<void> _animateToLocation(LatLng location) async {
    final controller = await _controllerCompleter.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 16.0,
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controllerCompleter.isCompleted) {
      _controllerCompleter.complete(controller);
    }
    _mapController = controller;
  }

  // ========================================
  // UI METHODS
  // ========================================

  void _showStoreDetails(String storeId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _StoreDetailsSheet(storeId: storeId),
    );
  }

  // ========================================
  // BUILD
  // ========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Locations'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              // TODO: Call your location method here
              // _getCurrentLocation();
              _animateToLocation(_initialPosition.target);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onTap: (position) {
              print('Map tapped at: $position');
            },
          ),

          // Search bar overlay
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: _SearchBar(),
          ),

          // Zoom controls
          Positioned(
            right: 16,
            bottom: 100,
            child: _ZoomControls(
              onZoomIn: () async {
                final controller = await _controllerCompleter.future;
                controller.animateCamera(CameraUpdate.zoomIn());
              },
              onZoomOut: () async {
                final controller = await _controllerCompleter.future;
                controller.animateCamera(CameraUpdate.zoomOut());
              },
            ),
          ),

          // Current location button
          Positioned(
            right: 16,
            bottom: 30,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                // TODO: Add your location method
                // _getCurrentLocation();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Add your location service here'),
                  ),
                );
              },
              child: Icon(Icons.my_location, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

// ========================================
// CUSTOM MARKER WIDGET
// ========================================

class _CustomMarkerWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final double size;

  const _CustomMarkerWidget({
    required this.color,
    required this.icon,
    this.size = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: size * 0.6,
      ),
    );
  }
}

// ========================================
// SEARCH BAR
// ========================================

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for stores...',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        onChanged: (value) {
          // TODO: Implement search
          print('Searching for: $value');
        },
      ),
    );
  }
}

// ========================================
// ZOOM CONTROLS
// ========================================

class _ZoomControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const _ZoomControls({
    required this.onZoomIn,
    required this.onZoomOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FloatingActionButton(
          heroTag: 'zoom_in',
          mini: true,
          backgroundColor: Colors.white,
          onPressed: onZoomIn,
          child: Icon(Icons.add, color: Colors.black),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          heroTag: 'zoom_out',
          mini: true,
          backgroundColor: Colors.white,
          onPressed: onZoomOut,
          child: Icon(Icons.remove, color: Colors.black),
        ),
      ],
    );
  }
}

// ========================================
// STORE DETAILS BOTTOM SHEET
// ========================================

class _StoreDetailsSheet extends StatelessWidget {
  final String storeId;

  const _StoreDetailsSheet({required this.storeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.store, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Store Name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '2.5 km away',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 20),
          _InfoRow(
            icon: Icons.access_time,
            text: 'Open 9 AM - 9 PM',
          ),
          SizedBox(height: 12),
          _InfoRow(
            icon: Icons.location_on,
            text: '123 Main Street, Cairo',
          ),
          SizedBox(height: 12),
          _InfoRow(
            icon: Icons.phone,
            text: '+20 123 456 7890',
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to store
                  },
                  icon: Icon(Icons.directions),
                  label: Text('Directions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Call store
                  },
                  icon: Icon(Icons.phone),
                  label: Text('Call'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey),
        SizedBox(width: 12),
        Expanded(child: Text(text)),
      ],
    );
  }
}



class WidgetPainter extends CustomPainter {
  final Widget widget;
  final Size size;

  WidgetPainter({required this.widget, required this.size});

  @override
  void paint(Canvas canvas, Size size) {
    // This is a simplified version
    // For production, use RenderRepaintBoundary
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
