import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:dartz/dartz.dart';

class ProductsRepository implements BaseProductsRepository {
  final ApiMethods api;
  ProductsRepository(this.api);
  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      final response = await api.get(ApiConstances.productsPath);
      final List<dynamic> dataList = response['data']['data'] as List;
      final List<ProductModel> allProducts =
          dataList
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return Right(allProducts);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getHomeProductsTopRated() async {
    try {
      final response = await api.get(ApiConstances.productsTopRatedPath);

      final data = response['data']['data'] as List;

      final List<ProductModel> productsTopRated =
          data
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();

      return Right(productsTopRated);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getProductsByCategoryName(
    String categoryName,
  ) async {
    try {
      final response = await api.get(
        ApiConstances.productsPath,
        queryParameters: {'category': categoryName},
      );
      final List<dynamic> dataList = response['data']['data'] as List;
      final List<ProductModel> products =
          dataList
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> addToCart(
    int productId,
    int newQuantity,
  ) async {
    try {
      final response = await api.post(
        ApiConstances.addToCart,
        data: {"product_id": productId, "quantity": newQuantity},
      );

      final itemsList = response["data"]["cart"]["items"] as List;
      final List<ProductModel> productsInCart =
          itemsList
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return Right(productsInCart);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  // Future<Either<String,List<ProductModel>>> removeFromCart(int productId) async {
  //   try {
  //     final response = await api.post(
  //       ApiConstances.removeFromCart,
  //       data: {"product_id": productId},
  //     );
  //     return Right(response);
  //   } on ServerException catch (e) {
  //     return Left(e.errorModel.errorMessage);
  //   }
  // }
  // @override
  // Future<Either<String, List<ProductModel>>> removeFromCart(int productId) async {
  // try {
  //   final response = await api.post(
  //     ApiConstances.removeFromCart,
  //     data: {"product_id": productId},
  //   );

  //   final itemsList = response["data"]["cart"]["items"] as List;
  //   final List<ProductModel> updatedCart =
  //       itemsList.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();

  //   return Right(updatedCart);

  // } on ServerException catch (e) {
  //   return Left(e.errorModel.errorMessage);
  // }
  @override
  Future<Either<String, List<ProductModel>>> removeFromCart(
    int productId,
  ) async {
    try {
      final response = await api.post(
        ApiConstances.removeFromCart,
        data: {"product_id": productId},
      );

      final data = response['data'] as Map<String, dynamic>?;
      final cart = data?['cart'] as Map<String, dynamic>?;
      final itemsList = cart?['items'] as List?;

      if (itemsList != null && itemsList.isNotEmpty) {
        final List<ProductModel> updatedCart =
            itemsList
                .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
                .toList();

        return Right(updatedCart);
      } else {
        return Right([]); // السلة فارغة بعد الحذف
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
