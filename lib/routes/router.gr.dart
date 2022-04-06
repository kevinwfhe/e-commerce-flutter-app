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
import 'package:flutter/material.dart' as _i19;

import '../screens/admin/admin_main_screen.dart' as _i15;
import '../screens/admin/admin_order_detail_screen/admin_order_detail_screen.dart'
    as _i18;
import '../screens/admin/authentication_admin_screen/authentification_admin_screen.dart'
    as _i16;
import '../screens/admin/product_detail_manage_screen/product_detail_manage_screen.dart'
    as _i17;
import '../screens/client/authentication_client_screen/authentification_client_screen.dart'
    as _i6;
import '../screens/client/cart_screen/cart_screen.dart' as _i5;
import '../screens/client/checkout_screen/checkout_screen.dart' as _i13;
import '../screens/client/client_main_screen.dart' as _i1;
import '../screens/client/discussion_detail_screen/discussion_detail_screen.dart'
    as _i12;
import '../screens/client/discussion_question_screen/discussion_question_screen.dart'
    as _i2;
import '../screens/client/discussion_screen/discussion_screen.dart' as _i11;
import '../screens/client/order_detail_screen/order_detail_screen.dart' as _i10;
import '../screens/client/order_placed_screen/order_placed_screen.dart' as _i14;
import '../screens/client/orders_screen/orders_screen.dart' as _i9;
import '../screens/client/product_detail_screen/product_detail_screen.dart'
    as _i4;
