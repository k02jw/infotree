import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:infotree/model/benefit_data.dart';
import 'package:infotree/model/dummy/dummy_benefits.dart';
import 'package:infotree/view/map_list_view.dart';
import 'package:provider/provider.dart';
import 'package:infotree/model/data.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final MapController _mapController;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  List<BenefitData> getSortedBenefitsByDistance() {
    final base = _currentLocation ?? const LatLng(37.5563, 126.9996);
    final distance = const Distance();
    final benefits =
        dummyBenefits
            .where((b) => b.latitude != null && b.longitude != null)
            .toList();
    benefits.sort((a, b) {
      final da = distance(base, LatLng(a.latitude!, a.longitude!));
      final db = distance(base, LatLng(b.latitude!, b.longitude!));
      return da.compareTo(db);
    });
    return benefits;
  }

  void moveTo(LatLng target) {
    _mapController.move(target, _mapController.camera.zoom);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, data, child) {
        final base = _currentLocation ?? const LatLng(37.5563, 126.9996);
        final distance = const Distance();

        final benefits =
            data.benefitGroups.values
                .expand((list) => list)
                .where((b) => b.latitude != null && b.longitude != null)
                .toList();

        benefits.sort((a, b) {
          final da = distance(base, LatLng(a.latitude!, a.longitude!));
          final db = distance(base, LatLng(b.latitude!, b.longitude!));
          return da.compareTo(db);
        });

        final markers = [
          ...benefits.map(
            (b) => Marker(
              width: 40,
              height: 40,
              point: LatLng(b.latitude!, b.longitude!),
              child: Tooltip(
                message: b.title,
                child: const Icon(Icons.location_on, color: Colors.red),
              ),
            ),
          ),
          if (_currentLocation != null)
            Marker(
              width: 36,
              height: 36,
              point: _currentLocation!,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
        ];

        return Scaffold(
          appBar: AppBar(title: const Text('내 주변 혜택')),
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(initialCenter: base, initialZoom: 16),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.25,
                minChildSize: 0.15,
                maxChildSize: 0.6,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: MapListView(
                      items: benefits,
                      scrollController: scrollController,
                      onItemTap: (b) {
                        if (b.latitude != null && b.longitude != null) {
                          moveTo(LatLng(b.latitude!, b.longitude!));
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
