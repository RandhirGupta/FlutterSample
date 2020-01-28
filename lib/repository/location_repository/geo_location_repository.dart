import 'package:flutter_sample_app/repository/location_repository/location_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationRepository implements LocationRepository {
  @override
  Future<Position> fetchPosition(LocationAccuracy locationAccuracy) async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: locationAccuracy);
  }
}
