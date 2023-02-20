import 'dart:ui';
import 'package:shop/constants.dart';
import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/locator.dart';
import 'package:flutter_up/services/up_navigation.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/up_app.dart';
import 'package:flutter_up/widgets/up_button.dart';
import 'package:flutter_up/widgets/up_dropdown.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/collection_tree.dart';
import 'package:shop/models/collection_tree_item.dart';
import 'package:shop/models/collection_tree_node.dart';
import 'package:shop/widgets/store/store_cubit.dart';
import 'package:shop/services/variation.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  gotoMakeModel(id) {
    Map<String, List<int>> selectedVariationsValues = {
      "Manufacturer": [id]
    };
    ServiceManager<VariationService>().setVariation(selectedVariationsValues);
  }

  @override
  Widget build(BuildContext context) {
    CollectionTree? collectionTree;
    return BlocConsumer<StoreCubit, StoreState>(
      listener: (context, state) {},
      builder: (context, state) {
        collectionTree = state.collectionTree;
        List<TreeNode> nodes = collectionTree!.roots!
            .map(
              (e) => TreeNode(
                e,
                subNodes: e.children != null && e.children!.isNotEmpty
                    ? getTreeSubNodes(e) ?? []
                    : const [TreeNode("")],
              ),
            )
            .toList();
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: UpConfig.of(context).theme.primaryColor, width: 4),
              borderRadius: BorderRadius.circular(4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: UpConfig.of(context).theme.primaryColor,
                    ),
                    Text(
                      "Make/Model Seach",
                      // style: UpConfig.of(context).theme.primaryColor,
                      style: TextStyle(
                        color: UpConfig.of(context).theme.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
                child: ExpandableTree(
                  childIndent: 8,
                  // twistyPosition: TwistyPosition.after,
                  childrenDecoration:
                      const BoxDecoration(color: Colors.transparent),
                  submenuOpenColor: Colors.transparent,
                  submenuClosedColor: Colors.transparent,
                  submenuDecoration: const BoxDecoration(
                    color: Colors.transparent,
                    // border: Border.all(),
                  ),
                  submenuMargin: const EdgeInsets.all(3),
                  childrenMargin: const EdgeInsets.all(3),
                  openTwistyColor: Colors.black,
                  closedTwistyColor: Colors.black,
                  nodes: nodes,
                  nodeBuilder: (context, nodeValue) => Text(
                    (nodeValue as CollectionTreeItem).name.toString(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                        backgroundColor: Colors.transparent,
                        fontSize: 14,
                        color: Colors.black),
                  ),
                  onSelect: (node) {
                    gotoMakeModel(7);
                    ServiceManager<UpNavigationService>()
                        .navigateToNamed(Routes.products, queryParams: {
                      "collection": '9',
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 52, vertical: 4),
                child: UpDropDown(
                  // value: value,
                  itemList: const [],
                  label: "Model",
                  onChanged: ((value) {}),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: UpButton(
                  onPressed: () {},
                  style: UpStyle(buttonWidth: 100),
                  text: "Search",
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