import '../screens/client/products_screen/products_screen.dart' as _i8;
import '../screens/client/sign_up_screen/sign_up_screen.dart' as _i7;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ClientMainRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ClientMainPage());
    },
    DiscussionQuestionScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.DiscussionQuestionScreen());
    },
    CheckoutRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    ProductDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailRouteArgs>(
          orElse: () => ProductDetailRouteArgs(
              productId: pathParams.getString('productId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i4.ProductDetailScreen(
              key: args.key, productId: args.productId));
    },
    StandAloneCartRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.CartScreen());
    },
    LoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i6.AuthentificationClientScreen());
    },
    SignUpRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.SignUpScreen());
    },
    AdminRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
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
    DiscussRouter.name: (routeData) {
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
          child: _i10.OrderDetailScreen(key: args.key, orderId: args.orderId));
    },
    DiscussionScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.DiscussionScreen());
    },
    DiscussionDetailScreen.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DiscussionDetailScreenArgs>(
          orElse: () => DiscussionDetailScreenArgs(
              questionId: pathParams.getString('questionId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.DiscussionDetailScreen(
              key: args.key, questionId: args.questionId));
    },
    CheckoutRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.CheckoutScreen());
    },
    CheckoutSuccessScreen.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.OrderPlacedScreen());
    },
    AdminMainRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.AdminMainScreen());
    },
    AdminLoginRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i16.AuthentificationAdminScreen());
    },
    AdminProductRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    AdminOrderRouter.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    AdminProductDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AdminProductDetailArgs>(
          orElse: () => AdminProductDetailArgs(
              productId: pathParams.getString('productId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i17.ProductDetailManageScreen(
              key: args.key, productId: args.productId));
    },
    AdminOrderDetail.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AdminOrderDetailArgs>(
          orElse: () =>
              AdminOrderDetailArgs(orderId: pathParams.getString('orderId')));
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i18.AdminOrderDetailScreen(
              key: args.key, orderId: args.orderId));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(ClientMainRoute.name, path: '/', children: [
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
              ]),
          _i3.RouteConfig(DiscussRouter.name,
              path: 'discuss',
              parent: ClientMainRoute.name,
              children: [
                _i3.RouteConfig(DiscussionScreen.name,
                    path: '', parent: DiscussRouter.name),
                _i3.RouteConfig(DiscussionDetailScreen.name,
                    path: ':questionId', parent: DiscussRouter.name)
              ])
        ]),
        _i3.RouteConfig(DiscussionQuestionScreen.name, path: '/ask'),
        _i3.RouteConfig(CheckoutRouter.name, path: '/checkout', children: [
          _i3.RouteConfig(CheckoutRoute.name,
              path: '', parent: CheckoutRouter.name),
          _i3.RouteConfig(CheckoutSuccessScreen.name,
              path: 'success', parent: CheckoutRouter.name)
        ]),
        _i3.RouteConfig(ProductDetailRoute.name, path: '/item/:productId'),
        _i3.RouteConfig(StandAloneCartRoute.name, path: '/cart'),
        _i3.RouteConfig(LoginRoute.name, path: '/login'),
        _i3.RouteConfig(SignUpRoute.name, path: '/signup'),
        _i3.RouteConfig(AdminRouter.name, path: '/admin', children: [
          _i3.RouteConfig(AdminMainRoute.name,
              path: '', parent: AdminRouter.name),
          _i3.RouteConfig(AdminLoginRoute.name,
              path: 'login', parent: AdminRouter.name),
          _i3.RouteConfig(AdminProductRouter.name,
              path: 'product',
              parent: AdminRouter.name,
              children: [
                _i3.RouteConfig(AdminProductDetail.name,
                    path: ':productId', parent: AdminProductRouter.name)
              ]),
          _i3.RouteConfig(AdminOrderRouter.name,
              path: 'order',
              parent: AdminRouter.name,
              children: [
                _i3.RouteConfig(AdminOrderDetail.name,
                    path: ':orderId', parent: AdminOrderRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.ClientMainPage]
class ClientMainRoute extends _i3.PageRouteInfo<void> {
  const ClientMainRoute({List<_i3.PageRouteInfo>? children})
      : super(ClientMainRoute.name, path: '/', initialChildren: children);

  static const String name = 'ClientMainRoute';
}

/// generated route for
/// [_i2.DiscussionQuestionScreen]
class DiscussionQuestionScreen extends _i3.PageRouteInfo<void> {
  const DiscussionQuestionScreen()
      : super(DiscussionQuestionScreen.name, path: '/ask');

  static const String name = 'DiscussionQuestionScreen';
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
  ProductDetailRoute({_i19.Key? key, required String productId})
      : super(ProductDetailRoute.name,
            path: '/item/:productId',
            args: ProductDetailRouteArgs(key: key, productId: productId),
            rawPathParams: {'productId': productId});

  static const String name = 'ProductDetailRoute';
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({this.key, required this.productId});

  final _i19.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i5.CartScreen]
class StandAloneCartRoute extends _i3.PageRouteInfo<void> {
  const StandAloneCartRoute() : super(StandAloneCartRoute.name, path: '/cart');

  static const String name = 'StandAloneCartRoute';
}

/// generated route for
/// [_i6.AuthentificationClientScreen]
class LoginRoute extends _i3.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i7.SignUpScreen]
class SignUpRoute extends _i3.PageRouteInfo<void> {
  const SignUpRoute() : super(SignUpRoute.name, path: '/signup');

  static const String name = 'SignUpRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class AdminRouter extends _i3.PageRouteInfo<void> {
  const AdminRouter({List<_i3.PageRouteInfo>? children})
      : super(AdminRouter.name, path: '/admin', initialChildren: children);

  static const String name = 'AdminRouter';
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
/// [_i3.EmptyRouterPage]
class DiscussRouter extends _i3.PageRouteInfo<void> {
  const DiscussRouter({List<_i3.PageRouteInfo>? children})
      : super(DiscussRouter.name, path: 'discuss', initialChildren: children);

  static const String name = 'DiscussRouter';
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
  OrderDetailScreen({_i19.Key? key, required String orderId})
      : super(OrderDetailScreen.name,
            path: ':orderId',
            args: OrderDetailScreenArgs(key: key, orderId: orderId),
            rawPathParams: {'orderId': orderId});

  static const String name = 'OrderDetailScreen';
}

class OrderDetailScreenArgs {
  const OrderDetailScreenArgs({this.key, required this.orderId});

  final _i19.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailScreenArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i11.DiscussionScreen]
class DiscussionScreen extends _i3.PageRouteInfo<void> {
  const DiscussionScreen() : super(DiscussionScreen.name, path: '');

  static const String name = 'DiscussionScreen';
}

/// generated route for
/// [_i12.DiscussionDetailScreen]
class DiscussionDetailScreen
    extends _i3.PageRouteInfo<DiscussionDetailScreenArgs> {
  DiscussionDetailScreen({_i19.Key? key, required String questionId})
      : super(DiscussionDetailScreen.name,
            path: ':questionId',
            args: DiscussionDetailScreenArgs(key: key, questionId: questionId),
            rawPathParams: {'questionId': questionId});

  static const String name = 'DiscussionDetailScreen';
}

class DiscussionDetailScreenArgs {
  const DiscussionDetailScreenArgs({this.key, required this.questionId});

  final _i19.Key? key;

  final String questionId;

  @override
  String toString() {
    return 'DiscussionDetailScreenArgs{key: $key, questionId: $questionId}';
  }
}

/// generated route for
/// [_i13.CheckoutScreen]
class CheckoutRoute extends _i3.PageRouteInfo<void> {
  const CheckoutRoute() : super(CheckoutRoute.name, path: '');

  static const String name = 'CheckoutRoute';
}

/// generated route for
/// [_i14.OrderPlacedScreen]
class CheckoutSuccessScreen extends _i3.PageRouteInfo<void> {
  const CheckoutSuccessScreen()
      : super(CheckoutSuccessScreen.name, path: 'success');

  static const String name = 'CheckoutSuccessScreen';
}

/// generated route for
/// [_i15.AdminMainScreen]
class AdminMainRoute extends _i3.PageRouteInfo<void> {
  const AdminMainRoute() : super(AdminMainRoute.name, path: '');

  static const String name = 'AdminMainRoute';
}

/// generated route for
/// [_i16.AuthentificationAdminScreen]
class AdminLoginRoute extends _i3.PageRouteInfo<void> {
  const AdminLoginRoute() : super(AdminLoginRoute.name, path: 'login');

  static const String name = 'AdminLoginRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class AdminProductRouter extends _i3.PageRouteInfo<void> {
  const AdminProductRouter({List<_i3.PageRouteInfo>? children})
      : super(AdminProductRouter.name,
            path: 'product', initialChildren: children);

  static const String name = 'AdminProductRouter';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class AdminOrderRouter extends _i3.PageRouteInfo<void> {
  const AdminOrderRouter({List<_i3.PageRouteInfo>? children})
      : super(AdminOrderRouter.name, path: 'order', initialChildren: children);

  static const String name = 'AdminOrderRouter';
}

/// generated route for
/// [_i17.ProductDetailManageScreen]
class AdminProductDetail extends _i3.PageRouteInfo<AdminProductDetailArgs> {
  AdminProductDetail({_i19.Key? key, required String productId})
      : super(AdminProductDetail.name,
            path: ':productId',
            args: AdminProductDetailArgs(key: key, productId: productId),
            rawPathParams: {'productId': productId});

  static const String name = 'AdminProductDetail';
}

class AdminProductDetailArgs {
  const AdminProductDetailArgs({this.key, required this.productId});

  final _i19.Key? key;

  final String productId;

  @override
  String toString() {
    return 'AdminProductDetailArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i18.AdminOrderDetailScreen]
class AdminOrderDetail extends _i3.PageRouteInfo<AdminOrderDetailArgs> {
  AdminOrderDetail({_i19.Key? key, required String orderId})
      : super(AdminOrderDetail.name,
            path: ':orderId',
            args: AdminOrderDetailArgs(key: key, orderId: orderId),
            rawPathParams: {'orderId': orderId});

  static const String name = 'AdminOrderDetail';
}

class AdminOrderDetailArgs {
  const AdminOrderDetailArgs({this.key, required this.orderId});

  final _i19.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'AdminOrderDetailArgs{key: $key, orderId: $orderId}';
  }
}
