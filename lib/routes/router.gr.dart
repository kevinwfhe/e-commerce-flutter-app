// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i13;

import '../models/product.dart' as _i14;
import '../screens/client/authentification_buyer_screen.dart' as _i6;
import '../screens/client/cart_screen.dart' as _i5;
import '../screens/client/checkout_screen.dart' as _i11;
import '../screens/client/client_main_page.dart' as _i2;
import '../screens/client/order_detail_screen.dart' as _i10;
import '../screens/client/order_placed_screen.dart' as _i12;
import '../screens/client/order_screen.dart' as _i9;
import '../screens/client/product_detail_screen.dart' as _i4;
import '../screens/client/products_screen.dart' as _i8;
import '../screens/client/shipping_screen.dart' as _i7;
import '../screens/common/login_screen.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    LoginScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.LoginScreen());
    },
    ClientMainRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ClientMainPage());
    },
    CheckoutRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    ProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailRouteArgs>();
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.ProductDetailScreen(
              key: args.key,
              productId: args.productId,
              title: args.title,
              description: args.description,
              image: args.image,
              price: args.price,
              product: args.product));
    },
    StandAloneCartRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.CartScreen());
    },
    LoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.AuthentificationBuyerScreen());
    },
    AddressRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ShippingScreen());
    },
    ProductRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ProductsScreen());
    },
    CartRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.CartScreen());
    },
    OrderRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    OrderScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.OrderScreen());
    },
    OrderDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderDetailScreenArgs>(
          orElse: () =>
              OrderDetailScreenArgs(orderId: pathParams.getString('orderId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.OrderDetailScreen(orderId: args.orderId, key: args.key));
    },
    CheckoutRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.CheckoutScreen());
    },
    CheckoutSuccessScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.OrderPlacedScreen());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(LoginScreen.name, path: '/'),
        _i3.RouteConfig(ClientMainRoute.name, path: '/client', children: [
          _i3.RouteConfig(ProductRoute.name,
              path: '', parent: ClientMainRoute.name),
          _i3.RouteConfig(CartRoute.name,
              path: 'cart', parent: ClientMainRoute.name),
          _i3.RouteConfig(OrderRouter.name,
              path: 'order',
              parent: ClientMainRoute.name,
              children: [
                _i3.RouteConfig(OrderScreen.name,
                    path: '', parent: OrderRouter.name),
                _i3.RouteConfig(OrderDetailScreen.name,
                    path: ':orderId', parent: OrderRouter.name)
              ])
        ]),
        _i3.RouteConfig(CheckoutRouter.name, path: '/checkout', children: [
          _i3.RouteConfig(CheckoutRoute.name,
              path: '', parent: CheckoutRouter.name),
          _i3.RouteConfig(CheckoutSuccessScreen.name,
              path: 'success', parent: CheckoutRouter.name)
        ]),
        _i3.RouteConfig(ProductDetailRoute.name, path: '/item/:productId'),
        _i3.RouteConfig(StandAloneCartRoute.name, path: '/cart'),
        _i3.RouteConfig(LoginRoute.name, path: '/login'),
        _i3.RouteConfig(AddressRoute.name, path: '/address')
      ];
}

/// generated route for
/// [_i1.LoginScreen]
class LoginScreen extends _i3.PageRouteInfo<void> {
  const LoginScreen() : super(LoginScreen.name, path: '/');

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i2.ClientMainPage]
class ClientMainRoute extends _i3.PageRouteInfo<void> {
  const ClientMainRoute({List<_i3.PageRouteInfo>? children})
      : super(ClientMainRoute.name, path: '/client', initialChildren: children);

  static const String name = 'ClientMainRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class CheckoutRouter extends _i3.PageRouteInfo<void> {
  const CheckoutRouter({List<_i3.PageRouteInfo>? children})
      : super(CheckoutRouter.name,
            path: '/checkout', initialChildren: children);

  static const String name = 'CheckoutRouter';
}

/// generated route for
/// [_i4.ProductDetailScreen]
class ProductDetailRoute extends _i3.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute(
      {_i13.Key? key,
      required String productId,
      required String title,
      required String description,
      required String image,
      required double price,
      required _i14.Product product})
      : super(ProductDetailRoute.name,
            path: '/item/:productId',
            args: ProductDetailRouteArgs(
                key: key,
                productId: productId,
                title: title,
                description: description,
                image: image,
                price: price,
                product: product),
            rawPathParams: {'productId': productId});

  static const String name = 'ProductDetailRoute';
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs(
      {this.key,
      required this.productId,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.product});

  final _i13.Key? key;

  final String productId;

  final String title;

  final String description;

  final String image;

  final double price;

  final _i14.Product product;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, productId: $productId, title: $title, description: $description, image: $image, price: $price, product: $product}';
  }
}

/// generated route for
/// [_i5.CartScreen]
class StandAloneCartRoute extends _i3.PageRouteInfo<void> {
  const StandAloneCartRoute() : super(StandAloneCartRoute.name, path: '/cart');

  static const String name = 'StandAloneCartRoute';
}

/// generated route for
/// [_i6.AuthentificationBuyerScreen]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i7.ShippingScreen]
class AddressRoute extends _i3.PageRouteInfo<void> {
  const AddressRoute() : super(AddressRoute.name, path: '/address');

  static const String name = 'AddressRoute';
}

/// generated route for
/// [_i8.ProductsScreen]
class ProductRoute extends _i3.PageRouteInfo<void> {
  const ProductRoute() : super(ProductRoute.name, path: '');

  static const String name = 'ProductRoute';
}

/// generated route for
/// [_i5.CartScreen]
class CartRoute extends _i3.PageRouteInfo<void> {
  const CartRoute() : super(CartRoute.name, path: 'cart');

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class OrderRouter extends _i3.PageRouteInfo<void> {
  const OrderRouter({List<_i3.PageRouteInfo>? children})
      : super(OrderRouter.name, path: 'order', initialChildren: children);

  static const String name = 'OrderRouter';
}

/// generated route for
/// [_i9.OrderScreen]
class OrderScreen extends _i3.PageRouteInfo<void> {
  const OrderScreen() : super(OrderScreen.name, path: '');

  static const String name = 'OrderScreen';
}

/// generated route for
/// [_i10.OrderDetailScreen]
class OrderDetailScreen extends _i3.PageRouteInfo<OrderDetailScreenArgs> {
  OrderDetailScreen({required String orderId, _i13.Key? key})
      : super(OrderDetailScreen.name,
            path: ':orderId',
            args: OrderDetailScreenArgs(orderId: orderId, key: key),
            rawPathParams: {'orderId': orderId});

  static const String name = 'OrderDetailScreen';
}

class OrderDetailScreenArgs {
  const OrderDetailScreenArgs({required this.orderId, this.key});

  final String orderId;

  final _i13.Key? key;

  @override
  String toString() {
    return 'OrderDetailScreenArgs{orderId: $orderId, key: $key}';
  }
}

/// generated route for
/// [_i11.CheckoutScreen]
class CheckoutRoute extends _i3.PageRouteInfo<void> {
  const CheckoutRoute() : super(CheckoutRoute.name, path: '');

  static const String name = 'CheckoutRoute';
}

/// generated route for
/// [_i12.OrderPlacedScreen]
class CheckoutSuccessScreen extends _i3.PageRouteInfo<void> {
  const CheckoutSuccessScreen()
      : super(CheckoutSuccessScreen.name, path: 'success');

  static const String name = 'CheckoutSuccessScreen';
}
