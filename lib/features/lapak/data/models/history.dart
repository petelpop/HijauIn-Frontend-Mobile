import 'dart:convert';

class HistoryData {
    final String message;
    final List<Datum> data;

    HistoryData({
        required this.message,
        required this.data,
    });

    HistoryData copyWith({
        String? message,
        List<Datum>? data,
    }) => 
        HistoryData(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory HistoryData.fromRawJson(String str) => HistoryData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
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

    Datum({
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

    Datum copyWith({
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
        Datum(
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

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    final String productPriceFormatted;
    final String subtotalFormatted;

    Item({
        required this.id,
        required this.transactionId,
        required this.productId,
        required this.productName,
        required this.productPrice,
        required this.quantity,
        required this.subtotal,
        required this.createdAt,
        required this.productPriceFormatted,
        required this.subtotalFormatted,
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
        String? productPriceFormatted,
        String? subtotalFormatted,
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
            productPriceFormatted: productPriceFormatted ?? this.productPriceFormatted,
            subtotalFormatted: subtotalFormatted ?? this.subtotalFormatted,
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
        productPriceFormatted: json["productPriceFormatted"],
        subtotalFormatted: json["subtotalFormatted"],
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
        "productPriceFormatted": productPriceFormatted,
        "subtotalFormatted": subtotalFormatted,
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
    final String? notes;
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
