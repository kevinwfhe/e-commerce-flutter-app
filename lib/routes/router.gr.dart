// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i16;

import '../screens/admin/admin_main_screen.dart' as _i12;
import '../screens/admin/admin_order_detail_screen/admin_order_detail_screen.dart'
    as _i15;
import '../screens/admin/authentication_admin_screen/authentification_admin_screen.dart'
    as _i13;
import '../screens/admin/product_detail_manage_screen/product_detail_manage_screen.dart'
    as _i14;
import '../screens/client/authentication_client_screen/authentification_client_screen.dart'
    as _i5;
import '../screens/client/cart_screen/cart_screen.dart' as _i4;
import '../screens/client/checkout_screen/checkout_screen.dart' as _i10;
import '../screens/client/client_main_screen.dart' as _i1;
import '../screens/client/order_detail_screen/order_detail_screen.dart' as _i9;
import '../screens/client/order_placed_screen/order_placed_screen.dart' as _i11;
import '../screens/client/orders_screen/orders_screen.dart' as _i8;
import '../screens/client/product_detail_screen/product_detail_screen.dart'
    as _i3;
import '../screens/client/products_screen/products_screen.dart' as _i7;
import '../screens/client/sign_up_screen/sign_up_screen.dart' as _i6;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i16.GlobalKey<_i16.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    ClientMainRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ClientMainPage());
    },
    CheckoutRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ProductDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailRouteArgs>(
          orElse: () => ProductDetailRouteArgs(
              productId: pathParams.getString('productId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.ProductDetailScreen(
              key: args.key, productId: args.productId));
    },
    StandAloneCartRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CartScreen());
    },
    LoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i5.AuthentificationClientScreen());
    },
    SignUpRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SignUpScreen());
    },
    AdminRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ProductRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProductsScreen());
    },
    CartRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.CartScreen());
    },
    OrderRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    OrderScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.OrderScreen());
    },
    OrderDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderDetailScreenArgs>(
          orElse: () =>
              OrderDetailScreenArgs(orderId: pathParams.getString('orderId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.OrderDetailScreen(key: args.key, orderId: args.orderId));
    },
    CheckoutRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.CheckoutScreen());
    },
    CheckoutSuccessScreen.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.OrderPlacedScreen());
    },
    AdminMainRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.AdminMainScreen());
    },
    AdminLoginRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i13.AuthentificationAdminScreen());
    },
    AdminProductRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    AdminOrderRouter.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    AdminProductDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AdminProductDetailArgs>(
          orElse: () => AdminProductDetailArgs(
              productId: pathParams.getString('productId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i14.ProductDetailManageScreen(
              key: args.key, productId: args.productId));
    },
    AdminOrderDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AdminOrderDetailArgs>(
          orElse: () =>
              AdminOrderDetailArgs(orderId: pathParams.getString('orderId')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i15.AdminOrderDetailScreen(
              key: args.key, orderId: args.orderId));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(ClientMainRoute.name, path: '/', children: [
          _i2.RouteConfig(ProductRoute.name,
              path: '', parent: ClientMainRoute.name),
          _i2.RouteConfig(CartRoute.name,
              path: 'cart', parent: ClientMainRoute.name),
          _i2.RouteConfig(OrderRouter.name,
              path: 'order',
              parent: ClientMainRoute.name,
              children: [
                _i2.RouteConfig(OrderScreen.name,
                    path: '', parent: OrderRouter.name),
                _i2.RouteConfig(OrderDetailScreen.name,
                    path: ':orderId', parent: OrderRouter.name)
              ])
        ]),
        _i2.RouteConfig(CheckoutRouter.name, path: '/checkout', children: [
          _i2.RouteConfig(CheckoutRoute.name,
              path: '', parent: CheckoutRouter.name),
          _i2.RouteConfig(CheckoutSuccessScreen.name,
              path: 'success', parent: CheckoutRouter.name)
        ]),
        _i2.RouteConfig(ProductDetailRoute.name, path: '/item/:productId'),
        _i2.RouteConfig(StandAloneCartRoute.name, path: '/cart'),
        _i2.RouteConfig(LoginRoute.name, path: '/login'),
        _i2.RouteConfig(SignUpRoute.name, path: '/signup'),
        _i2.RouteConfig(AdminRouter.name, path: '/admin', children: [
          _i2.RouteConfig(AdminMainRoute.name,
              path: '', parent: AdminRouter.name),
          _i2.RouteConfig(AdminLoginRoute.name,
              path: 'login', parent: AdminRouter.name),
          _i2.RouteConfig(AdminProductRouter.name,
              path: 'product',
              parent: AdminRouter.name,
              children: [
                _i2.RouteConfig(AdminProductDetail.name,
                    path: ':productId', parent: AdminProductRouter.name)
              ]),
          _i2.RouteConfig(AdminOrderRouter.name,
              path: 'order',
              parent: AdminRouter.name,
              children: [
                _i2.RouteConfig(AdminOrderDetail.name,
                    path: ':orderId', parent: AdminOrderRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.ClientMainPage]
class ClientMainRoute extends _i2.PageRouteInfo<void> {
  const ClientMainRoute({List<_i2.PageRouteInfo>? children})
      : super(ClientMainRoute.name, path: '/', initialChildren: children);

  static const String name = 'ClientMainRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class CheckoutRouter extends _i2.PageRouteInfo<void> {
  const CheckoutRouter({List<_i2.PageRouteInfo>? children})
      : super(CheckoutRouter.name,
            path: '/checkout', initialChildren: children);

  static const String name = 'CheckoutRouter';
}

/// generated route for
/// [_i3.ProductDetailScreen]
class ProductDetailRoute extends _i2.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({_i16.Key? key, required String productId})
      : super(ProductDetailRoute.name,
            path: '/item/:productId',
            args: ProductDetailRouteArgs(key: key, productId: productId),
            rawPathParams: {'productId': productId});

  static const String name = 'ProductDetailRoute';
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({this.key, required this.productId});

  final _i16.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i4.CartScreen]
class StandAloneCartRoute extends _i2.PageRouteInfo<void> {
  const StandAloneCartRoute() : super(StandAloneCartRoute.name, path: '/cart');

  static const String name = 'StandAloneCartRoute';
}

/// generated route for
/// [_i5.AuthentificationClientScreen]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i6.SignUpScreen]
class SignUpRoute extends _i2.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/signup');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class AdminRouter extends _i2.PageRouteInfo<void> {
  const AdminRouter({List<_i2.PageRouteInfo>? children})
      : super(AdminRouter.name, path: '/admin', initialChildren: children);

  static const String name = 'AdminRouter';
}

/// generated route for
/// [_i7.ProductsScreen]
class ProductRoute extends _i2.PageRouteInfo<void> {
  const ProductRoute() : super(ProductRoute.name, path: '');

  static const String name = 'ProductRoute';
}

/// generated route for
/// [_i4.CartScreen]
class CartRoute extends _i2.PageRouteInfo<void> {
  const CartRoute() : super(CartRoute.name, path: 'cart');

  static const String name = 'CartRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class OrderRouter extends _i2.PageRouteInfo<void> {
  const OrderRouter({List<_i2.PageRouteInfo>? children})
      : super(OrderRouter.name, path: 'order', initialChildren: children);

  static const String name = 'OrderRouter';
}

/// generated route for
/// [_i8.OrderScreen]
class OrderScreen extends _i2.PageRouteInfo<void> {
  const OrderScreen() : super(OrderScreen.name, path: '');

  static const String name = 'OrderScreen';
}

/// generated route for
/// [_i9.OrderDetailScreen]
class OrderDetailScreen extends _i2.PageRouteInfo<OrderDetailScreenArgs> {
  OrderDetailScreen({_i16.Key? key, required String orderId})
      : super(OrderDetailScreen.name,
            path: ':orderId',
            args: OrderDetailScreenArgs(key: key, orderId: orderId),
            rawPathParams: {'orderId': orderId});

  static const String name = 'OrderDetailScreen';
}

class OrderDetailScreenArgs {
  const OrderDetailScreenArgs({this.key, required this.orderId});

  final _i16.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailScreenArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i10.CheckoutScreen]
class CheckoutRoute extends _i2.PageRouteInfo<void> {
  const CheckoutRoute() : super(CheckoutRoute.name, path: '');

  static const String name = 'CheckoutRoute';
}

/// generated route for
/// [_i11.OrderPlacedScreen]
class CheckoutSuccessScreen extends _i2.PageRouteInfo<void> {
  const CheckoutSuccessScreen()
      : super(CheckoutSuccessScreen.name, path: 'success');

  static const String name = 'CheckoutSuccessScreen';
}

/// generated route for
/// [_i12.AdminMainScreen]
class AdminMainRoute extends _i2.PageRouteInfo<void> {
  const AdminMainRoute() : super(AdminMainRoute.name, path: '');

  static const String name = 'AdminMainRoute';
}

/// generated route for
/// [_i13.AuthentificationAdminScreen]
class AdminLoginRoute extends _i2.PageRouteInfo<void> {
  const AdminLoginRoute() : super(AdminLoginRoute.name, path: 'login');

  static const String name = 'AdminLoginRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class AdminProductRouter extends _i2.PageRouteInfo<void> {
  const AdminProductRouter({List<_i2.PageRouteInfo>? children})
      : super(AdminProductRouter.name,
            path: 'product', initialChildren: children);

  static const String name = 'AdminProductRouter';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class AdminOrderRouter extends _i2.PageRouteInfo<void> {
  const AdminOrderRouter({List<_i2.PageRouteInfo>? children})
      : super(AdminOrderRouter.name, path: 'order', initialChildren: children);

  static const String name = 'AdminOrderRouter';
}

/// generated route for
/// [_i14.ProductDetailManageScreen]
class AdminProductDetail extends _i2.PageRouteInfo<AdminProductDetailArgs> {
  AdminProductDetail({_i16.Key? key, required String productId})
      : super(AdminProductDetail.name,
            path: ':productId',
            args: AdminProductDetailArgs(key: key, productId: productId),
            rawPathParams: {'productId': productId});

  static const String name = 'AdminProductDetail';
}

class AdminProductDetailArgs {
  const AdminProductDetailArgs({this.key, required this.productId});

  final _i16.Key? key;

  final String productId;

  @override
  String toString() {
    return 'AdminProductDetailArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i15.AdminOrderDetailScreen]
class AdminOrderDetail extends _i2.PageRouteInfo<AdminOrderDetailArgs> {
  AdminOrderDetail({_i16.Key? key, required String orderId})
      : super(AdminOrderDetail.name,
            path: ':orderId',
            args: AdminOrderDetailArgs(key: key, orderId: orderId),
            rawPathParams: {'orderId': orderId});

  static const String name = 'AdminOrderDetail';
}

class AdminOrderDetailArgs {
  const AdminOrderDetailArgs({this.key, required this.orderId});

  final _i16.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'AdminOrderDetailArgs{key: $key, orderId: $orderId}';
  }
}
