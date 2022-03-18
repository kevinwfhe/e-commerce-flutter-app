import '../utils/order_status_map.dart';
import '../models/shipping_address.dart';
import '../models/product.dart';
import '../utils/shared_enum.dart';

class Order {
  final String orderId;
  final DateTime orderTimeStamp;
  final ORDER_STATUS orderStatus;
  final double totalPrice;
  Order({
    required this.orderId,
    required this.orderTimeStamp,
    required this.orderStatus,
    required this.totalPrice,
  });

  Order.fromJson(Map<dynamic, dynamic> json)
      : orderId = json['id'],
        orderStatus = INT_TO_ORDER_STATUS[json['status']] as ORDER_STATUS,
        totalPrice = json['totalPrice'],
        orderTimeStamp =
            DateTime.fromMillisecondsSinceEpoch(json['createTime'] * 1000);
}

class DetailedOrder extends Order {
  final Map<Product, int> purchasedProducts; // <Product, quantity>
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
    Map<Product, int> productsMap = Map.fromIterable(list,
        key: (element) => Product.fromJson(element['product']),
        value: (element) => element['quantity']);
    return DetailedOrder(
        orderId: json['id'],
        totalPrice: json['totalPrice'],
        orderTimeStamp:
            DateTime.fromMillisecondsSinceEpoch(json['createTime'] * 1000),
        orderStatus: INT_TO_ORDER_STATUS[json['status']] as ORDER_STATUS,
        purchasedProducts: productsMap,
        shippingAddress: ShippingAddress.fromJson(json['shippingAddress']));
  }
}
