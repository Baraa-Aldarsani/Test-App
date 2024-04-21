// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:test_baraa/core/constant.dart';

class MapBoxController extends GetxController {
  var marker = Rx<Marker?>(null);
  var center = const LatLng(33.514377, 36.310482).obs;
  late LatLng latlong;
  void addMarker(LatLng latlng) {
    Marker newMarker = Marker(
      width: 80.0,
      height: 80.0,
      point: latlng,
      child:  Icon(Icons.location_on, color: primaryColor, size: 40.0),
    );
    marker.value = newMarker;
    center(latlng);
    latlong = latlng;
  }
}
