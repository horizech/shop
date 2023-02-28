import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:shop/models/product_option_value.dart';
import 'package:shop/widgets/appbar/custom_appbar.dart';
import 'package:shop/widgets/drawer/MenuDrawer.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class HomePageFood extends StatefulWidget {
  const HomePageFood({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageFood> createState() => _HomePageFoodState();
}

class _HomePageFoodState extends State<HomePageFood> {
  List<ProductOptionValue> productOptionValues = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int? collection;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UpConfig.of(context).theme.secondaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: scaffoldKey,
        drawer: const MenuDrawer(),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        body: BlocConsumer<StoreCubit, StoreState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.collections != null && state.collections!.isNotEmpty) {
              collection = state.collections!
                  .where((element) => element.name == "Used Cars")
                  .first
                  .id;
            }

            return Column(
              children: [
                CustomAppbar(
                  scaffoldKey: scaffoldKey,
                ),
                const Text("food home"),
              ],
            );
          },
        ),
      ),
    );
  }
}
