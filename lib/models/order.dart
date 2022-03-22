import '../utils/order_status_map.dart';
import '../models/shipping_address.dart';
import '../models/product.dart';
import '../utils/shared_enum.dart';

class PurchasedItem {
  final String id;
  final String productId;
  final int quantity;
  PurchasedItem({
    required this.id,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'quantity': quantity,
    };
  }
}

class Order {
  final String orderId;
  final DateTime orderTimeStamp;
  final ORDER_STATUS orderStatus;
  final double totalPrice;
  List<PurchasedItem>? purchasedItems; // <productId, quantity>
  String? shippingAddressId;
  Order({
    required this.orderId,
    required this.orderTimeStamp,
    required this.orderStatus,
    required this.totalPrice,
    this.purchasedItems,
    this.shippingAddressId,
  });

  Order.fromJson(Map<dynamic, dynamic> json)
      : orderId = json['id'],
        orderStatus = INT_TO_ORDER_STATUS[json['status']] as ORDER_STATUS,
        totalPrice = json['totalPrice'],
        shippingAddressId = json['shippingAddressId'],
        orderTimeStamp =
            DateTime.fromMillisecondsSinceEpoch(json['createTime']);

  Map<String, dynamic> toJson() {
    var res = {
      'id': orderId,
      'createTime': orderTimeStamp.millisecondsSinceEpoch,
      'status': ORDER_STATUS_TO_INT[orderStatus],
      'totalPrice': totalPrice,
      'shippingAddressId': shippingAddressId,
      'purchasedItems': purchasedItems
    };
    return res;
  }
}

class PurchasedProduct {
  final String purchasedItemId;
  final Product product;
  final int quantity;

  PurchasedProduct({
    required this.purchasedItemId,
    required this.product,
    required this.quantity,
  });

  factory PurchasedProduct.fromJson(Map<String, dynamic> json) {
    return PurchasedProduct(
      purchasedItemId: json['purchasedItemId'],
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}

class DetailedOrder extends Order {
  final List<PurchasedProduct> purchasedProducts; // <Product, quantity>
  final ShippingAddress shippingAddress;
  DetailedOrder({
    required this.purchasedProducts,
    required this.shippingAddress,
    orderId,
    totalPrice,
    orderTimeStamp,
    orderStatus,
  }) : super(
          orderId: orderId,
          totalPrice: totalPrice,
          orderTimeStamp: orderTimeStamp,
          orderStatus: orderStatus,
        );

  factory DetailedOrder.fromJson(Map<dynamic, dynamic> json) {
    var list = json['purchasedProducts'] as List;
    List<PurchasedProduct> productsList =
        list.map((p) => PurchasedProduct.fromJson(p)).toList();
    return DetailedOrder(
      orderId: json['id'],
      totalPrice: json['totalPrice'],
      orderTimeStamp:
          DateTime.fromMillisecondsSinceEpoch(json['createTime']),
      orderStatus: INT_TO_ORDER_STATUS[json['status']] as ORDER_STATUS,
      purchasedProducts: productsList,
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
    );
  }
}
