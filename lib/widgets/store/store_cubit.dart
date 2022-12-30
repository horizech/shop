import 'package:apiraiser/apiraiser.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/collection.dart';
import 'package:shop/models/collection_tree.dart';
import 'package:shop/models/gallery.dart';
import 'package:shop/models/keyword.dart';
import 'package:shop/models/product_option_value.dart';
import 'package:shop/models/product_options.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  StoreCubit()
      : super(StoreState(
          false,
          false,
          false,
          "",
          [],
          null,
          [],
          [],
          [],
          [],
        ));

  void getStore() async {
    Apiraiser.validateAuthentication();
    setStoreStart();

    try {
      dynamic futureResult = await Future.wait([
        Apiraiser.data.get("Collections", 0),
        Apiraiser.data.get("Keywords", 0),
        Apiraiser.data.get("ProductOptions", 0),
        Apiraiser.data.get("ProductOptionValues", 0),
        Apiraiser.data.get("Gallery", 0),
      ]);

      List<APIResult> result = futureResult as List<APIResult>;
      if (result.any((element) => !element.success)) {
        setStoreError("Result not found");
      } else {
        List<Collection> collections = (result[0].data as List<dynamic>)
            .map((c) => Collection.fromJson(c as Map<String, dynamic>))
            .toList();
        List<Keyword> keywords = (result[1].data as List<dynamic>)
            .map((k) => Keyword.fromJson(k as Map<String, dynamic>))
            .toList();

        List<ProductOption> productOptions = (result[2].data as List<dynamic>)
            .map((t) => ProductOption.fromJson(t as Map<String, dynamic>))
            .toList();
        List<ProductOptionValue> productOptionValues = (result[3].data
                as List<dynamic>)
            .map((t) => ProductOptionValue.fromJson(t as Map<String, dynamic>))
            .toList();
        List<Gallery> mediaGroups = (result[4].data as List<dynamic>)
            .map((t) => Gallery.fromJson(t as Map<String, dynamic>))
            .toList();

        CollectionTree collectionTree =
            CollectionTree.fromCollectionList(collections);

        setStoreSuccess(
          collections,
          collectionTree,
          keywords,
          productOptions,
          productOptionValues,
          mediaGroups,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setStoreStart() {
    emit(StoreState(
      true,
      false,
      false,
      "",
      [],
      null,
      [],
      [],
      [],
      [],
    ));
  }

  void setStoreSuccess(
    List<Collection>? collections,
    CollectionTree? collectionTree,
    List<Keyword>? keywords,
    List<ProductOption>? productOptions,
    List<ProductOptionValue>? productOptionValues,
    List<Gallery>? mediaGroups,
  ) {
    emit(StoreState(
      false,
      true,
      false,
      null,
      collections,
      collectionTree,
      keywords,
      productOptions,
      productOptionValues,
      mediaGroups,
    ));
  }

  void setStoreError(String? error) {
    emit(StoreState(
      false,
      false,
      true,
      error,
      [],
      null,
      [],
      [],
      [],
      [],
    ));
  }
}
