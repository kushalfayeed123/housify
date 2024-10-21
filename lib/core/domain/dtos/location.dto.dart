class LocationDTO {
  String? address;
  double? longitude;
  double? latitude;
  String? imageUrl;

  LocationDTO({this.address, this.longitude, this.latitude, this.imageUrl});

  LocationDTO.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
