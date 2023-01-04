class Location {
  final double lat;
  final double long;
  final String address;

  const Location({
    required this.lat,
    required this.long,
    this.address = ''
  });

  Location.addAdress(Location location, String address) : this(
    address: address,
    lat: location.lat,
    long: location.long
  );
}
