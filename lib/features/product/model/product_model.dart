import 'package:Doctors_App/features/product/model/product_tier.dart';

enum ProductType { individual, medicalEstablishment }

class Product {
  final int id;
  final ProductType type;
  final List<String> productNames;
  final String shortDescription;
  final String fullDescription;
  final List<TierPlan> tiers;
  final DateTime createdDate;

  const Product({
    required this.id,
    required this.type,
    required this.productNames,
    required this.shortDescription,
    required this.fullDescription,
    required this.tiers,
    required this.createdDate,
  });
}
