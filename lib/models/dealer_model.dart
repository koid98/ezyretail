class DealerModel {
  String dealerId;
  String dealerPassword;
  String appId;
  String licenceKey;

  DealerModel({
    required this.dealerId,
    required this.dealerPassword,
    required this.appId,
    required this.licenceKey,
  });

  Map<String, dynamic> toJson() => {
        'email': dealerId,
        'password': dealerPassword,
        'app_id': appId,
        'license_key': licenceKey,
      };
}
