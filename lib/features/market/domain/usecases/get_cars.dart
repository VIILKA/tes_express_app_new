import '../entities/car.dart';
import '../repositories/car_repository.dart';

class GetCars {
  final CarRepository repository;

  GetCars(this.repository);

  Future<List<Car>> call() async {
    return await repository.getCars();
  }

  Future<List<Car>> getFiltered({required String filter}) async {
    int? filterId;
    switch (filter) {
      case 'Электро':
        filterId = 1;
        break;
      case 'Гибрид':
        filterId = 2;
        break;
      case 'Бензин':
        filterId = 3;
        break;
      default:
        return await repository.getCars();
    }
    return await repository.getFilteredCars(bodyTypeId: filterId);
  }
}
