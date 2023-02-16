import 'package:flutter/material.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/widgets/appbar/custom_appbar.dart';
import 'package:shop/widgets/drawer/MenuDrawer.dart';
import 'package:shop/widgets/search/search_widget.dart';

class AutomobileSearchPage extends StatefulWidget {
  final Map<String, String>? queryParams;
  const AutomobileSearchPage({
    this.queryParams,
    Key? key,
  }) : super(key: key);

  @override
  State<AutomobileSearchPage> createState() => _AutomobileSearchPageState();
}

class _AutomobileSearchPageState extends State<AutomobileSearchPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    List<Collection> root = [];
    return Scaffold(
      key: scaffoldKey,
      drawer: const MenuDrawer(),
      drawerEnableOpenDragGesture: false,
      endDrawerEnableOpenDragGesture: false,
      body: Column(
        children: [
          CustomAppbar(
            scaffoldKey: scaffoldKey,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: const [
                  SizedBox(
                    height: 250,
                    width: 400,
                    child: SearchWidget(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
