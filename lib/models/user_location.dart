class UserLocation {
  final String city;
  final String state;
  final String country;
  final String postcode;
  final StreetLocation street;
  final Locationcoordinates coordinates;
  final LocationTimezone timezone;

  UserLocation({
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.street,
    required this.coordinates,
    required this.timezone,
  });

  factory UserLocation.fromMap(Map<String, dynamic> json) {
    final street = StreetLocation.fromMap(json['street']);
    final coordinates = Locationcoordinates.fromMap(json['coordinates']);
    final timeZone = LocationTimezone.fromMap(json['timezone']);

    return UserLocation(
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postcode: json['postcode'].toString(),
      street: street,
      coordinates: coordinates,
      timezone: timeZone,
    );
  }
}

class StreetLocation {
  final int number;
  final String name;
  StreetLocation({
    required this.number,
    required this.name,
  });
  factory StreetLocation.fromMap(Map<String, dynamic> json) {
    return StreetLocation(
      number: json['number'],
      name: json['name'],
    );
  }
}

class Locationcoordinates {
  final String latitude;
  final String longitude;
  Locationcoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory Locationcoordinates.fromMap(Map<String, dynamic> json) {
    return Locationcoordinates(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class LocationTimezone {
  final String offset;
  final String description;
  LocationTimezone({
    required this.offset,
    required this.description,
  });

  factory LocationTimezone.fromMap(Map<String, dynamic> json) {
    return LocationTimezone(
      offset: json['offset'],
      description: json['description'],
    );
  }
}
