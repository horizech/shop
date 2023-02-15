import 'package:flutter_up/config/up_config.dart';
import 'package:flutter_up/enums/text_style.dart';
import 'package:flutter_up/locator.dart';
import 'package:flutter_up/services/up_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable_tree_menu/expandable_tree_menu.dart';
import 'package:flutter_up/themes/up_style.dart';
import 'package:flutter_up/widgets/up_expansion_tile.dart';
import 'package:flutter_up/widgets/up_text.dart';
import 'package:shop/constants.dart';
import 'package:shop/services/variation.dart';
import 'package:shop/models/collection_tree.dart';
import 'package:shop/models/collection_tree_item.dart';
import 'package:shop/models/collection_tree_node.dart';
import 'package:shop/widgets/store/store_cubit.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
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
        return Drawer(
          backgroundColor: UpConfig.of(context).theme.secondaryColor,

          // backgroundColor: Colors.black,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      ServiceManager<UpNavigationService>()
                          .navigateToNamed(Routes.simplehome);
                    });
                  },
                  leading: Icon(Icons.home,
                      color: UpConfig.of(context).theme.primaryColor),
                  title: const UpText(
                    'Home',
                    type: UpTextType.heading5,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: ListTile(
                  onTap: () {
                    ServiceManager<VariationService>().removeVariation();

                    ServiceManager<UpNavigationService>()
                        .navigateToNamed(Routes.products, queryParams: {
                      "collection": '9',
                    });
                  },
                  leading: Icon(Icons.directions_car,
                      color: UpConfig.of(context).theme.primaryColor),
                  title: const UpText(
                    'Used Cars',
                    type: UpTextType.heading5,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      ServiceManager<UpNavigationService>()
                          .navigateToNamed(Routes.simplehome);
                    });
                  },
                  leading: Icon(Icons.airport_shuttle,
                      color: UpConfig.of(context).theme.primaryColor),
                  title: const UpText(
                    'Used Vans',
                    type: UpTextType.heading5,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: const UpExpansionTile(
                  title: "Finance",
                  children: [
                    UpText("Car Finance"),
                    UpText("Finance Explaned"),
                    UpText("Free Finance CheckerS")
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: const UpExpansionTile(
                  title: "Valuation",
                  children: [
                    UpText("Part Exchange"),
                    UpText("Sell Your Car"),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: const UpExpansionTile(
                  title: "About Us",
                  children: [
                    UpText("About Us"),
                    UpText("Reviews"),
                    UpText("Blog"),
                    UpText("Careers"),
                    UpText("Working with Us"),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      ServiceManager<UpNavigationService>()
                          .navigateToNamed(Routes.simplehome);
                    });
                  },
                  leading: Icon(Icons.location_on,
                      color: UpConfig.of(context).theme.primaryColor),
                  title: const UpText(
                    'Locations',
                    type: UpTextType.heading5,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: UpConfig.of(context).theme.primaryColor),
                    )),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      ServiceManager<UpNavigationService>()
                          .navigateToNamed(Routes.simplehome);
                    });
                  },
                  leading: Icon(Icons.contact_mail_rounded,
                      color: UpConfig.of(context).theme.primaryColor),
                  title: const UpText(
                    'Contact Us',
                    type: UpTextType.heading5,
                  ),
                ),
              ),
              // ExpandableTree(
              //   childIndent: 8,
              //   // twistyPosition: TwistyPosition.after,
              //   childrenDecoration:
              //       const BoxDecoration(color: Colors.transparent),
              //   submenuOpenColor: Colors.transparent,
              //   submenuClosedColor: Colors.transparent,
              //   submenuDecoration: const BoxDecoration(
              //     color: Colors.transparent,
              //     // border: Border.all(),
              //   ),
              //   submenuMargin: const EdgeInsets.all(3),
              //   childrenMargin: const EdgeInsets.all(3),
              //   openTwistyColor: UpConfig.of(context).theme.primaryColor,
              //   closedTwistyColor: UpConfig.of(context).theme.primaryColor,
              //   nodes: nodes,
              //   nodeBuilder: (context, nodeValue) => Text(
              //     (nodeValue as CollectionTreeItem).name.toString(),
              //     style: Theme.of(context).textTheme.headline6!.copyWith(
              //         backgroundColor: Colors.transparent,
              //         fontSize: 14,
              //         color: UpConfig.of(context).theme.primaryColor),
              //   ),
              //   onSelect: (node) {
              //     ServiceManager<VariationService>().removeVariation();

              //     ServiceManager<UpNavigationService>()
              //         .navigateToNamed(Routes.products, queryParams: {
              //       "collection": '${(node as CollectionTreeItem).id}',
              //     });
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
            
            
            
//              Center(
//               child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: collectionTree!.roots!
//                       .map(
//                         (e) => Column(
//                           children: [
//                             ListTile(
//                               title: Text(
//                                 e.name,
//                                 style: Theme.of(context).textTheme.headline6,
//                               ),
//                               onTap: () {
//                                
//                               },
//                             ),
//                             childrenWidget(context, e)
//                           ],
//                         ),
//                       )
//                       .toList()),
//             ),
//           );
//         });
//   }
// }

// Widget childrenWidget(
//     BuildContext context, CollectionTreeItem collectionTreeItem) {
//   return Column(
//       children: collectionTreeItem.children != null
//           ? collectionTreeItem.children!
//               .map((e) => Text(
//                     e.name,
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline6!
//                         .copyWith(color: Colors.white),
//                   ))
//               .toList()
//           : [const Text("")]);
// }
