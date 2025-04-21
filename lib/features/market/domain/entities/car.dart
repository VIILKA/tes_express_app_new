/// Базовая сущность автомобиля
class Car {
  final int id;
  final String? vin;
  final Brand brand;
  final CarModel model;
  final Generation generation;
  final Year year;
  final Color color;
  final BodyType bodyType;
  final String? currentLocation;
  final String? status;

  const Car({
    required this.id,
    this.vin,
    required this.brand,
    required this.model,
    required this.generation,
    required this.year,
    required this.color,
    required this.bodyType,
    this.currentLocation,
    this.status,
  });

  // Полное имя автомобиля
  String get name => '${brand.name} ${model.name}';

  // Отображаемая информация о деталях автомобиля
  String get details => '${year.year} • ${bodyType.name} • ${color.name}';
}

/// Модель бренда автомобиля
class Brand {
  final String name;

  const Brand({required this.name});
}

/// Модель автомобиля
class CarModel {
  final String name;
  final Brand brand;

  const CarModel({required this.name, required this.brand});
}

/// Поколение модели
class Generation {
  final String name;
  final CarModel model;

  const Generation({required this.name, required this.model});
}

/// Год выпуска
class Year {
  final int id;
  final int year;

  const Year({required this.id, required this.year});
}

/// Цвет автомобиля
class Color {
  final int id;
  final String name;

  const Color({required this.id, required this.name});
}

/// Тип кузова
class BodyType {
  final String name;

  const BodyType({required this.name});
}
