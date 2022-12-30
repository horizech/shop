import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ProductVariation extends Equatable {
  final int id;
  final DateTime? createdOn;
  final int? createdBy;
  final DateTime? lastUpdatedOn;
  final int? lastUpdatedBy;
  final String? description;
  final int product;
  final Map<String, int> options;
  final String? sku;
  final double? price;
  final double? discounPrice;
  final DateTime? discountStartDate;
  final DateTime? discountEndDate;
  final int? gallery;
  final String? name;
  // final int? quantity;

  const ProductVariation(
    this.id,
    this.createdOn,
    this.createdBy,
    this.lastUpdatedOn,
    this.lastUpdatedBy,
    this.name,
    this.description,
    this.product,
    this.options,
    this.price,
    this.sku,
    this.discounPrice,
    this.discountStartDate,
    this.discountEndDate,
    this.gallery,
    // this.quantity,
  );

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    try {
      ProductVariation productVariation = ProductVariation(
        json['Id'] as int,
        json['CreatedOn'] != null
            ? (json['CreatedOn'] is String)
                ? DateTime.parse(json['CreatedOn'] as String)
                : json['CreatedOn']
            : null,
        json['CreatedBy'] as int?,
        json['LastUpdatedOn'] != null
            ? (json['LastUpdatedOn'] is String)
                ? DateTime.parse(json['LastUpdatedOn'] as String)
                : json['LastUpdatedOn']
            : null,
        json['LastUpdatedBy'] as int?,
        json['Name'] as String?,
        json['Description'] as String?,
        json['Product'] as int,
        (jsonDecode(json['Options'] as String) as Map<String, dynamic>)
            .cast<String, int>(),
        json['Price'] as double?,
        json['SKU'] as String?,
        json['DiscountPrice'] as double?,
        json['DiscountStartDate'] != null
            ? (json['DiscountStartDate'] is String)
                ? DateTime.parse(json['DiscountStartDate'] as String)
                : json['DiscountStartDate']
            : null,
        json['DiscountEndDate'] != null
            ? (json['DiscountEndDate'] is String)
                ? DateTime.parse(json['DiscountEndDate'] as String)
                : json['DiscountEndDate']
            : null,
        json['Gallery'] as int?,
        // json['Quantity'] as int?,
      );

      return productVariation;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Map<String, dynamic> toJson(ProductVariation instance) {
    return <String, dynamic>{
      'Id': instance.id,
      'CreatedOn': instance.createdOn,
      'CreatedBy': instance.createdBy,
      'LastUpdatedOn': instance.lastUpdatedOn,
      'LastUpdatedBy': instance.lastUpdatedBy,
      'Description': instance.description,
      'Product': instance.product,
      'Options': instance.options,
      'SKU': instance.sku,
      'Price': instance.price,
      'DiscountPrice': instance.discounPrice,
      'DiscountStartDate': instance.discountStartDate,
      'DiscountEndDate': instance.discountEndDate,
      'Gallery': instance.gallery,
      'Name': instance.name,
      // 'Quantity': instance.quantity,
    };
  }

  @override
  List<Object?> get props => [
        id,
        createdOn,
        createdBy,
        lastUpdatedOn,
        lastUpdatedBy,
        description,
        product,
        sku,
        price,
        discounPrice,
        discountStartDate,
        discountEndDate,
        name,
      ];
}
