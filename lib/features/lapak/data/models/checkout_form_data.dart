class CheckoutFormData {
  final String recipientName;
  final String phoneNumber;
  final String address;
  final String city;
  final String province;
  final String postalCode;

  CheckoutFormData({
    required this.recipientName,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.province,
    required this.postalCode,
  });

  Map<String, dynamic> toJson() => {
        'recipientName': recipientName,
        'phoneNumber': phoneNumber,
        'address': address,
        'city': city,
        'province': province,
        'postalCode': postalCode,
      };

  factory CheckoutFormData.fromJson(Map<String, dynamic> json) => CheckoutFormData(
        recipientName: json['recipientName'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        city: json['city'],
        province: json['province'],
        postalCode: json['postalCode'],
      );
}
