import 'dart:developer' as developer;
import 'package:tes_express_app_new/core/api/api_service.dart';
import 'package:tes_express_app_new/features/market/data/models/car_model.dart';
import 'package:tes_express_app_new/features/market/domain/entities/car.dart';

/// Интерфейс удаленного источника данных для автомобилей
abstract class CarRemoteDataSource {
  /// Получить список всех автомобилей
  Future<List<Car>> getCars();

  /// Получить отфильтрованный список автомобилей
  Future<List<Car>> getFilteredCars({
    int? brandId,
    int? modelId,
    int? generationId,
    int? year,
    int? colorId,
    int? bodyTypeId,
  });
}

/// Реализация удаленного источника данных для автомобилей
class CarRemoteDataSourceImpl implements CarRemoteDataSource {
  final ApiService apiService;
  final String _apiPath = '/auto';

  CarRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<List<Car>> getCars() async {
    try {
      developer.log('Запрос списка автомобилей: $_apiPath/get/list');

      final response = await apiService.get('$_apiPath/get/list');

      developer.log('Ответ API: статус ${response.statusCode}');
      developer.log('Данные API: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final cars = jsonList.map((json) {
          try {
            return CarModelDTO.fromJson(json as Map<String, dynamic>);
          } catch (e) {
            developer.log('Ошибка парсинга объекта: $json', error: e);
            throw Exception('Ошибка при парсинге данных: $e');
          }
        }).toList();

        developer.log('Получено ${cars.length} автомобилей');
        return cars;
      } else {
        developer.log('Ошибка API: ${response.statusCode}',
            error: response.data);
        throw Exception(
            'Не удалось загрузить автомобили. Код: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Исключение при загрузке автомобилей', error: e);
      rethrow;
    }
  }

  @override
  Future<List<Car>> getFilteredCars({
    int? brandId,
    int? modelId,
    int? generationId,
    int? year,
    int? colorId,
    int? bodyTypeId,
  }) async {
    try {
      // Все параметры по умолчанию равны 0, чтобы API правильно обработал их
      final Map<String, dynamic> filterData = {
        'id': 0,
        if (brandId != null) 'brandId': brandId,
        if (modelId != null) 'modelId': modelId,
        if (generationId != null) 'generationId': generationId,
        if (year != null) 'year': year,
        if (colorId != null) 'colorId': colorId,
        if (bodyTypeId != null) 'bodyTypeId': bodyTypeId,
      };

      developer.log('Запрос фильтрованных автомобилей: $_apiPath/get/filtered');
      developer.log('Параметры фильтра: $filterData');

      final response = await apiService.post(
        '$_apiPath/get/filtered',
        data: filterData,
      );

      developer.log('Ответ API: статус ${response.statusCode}');
      developer.log('Данные API: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data as List<dynamic>;
        final cars = jsonList.map((json) {
          try {
            return CarModelDTO.fromJson(json as Map<String, dynamic>);
          } catch (e) {
            developer.log('Ошибка парсинга объекта: $json', error: e);
            throw Exception('Ошибка при парсинге данных: $e');
          }
        }).toList();

        developer.log('Получено ${cars.length} отфильтрованных автомобилей');
        return cars;
      } else {
        developer.log('Ошибка API: ${response.statusCode}',
            error: response.data);
        throw Exception(
            'Не удалось загрузить отфильтрованные автомобили. Код: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Исключение при загрузке отфильтрованных автомобилей',
          error: e);
      rethrow;
    }
  }
}
