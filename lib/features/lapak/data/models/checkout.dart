import 'dart:convert';

class CheckoutData {
    final String message;
    final Data data;

    CheckoutData({
        required this.message,
        required this.data,
    });

    CheckoutData copyWith({
        String? message,
        Data? data,
    }) => 
        CheckoutData(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory CheckoutData.fromRawJson(String str) => CheckoutData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CheckoutData.fromJson(Map<String, dynamic> json) => CheckoutData(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final String id;
    final String userId;
    final String orderNumber;
    final int totalAmount;
    final String status;
    final String paymentUrl;
    final String midtransOrderId;
    final dynamic productId;
    final int quantity;
    final dynamic amount;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<Item> items;
    final ShippingDetail shippingDetail;
    final String totalAmountFormatted;

    Data({
        required this.id,
        required this.userId,
        required this.orderNumber,
        required this.totalAmount,
        required this.status,
        required this.paymentUrl,
        required this.midtransOrderId,
        required this.productId,
        required this.quantity,
        required this.amount,
        required this.createdAt,
        required this.updatedAt,
        required this.items,
        required this.shippingDetail,
        required this.totalAmountFormatted,
    });

    Data copyWith({
        String? id,
        String? userId,
        String? orderNumber,
        int? totalAmount,
        String? status,
        String? paymentUrl,
        String? midtransOrderId,
        dynamic productId,
        int? quantity,
        dynamic amount,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Item>? items,
        ShippingDetail? shippingDetail,
        String? totalAmountFormatted,
    }) => 
        Data(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            orderNumber: orderNumber ?? this.orderNumber,
            totalAmount: totalAmount ?? this.totalAmount,
            status: status ?? this.status,
            paymentUrl: paymentUrl ?? this.paymentUrl,
            midtransOrderId: midtransOrderId ?? this.midtransOrderId,
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
            amount: amount ?? this.amount,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            items: items ?? this.items,
            shippingDetail: shippingDetail ?? this.shippingDetail,
            totalAmountFormatted: totalAmountFormatted ?? this.totalAmountFormatted,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["userId"],
        orderNumber: json["orderNumber"],
        totalAmount: json["totalAmount"],
        status: json["status"],
        paymentUrl: json["paymentUrl"],
        midtransOrderId: json["midtransOrderId"],
        productId: json["productId"],
        quantity: json["quantity"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        shippingDetail: ShippingDetail.fromJson(json["shippingDetail"]),
        totalAmountFormatted: json["totalAmountFormatted"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "orderNumber": orderNumber,
        "totalAmount": totalAmount,
        "status": status,
        "paymentUrl": paymentUrl,
        "midtransOrderId": midtransOrderId,
        "productId": productId,
        "quantity": quantity,
        "amount": amount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "shippingDetail": shippingDetail.toJson(),
        "totalAmountFormatted": totalAmountFormatted,
    };
}

class Item {
    final String id;
    final String transactionId;
    final String productId;
    final String productName;
    final int productPrice;
    final int quantity;
    final int subtotal;
    final DateTime createdAt;

    Item({
        required this.id,
        required this.transactionId,
        required this.productId,
        required this.productName,
        required this.productPrice,
        required this.quantity,
        required this.subtotal,
        required this.createdAt,
    });

    Item copyWith({
        String? id,
        String? transactionId,
        String? productId,
        String? productName,
        int? productPrice,
        int? quantity,
        int? subtotal,
        DateTime? createdAt,
    }) => 
        Item(
            id: id ?? this.id,
            transactionId: transactionId ?? this.transactionId,
            productId: productId ?? this.productId,
            productName: productName ?? this.productName,
            productPrice: productPrice ?? this.productPrice,
            quantity: quantity ?? this.quantity,
            subtotal: subtotal ?? this.subtotal,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        transactionId: json["transactionId"],
        productId: json["productId"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        quantity: json["quantity"],
        subtotal: json["subtotal"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "productId": productId,
        "productName": productName,
        "productPrice": productPrice,
        "quantity": quantity,
        "subtotal": subtotal,
        "createdAt": createdAt.toIso8601String(),
    };
}

class ShippingDetail {
    final String id;
    final String transactionId;
    final String recipientName;
    final String phoneNumber;
    final String address;
    final String city;
    final String province;
    final String postalCode;
    final String notes;
    final DateTime createdAt;
    final DateTime updatedAt;

    ShippingDetail({
        required this.id,
        required this.transactionId,
        required this.recipientName,
        required this.phoneNumber,
        required this.address,
        required this.city,
        required this.province,
        required this.postalCode,
        required this.notes,
        required this.createdAt,
        required this.updatedAt,
    });

    ShippingDetail copyWith({
        String? id,
        String? transactionId,
        String? recipientName,
        String? phoneNumber,
        String? address,
        String? city,
        String? province,
        String? postalCode,
        String? notes,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        ShippingDetail(
            id: id ?? this.id,
            transactionId: transactionId ?? this.transactionId,
            recipientName: recipientName ?? this.recipientName,
            phoneNumber: phoneNumber ?? this.phoneNumber,
            address: address ?? this.address,
            city: city ?? this.city,
            province: province ?? this.province,
            postalCode: postalCode ?? this.postalCode,
            notes: notes ?? this.notes,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory ShippingDetail.fromRawJson(String str) => ShippingDetail.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ShippingDetail.fromJson(Map<String, dynamic> json) => ShippingDetail(
        id: json["id"],
        transactionId: json["transactionId"],
        recipientName: json["recipientName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        city: json["city"],
        province: json["province"],
        postalCode: json["postalCode"],
        notes: json["notes"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "recipientName": recipientName,
        "phoneNumber": phoneNumber,
        "address": address,
        "city": city,
        "province": province,
        "postalCode": postalCode,
        "notes": notes,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
