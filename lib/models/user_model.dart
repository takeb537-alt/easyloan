class UserModel {
  final String phoneNumber;
  final String deviceId;
  final String fullName;
  final String panCard;
  final String dob;
  final String upiId;
  final String address;
  final String faceImagePath;
  int onTimePayments;
  bool isBlacklisted;

  UserModel({
    required this.phoneNumber,
    required this.deviceId,
    required this.fullName,
    required this.panCard,
    required this.dob,
    required this.upiId,
    required this.address,
    required this.faceImagePath,
    this.onTimePayments = 0,
    this.isBlacklisted = false,
  });

  Map<String, dynamic> toJson() => {
    'phoneNumber': phoneNumber,
    'deviceId': deviceId,
    'fullName': fullName,
    'panCard': panCard,
    'dob': dob,
    'upiId': upiId,
    'address': address,
    'faceImagePath': faceImagePath,
    'onTimePayments': onTimePayments,
    'isBlacklisted': isBlacklisted,
  };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    phoneNumber: json['phoneNumber'],
    deviceId: json['deviceId'],
    fullName: json['fullName'],
    panCard: json['panCard'],
    dob: json['dob'],
    upiId: json['upiId'],
    address: json['address'],
    faceImagePath: json['faceImagePath'],
    onTimePayments: json['onTimePayments'] ?? 0,
    isBlacklisted: json['isBlacklisted'] ?? false,
  );
}
