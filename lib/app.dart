import 'package:apiraiser/apiraiser.dart';

import 'package:flutter_up/models/up_route.dart';
import 'package:flutter_up/models/up_router_state.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/themes/up_theme_data.dart';
import 'package:flutter_up/themes/up_themes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/up_app.dart';
import 'package:shop/constants.dart';
import 'package:shop/pages/admin/add_edit_product.dart';
import 'package:shop/pages/admin/add_edit_product_variation.dart';
import 'package:shop/pages/admin/admin_product_options.dart';
import 'package:shop/pages/admin/admin_product_variations.dart';
import 'package:shop/pages/admin/admin_products.dart';
import 'package:shop/pages/authentication/loginsignup.dart';
import 'package:shop/pages/cart/cart.dart';
import 'package:shop/pages/home/home_page_food.dart';
import 'package:shop/pages/payment/payment.dart';
import 'package:shop/pages/payment_method/card_payment_page.dart';
import 'package:shop/pages/payment_method/payment_method_page.dart';
import 'package:shop/pages/product/product_automobile.dart';
import 'package:shop/pages/products/products_automobile_grid.dart';
import 'package:shop/pages/products/food_products_list.dart';
import 'package:shop/pages/search/automobile_search.dart';
import 'package:shop/pages/simple_home/simple_homepage.dart';
import 'package:shop/pages/store_dependant_page.dart';
import 'package:shop/widgets/cart/cart_cubit.dart';
import 'package:shop/widgets/media/media_cubit.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UpThemeData theme = UpThemes.generateThemeByColor(
      primaryColor: const Color.fromRGBO(
        64,
        64,
        64,
        1.0,
      ),
    );
    theme.primaryStyle = theme.primaryStyle.copyWith(
      UpStyle(textColor: Colors.white, iconColor: Colors.white),
    );

    return BlocProvider(
      create: (_) => Mediacubit(),
      child: BlocProvider(
        create: (_) => CartCubit(),
        child: BlocProvider(
          create: (_) => StoreCubit(),
          child: UpApp(
              theme: UpThemes.generateThemeByColor(
                // primaryColor: Colors.greenAccent,
                primaryColor: const Color.fromRGBO(200, 16, 46, 1.0),
                secondaryColor: Colors.white,
              ),
              title: 'Shop',
              initialRoute: Routes.simplehome,
              upRoutes: [
                UpRoute(
                  path: Routes.loginSignup,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const LoginSignupPage(),
                  name: Routes.loginSignup,
                  shouldRedirect: () => Apiraiser.authentication.isSignedIn(),
                  redirectRoute: Routes.adminProduct,
                ),
                UpRoute(
                  name: Routes.simplehome,
                  path: Routes.simplehome,
                  shouldRedirect: () => Apiraiser.authentication.isSignedIn(),
                  redirectRoute: Routes.loginSignup,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: SimpleHomePage(),
                  ),
                ),
                UpRoute(
                  name: Routes.searchAutomobile,
                  path: Routes.searchAutomobile,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: AutomobileSearchPage(),
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
                  name: Routes.adminProduct,
                  path: Routes.adminProduct,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: AdminPage(),
                  ),
                  redirectRoute: Routes.loginSignup,
                  shouldRedirect: () => !Apiraiser.authentication.isSignedIn(),
                ),
                UpRoute(
                  name: Routes.addEditProduct,
                  path: Routes.addEditProduct,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: AddEditProduct(
                      queryParams: state.queryParams,
                    ),
                  ),
                  redirectRoute: Routes.loginSignup,
                  shouldRedirect: () => !Apiraiser.authentication.isSignedIn(),
                ),
                UpRoute(
                  name: Routes.adminProductVariations,
                  path: Routes.adminProductVariations,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: AdminProductvariationsPage(
                      queryParams: state.queryParams,
                    ),
                  ),
                  redirectRoute: Routes.loginSignup,
                  shouldRedirect: () => !Apiraiser.authentication.isSignedIn(),
                ),
                UpRoute(
                  name: Routes.addEditProductVariaton,
                  path: Routes.addEditProductVariaton,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: AddEditProductVariation(
                      queryParams: state.queryParams,
                    ),
                  ),
                  redirectRoute: Routes.loginSignup,
                  shouldRedirect: () => !Apiraiser.authentication.isSignedIn(),
                ),
                UpRoute(
                  name: Routes.product,
                  path: Routes.product,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: ProductAutomobilePage(
                      queryParams: state.queryParams,
                    ),
                  ),
                ),
                UpRoute(
                  name: Routes.adminProductOptions,
                  path: Routes.adminProductOptions,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: AdminProductOptionsPage(),
                  ),
                ),
                UpRoute(
                  name: Routes.products,
                  path: Routes.products,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      StoreDependantPage(
                    page: ProductsAutomobileGrid(
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
                ),
                // food routes

                UpRoute(
                  path: Routes.homePageFood,
                  name: Routes.homePageFood,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: HomePageFood(),
                  ),
                ),
                UpRoute(
                  path: Routes.foodProducts,
                  name: Routes.foodProducts,
                  pageBuilder: (BuildContext context, UpRouterState state) =>
                      const StoreDependantPage(
                    page: FoodProducts(),
                  ),
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
