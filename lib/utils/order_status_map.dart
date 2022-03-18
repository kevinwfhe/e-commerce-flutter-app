import 'shared_enum.dart';

Map<int, ORDER_STATUS> INT_TO_ORDER_STATUS = {
  0: ORDER_STATUS.placed,
  1: ORDER_STATUS.pending,
  2: ORDER_STATUS.paid,
  3: ORDER_STATUS.shipping,
  4: ORDER_STATUS.shipped
};

Map<ORDER_STATUS, String> ORDER_STATUS_TO_STRING = {
  ORDER_STATUS.placed: 'Placed',
  ORDER_STATUS.pending: 'Pending',
  ORDER_STATUS.paid: 'Paid',
  ORDER_STATUS.shipping: 'Shipping',
  ORDER_STATUS.shipped: 'Shipped',
};
