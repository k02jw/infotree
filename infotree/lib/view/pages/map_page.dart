import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('주변 제휴 업체')),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(37.5563, 126.9996),
          initialZoom: 17,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // OpenStreetMap 타일
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(37.5563, 126.9996),
                child: Container(
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ), // 마커 아이콘
                ),
              ),

              Marker(
                point: LatLng(37.5573, 126.9986),
                child: Container(
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ), // 마커 아이콘
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
