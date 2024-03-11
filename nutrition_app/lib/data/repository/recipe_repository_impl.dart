import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nutrition_app/core/resources/data_state.dart';
import 'package:nutrition_app/data/data_sources/remote/meal_api_service.dart';
import 'package:nutrition_app/data/models/recipe_model.dart';
import 'package:nutrition_app/domain/repository/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final MealApiService _mealApiService;
  RecipeRepositoryImpl(this._mealApiService);

  @override
  Future<DataState<List<RecipeModel>>> getRandomRecipes(int amount) async {
    try {
      List<RecipeModel> recipies = [];
      for (int i = 0; i < amount; ++i) {
        DataState<RecipeModel> dataStateRecipe = await getRandomRecipe();
        if (dataStateRecipe is DataFailed) {
          return DataFailed(dataStateRecipe.error!);
        } else {
          assert(recipies is DataSuccess);
          recipies.add(dataStateRecipe.data!);
        }
      }
      return DataSuccess(recipies);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<DataState<RecipeModel>> getRandomRecipe() async {
    try {
      final httpResponse = await _mealApiService.getRandomRecipe();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
