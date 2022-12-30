part of 'store_cubit.dart';

class StoreState {
  final bool isLoading;
  final bool isSuccessful;
  final bool isError;
  final String? error;
  final List<Collection>? collections;
  final CollectionTree? collectionTree;
  final List<Keyword>? keywords;
  // final List<Gender>? genders;
  final List<ProductOption>? productOptions;
  final List<ProductOptionValue>? productOptionValues;

  // final List<SizeVariation>? sizes;
  // final List<ColorVariation>? colors;
  // final List<MaterialVariation>? materials;
  final List<Gallery>? mediaGroups;

  StoreState(
    this.isLoading,
    this.isSuccessful,
    this.isError,
    this.error,
    this.collections,
    this.collectionTree,
    this.keywords,
    // this.genders,
    this.productOptions,
    this.productOptionValues,
    this.mediaGroups,
  );
}
