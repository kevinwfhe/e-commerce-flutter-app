import '../utils/shared_enum.dart';
import 'shipping_address.dart';

class Order {
  final String orderId;
  final Map<int, int> orderDetails; //Map<product_id, quantity>
  final DateTime orderTimeStamp;
  final ORDER_STATUS orderStatus;
  final double totalPrice;
  final ShippingAddress shippingAddress;
  Order({
    required this.orderId,
    required this.orderDetails,
    required this.orderTimeStamp,
    required this.orderStatus,
    required this.totalPrice,
    required this.shippingAddress,
  });
}
