import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseProductsRepository {
  Future<Either<String, List<ProductModel>>> getAllProducts();
  Future<Either<String, List<ProductModel>>> getHomeProductsTopRated();
  Future<Either<String, List<ProductModel>>> getProductsByCategoryName(
    String categoryName,
  );
  Future<Either<String, List<ProductModel>>> addProductToCart(
    int productId,
    int newQuantity,
  );
  Future<Either<String, List<ProductModel>>> removeProductFromCart(
    int productId,
  );
}
