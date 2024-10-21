import 'package:housify/core/domain/dtos/location.dto.dart';

class DashboardDTO {
  String? userName;
  String? userProfileImage;
  String? greetingText;
  String? pageText;
  String? buyOfferCount;
  String? rentOfferCount;
  List<LocationDTO>? locations;

  DashboardDTO(
      {this.userName,
      this.userProfileImage,
      this.greetingText,
      this.pageText,
      this.buyOfferCount,
      this.rentOfferCount,
      this.locations});

  DashboardDTO.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userProfileImage = json['userProfileImage'];
    greetingText = json['greetingText'];
    pageText = json['pageText'];
    buyOfferCount = json['buyOfferCount'];
    rentOfferCount = json['rentOfferCount'];
    if (json['locations'] != null) {
      locations = <LocationDTO>[];
      json['locations'].forEach((v) {
        locations!.add(LocationDTO.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['userProfileImage'] = userProfileImage;
    data['greetingText'] = greetingText;
    data['pageText'] = pageText;
    data['buyOfferCount'] = buyOfferCount;
    data['rentOfferCount'] = rentOfferCount;
    if (locations != null) {
      data['locations'] =
          locations!.map<Map<String, dynamic>>((v) => v.toJson()).toList();
    }
    return data;
  }
}
