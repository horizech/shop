import 'package:apiraiser/apiraiser.dart';
import 'package:flutter_up/flutter_up_app.dart';
import 'package:flutter_up/models/up_route.dart';
import 'package:flutter_up/models/up_router_state.dart';
import 'package:flutter_up/themes/up_themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/constants.dart';
import 'package:shop/pages/authentication/loginsignup.dart';
import 'package:shop/pages/cart/cart.dart';
import 'package:shop/pages/payment/payment.dart';
import 'package:shop/pages/payment_method/card_payment_page.dart';
import 'package:shop/pages/payment_method/payment_method_page.dart';
import 'package:shop/pages/product/product.dart';
import 'package:shop/pages/products/products.dart';
import 'package:shop/pages/simple_home/simple_homepage.dart';
import 'package:shop/pages/store_dependant_page.dart';
import 'package:shop/widgets/cart/cart_cubit.dart';
import 'package:shop/widgets/media/media_cubit.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Mediacubit(),
      child: BlocProvider(
        create: (_) => CartCubit(),
        child: BlocProvider(
          create: (_) => StoreCubit(),
          child: FlutterUpApp(
              themeCollection: UpThemes.predefinedThemesCollection,
              defaultThemeId: UpThemes.vintage.id,
              title: 'Shop',
              initialRoute: Routes.simplehome,
              upRoutes: [
                UpRoute(
                  path: Routes.loginSignup,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const LoginSignupPage(),
                  name: Routes.loginSignup,
                  shouldRedirect: () => Apiraiser.authentication.isSignedIn(),
                  redirectRoute: Routes.simplehome,
                ),
                // UpRoute(
                //   name: Routes.login,
                //   path: Routes.login,
                //   shouldRedirect: () =>
                //       Apiraiser.authentication.isSignedIn() == true,
                //   redirectRoute: SimpleHomePage.routeName,
                //   pageBuilder: (BuildContext context, UpRouterState state) =>
                //       const LoginPage(),
                // ),
                // UpRoute(
                //   name: Routes.signup,
                //   path: Routes.signup,
                //   pageBuilder: (BuildContext context, UpRouterState state) =>
                //       const SignupPage(),
                // ),
                UpRoute(
                  name: Routes.simplehome,
                  path: Routes.simplehome,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: SimpleHomePage(),
                  ),
                ),
                UpRoute(
                  name: Routes.cart,
                  path: Routes.cart,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: CartPage(),
                  ),
                ),
                UpRoute(
                  name: Routes.product,
                  path: Routes.product,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: ProductPage(
                      queryParams: state.queryParams,
                    ),
                  ),
                ),
                UpRoute(
                  name: Routes.products,
                  path: Routes.products,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: Products(
                      queryParams: state.queryParams,
                    ),
                  ),
                ),
                UpRoute(
                  path: Routes.payment,
                  name: Routes.payment,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      Apiraiser.authentication.isSignedIn()
                          ? const StoreDependantPage(
                              page: PaymentPage(),
                            )
                          : const PaymentPage(),
                ),
                UpRoute(
                  path: PaymentMethodsPage.routeName,
                  name: PaymentMethodsPage.routeName,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: PaymentMethodsPage(),
                  ),
                ),
                UpRoute(
                  path: CardPaymentPage.routeName,
                  name: CardPaymentPage.routeName,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const CardPaymentPage(),
                )
              ]

              //   SimpleHomePage.routeName: (context) =>
              //       const StoreDependantPage(page: SimpleHomePage()),
              //   Products.routeName: (context) => const Products(),
              //   ProductDetailPage.routeName: (context) =>
              //       const ProductDetailPage(),
              //   CartPage.routeName: (context) => CartPage(),
              //   LoginPage.routeName: (context) => const LoginPage(),
              //   SignupPage.routeName: (context) => const SignupPage(),
              //   PaymentPage.routeName: (context) => const PaymentPage(),
              //   // '/collection': (context) => const SubCategoryPage(),
              //   // '/products?id=${1}': (context) => const Products()
              // },
              // home: const LoginPage(),
              // home: const StoreDependantPage(page: SimpleHomePage()),
              ),
        ),
      ),
    );
  }
}
