class LocationDTO {
  String? address;
  double? longitude;
  double? latitude;
  String? imageUrl;
  String? distanceFromCurrent;
  bool? isOpen;

  LocationDTO({
    this.address,
    this.longitude,
    this.latitude,
    this.imageUrl,
    this.distanceFromCurrent,
    this.isOpen,
  });

  LocationDTO.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    imageUrl = json['imageUrl'];
    distanceFromCurrent = json['distanceFromCurrent'];
    isOpen = json['isOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['imageUrl'] = imageUrl;
    data['distanceFromCurrent'] = distanceFromCurrent;
    data['isOpen'] = isOpen;
    return data;
  }
}
