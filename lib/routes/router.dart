import "package:auto_route/auto_route.dart";
import 'package:csi5112group1project/screens/admin/admin_main_screen.dart';
import 'package:csi5112group1project/screens/admin/admin_order_detail_screen/admin_order_detail_screen.dart';
import 'package:csi5112group1project/screens/admin/product_detail_manage_screen/product_detail_manage_screen.dart';
import 'package:csi5112group1project/screens/client/discussion_detail_screen/discussion_detail_screen.dart';
import 'package:csi5112group1project/screens/client/discussion_question_screen/discussion_question_screen.dart';
import 'package:csi5112group1project/screens/client/discussion_screen/discussion_screen.dart';
import 'package:csi5112group1project/screens/client/main_page.dart';
import 'package:csi5112group1project/screens/client/sign_up_screen/sign_up_screen.dart';
import '../screens/admin/authentication_admin_screen/authentification_admin_screen.dart';
import '../screens/client/checkout_screen/checkout_screen.dart';
import '../screens/client/product_detail_screen/product_detail_screen.dart';
import '../screens/client/products_screen/products_screen.dart';
import '../screens/client/order_placed_screen/order_placed_screen.dart';
import '../screens/client/order_detail_screen/order_detail_screen.dart';
import '../screens/client/orders_screen/orders_screen.dart';
import '../screens/client/cart_screen/cart_screen.dart';
import '../screens/client/authentication_client_screen/authentification_client_screen.dart';
import '../screens/client/client_main_screen.dart';

// auto_route documentation -> https://pub.dev/packages/auto_route

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: MainPage,
      initial: true,
    ),
    AutoRoute(
      path: '/order',
      name: 'StandAloneOrderRouter',
      page: EmptyRouterPage,
      initial: true,
      children: [
        AutoRoute(
          path: '',
          page: OrderScreen,
        ),
        AutoRoute(
          path: ':orderId',
          page: OrderDetailScreen,
        ),
      ],
    ),
    AutoRoute(
      path: '/discuss',
      name: 'StandAloneDiscussRouter',
      initial: true,
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          page: DiscussionScreen,
        ),
        AutoRoute(
          path: ':questionId',
          page: DiscussionDetailScreen,
        ),
      ],
    ),
    AutoRoute(
      path: '/ask',
      name: 'DiscussionQuestionScreen',
      page: DiscussionQuestionScreen,
    ),
    AutoRoute(
      path: '/checkout',
      name: 'CheckoutRouter',
      page: EmptyRouterPage,
      initial: true,
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
      ],
    ),
    AutoRoute(
      path: '/item/:productId',
      name: 'ProductDetailRoute',
      page: ProductDetailScreen,
    ),
    AutoRoute(
      path: '/cart',
      name: 'StandAloneCartRoute',
      page: CartScreen,
    ),
    AutoRoute(
      path: '/login',
      name: 'LoginRoute',
      page: AuthentificationClientScreen,
    ),
    AutoRoute(
      path: '/signup',
      name: 'SignUpRoute',
      page: SignUpScreen,
    ),
    AutoRoute(
      path: '/admin',
      name: 'AdminRouter',
      page: EmptyRouterPage,
      children: [
        AutoRoute(
          path: '',
          name: 'AdminMainRoute',
          page: AdminMainScreen,
        ),
        AutoRoute(
          path: 'login',
          name: 'AdminLoginRoute',
          page: AuthentificationAdminScreen,
        ),
        AutoRoute(
          path: 'product',
          name: 'AdminProductRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: ':productId',
              name: 'AdminProductDetail',
              page: ProductDetailManageScreen,
            )
          ],
        ),
        AutoRoute(
            path: 'order',
            name: 'AdminOrderRouter',
            page: EmptyRouterPage,
            children: [
              AutoRoute(
                path: ':orderId',
                name: 'AdminOrderDetail',
                page: AdminOrderDetailScreen,
              )
            ]),
      ],
    )
  ],
)
class $AppRouter {}
