import 'package:tes_express_app_new/features/market/domain/entities/car.dart';

/// Интерфейс репозитория для работы с автомобилями
abstract class CarRepository {
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
