import 'package:tes_express_app_new/features/market/data/datasources/car_remote_data_source.dart';
import 'package:tes_express_app_new/features/market/domain/entities/car.dart';
import 'package:tes_express_app_new/features/market/domain/repositories/car_repository.dart';

/// Реализация репозитория для работы с автомобилями
class CarRepositoryImpl implements CarRepository {
  final CarRemoteDataSource remoteDataSource;

  CarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Car>> getCars() async {
    try {
      return await remoteDataSource.getCars();
    } catch (e) {
      // Централизованная обработка ошибок
      // Можно добавить логирование или особую обработку ошибок
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
      return await remoteDataSource.getFilteredCars(
        brandId: brandId,
        modelId: modelId,
        generationId: generationId,
        year: year,
        colorId: colorId,
        bodyTypeId: bodyTypeId,
      );
    } catch (e) {
      // Централизованная обработка ошибок
      rethrow;
    }
  }
}
