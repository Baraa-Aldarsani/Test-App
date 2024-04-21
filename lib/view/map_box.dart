import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:test_baraa/controller/controller.dart';

class MapBox extends StatelessWidget {
  MapBox({super.key});
  final _controller = Get.put(MapBoxController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FlutterMap(
        options: MapOptions(
            initialCenter: _controller.center.value,
            initialZoom: 12,
            onTap: (_, latlng) => _controller.addMarker(latlng)),
        children: [
          TileLayer(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/baraa-aldarsani/clhmjlvn701nt01pr84vn0bur/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYmFyYWEtYWxkYXJzYW5pIiwiYSI6ImNsaG1qMDVmbzFjYzIzZnM2aG5yaXBwcmYifQ.9OXu0PP5kUKps_So6nde0w',
            additionalOptions: const {
              'accessToken':
                  'pk.eyJ1IjoiYmFyYWEtYWxkYXJzYW5pIiwiYSI6ImNsaG1qMDVmbzFjYzIzZnM2aG5yaXBwcmYifQ.9OXu0PP5kUKps_So6nde0w',
            },
          ),
          MarkerLayer(markers: [
            if (_controller.marker.value != null) _controller.marker.value!
          ])
        ],
      ),
    );
  }
}
