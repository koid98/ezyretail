class StateModel {
  String code;
  String postcode;
  String stateCode;
  String city;
  String stateName;

  StateModel({
    required this.code,
    required this.postcode,
    required this.stateCode,
    required this.city,
    required this.stateName,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    code: json["code"],
    postcode: json["postcode"],
    stateCode: json["state_code"],
    city: json["city"],
    stateName: json["state_name"],
  );
}
