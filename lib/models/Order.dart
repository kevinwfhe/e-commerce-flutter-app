import 'package:csi5112group1project/models/Product.dart';
import 'package:csi5112group1project/utils/sharedEnum.dart';

class Order {
  final Map<int, int> orderDetails; //Map<product_id, quantity>
  final DateTime orderTimeStamp;
  final ORDER_STATUS orderStatus;
  final double totalPrice;
  Order(
      {required this.orderDetails,
      required this.orderTimeStamp,
      required this.orderStatus,
      required this.totalPrice});
}
