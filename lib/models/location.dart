class Location {
  final double lat;
  final double long;
  late String address;

  Location({
    required this.lat,
    required this.long,
    this.address = ''
  });
}
