import 'package:flutter/material.dart';

class Invoice {
  final String invoiceId,
      productId,
      productTitle,
      customerName,
      billingAdd,
      shippingAdd;
  final int price, size;
  Invoice({
    required this.invoiceId,
    required this.productId,
    required this.productTitle,
    required this.price,
    required this.billingAdd,
    required this.size,
    required this.shippingAdd,
    required this.customerName,
  });
}

List<Invoice> invoices = [
  Invoice(
      invoiceId: "oddsa-123",
      productId: "1",
      price: 233,
      size: 9,
      customerName: "Tida Yvwx",
      productTitle: "add shoes",
      billingAdd: "1 young street, Toronto, Ontario",
      shippingAdd: "1 young street, Toronto, Ontario"),
  Invoice(
      invoiceId: "oddsa-123",
      productId: "1",
      price: 233,
      size: 9,
      customerName: "Tida Yvwx",
      productTitle: "add shoes",
      billingAdd: "1 young street, Toronto, Ontario",
      shippingAdd: "1 young street, Toronto, Ontario"),
  Invoice(
      invoiceId: "oddsa-123",
      productId: "1",
      price: 233,
      size: 9,
      customerName: "Tida Yvwx",
      productTitle: "add shoes",
      billingAdd: "1 young street, Toronto, Ontario",
      shippingAdd: "1 young street, Toronto, Ontario"),
  Invoice(
      invoiceId: "oddsa-123",
      productId: "1",
      price: 233,
      size: 9,
      customerName: "Tida Yvwx",
      productTitle: "add shoes",
      billingAdd: "1 young street, Toronto, Ontario",
      shippingAdd: "1 young street, Toronto, Ontario"),
];
