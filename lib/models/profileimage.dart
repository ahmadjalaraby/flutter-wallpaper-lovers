class ProfileImage {
  late String small;
  late String medium;
  late String large;

  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  ProfileImage.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}
