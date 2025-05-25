import 'package:al_omda/features/products/data/models/most_resent_products_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseProductsRepository {
  Future<Either<String, List<MostRecentProductsModel>>> getMostRecentProducts();
}
