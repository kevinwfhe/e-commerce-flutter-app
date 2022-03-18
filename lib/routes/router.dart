import "package:auto_route/auto_route.dart";
import 'package:csi5112group1project/screens/common/login_screen.dart';
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
      page: LoginScreen,
      initial: true
    ),
    AutoRoute(
      path: '/client',
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
  ],
)
class $AppRouter {}
