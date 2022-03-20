import "package:auto_route/auto_route.dart";
import 'package:csi5112group1project/screens/admin/admin_main_screen.dart';
import 'package:csi5112group1project/screens/admin/authentification_admin_screen.dart';
import 'package:csi5112group1project/screens/admin/component/product_detail_manage_body.dart';
import 'package:csi5112group1project/screens/admin/product_detail_manage_screen.dart';
import '../screens/client/checkout_screen.dart';
import '../screens/client/product_detail_screen.dart';
import '../screens/client/products_screen.dart';
import '../screens/client/order_placed_screen.dart';
import '../screens/client/order_detail_screen.dart';
import '../screens/client/order_screen.dart';
import '../screens/client/cart_screen.dart';
import "../screens/client/authentification_buyer_screen.dart";
import '../screens/client/client_main_page.dart';

// auto_route documentation -> https://pub.dev/packages/auto_route

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: ClientMainPage,
      initial: true,
      children: [
        AutoRoute(
          path: '',
          name: 'ProductRoute',
          page: ProductsScreen
        ),
        AutoRoute(
          path: 'cart',
          name: 'CartRoute',
          page: CartScreen
        ),
        AutoRoute(
          path: 'order',
          name: 'OrderRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: OrderScreen
            ),
            AutoRoute(
              path: ':orderId',
              page: OrderDetailScreen
            ),
          ]
        ),
      ]
    ),
    AutoRoute(
      path: '/checkout',
      name: 'CheckoutRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          name: 'CheckoutRoute',
          page: CheckoutScreen,
        ),
        AutoRoute(
          path: 'success',
          name: 'CheckoutSuccessScreen',
          page: OrderPlacedScreen,
        )
      ]
    ),
    AutoRoute(
      path: '/item/:productId',
      name: 'ProductDetailRoute',
      page: ProductDetailScreen
    ),
    AutoRoute(
      path: '/cart',
      name: 'StandAloneCartRoute',
      page: CartScreen
    ),
    AutoRoute(
      path: '/login',
      name: 'LoginRoute',
      page: AuthentificationBuyerScreen
    ),
    AutoRoute(
      path: '/admin',
      name: 'AdminRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          name: 'AdminMainRoute',
          page: AdminMainScreen
        ),
        AutoRoute(
          path: 'login',
          name: 'AdminLoginRoute',
          page: AuthentificationAdminScreen
        ),
        AutoRoute(
          path: 'product',
          name: 'AdminProductRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: ':productId',
              name: 'AdminProductDetail',
              page: ProductDetailManageScreen
            )
          ]
        ),
        // AutoRoute()
      ]
    )
  ],
)
class $AppRouter {}
