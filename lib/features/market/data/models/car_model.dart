import 'package:tes_express_app_new/features/market/domain/entities/car.dart'
    as entities;

/// Модель данных автомобиля для взаимодействия с API
class CarModelDTO extends entities.Car {
  const CarModelDTO({
    required super.id,
    super.vin,
    required super.brand,
    required super.model,
    required super.generation,
    required super.year,
    required super.color,
    required super.bodyType,
    super.currentLocation,
    super.status,
  });

  /// Фабричный метод для создания модели из JSON
  factory CarModelDTO.fromJson(Map<String, dynamic> json) {
    return CarModelDTO(
      id: json['id'] as int? ?? 0,
      vin: json['vin'] as String?,
      brand: BrandDTO.fromJson(json['brand'] as Map<String, dynamic>),
      model: ModelDTO.fromJson(json['model'] as Map<String, dynamic>),
      generation:
          GenerationDTO.fromJson(json['generation'] as Map<String, dynamic>),
      year: YearDTO.fromJson(json['year'] as Map<String, dynamic>),
      color: ColorDTO.fromJson(json['color'] as Map<String, dynamic>),
      bodyType: BodyTypeDTO.fromJson(json['bodyType'] as Map<String, dynamic>),
      currentLocation: json['currentLocation'] as String?,
      status: json['status'] as String?,
    );
  }

  /// Конвертация модели в JSON для отправки на сервер
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vin': vin,
      'brand': (brand as BrandDTO).toJson(),
      'model': (model as ModelDTO).toJson(),
      'generation': (generation as GenerationDTO).toJson(),
      'year': (year as YearDTO).toJson(),
      'color': (color as ColorDTO).toJson(),
      'bodyType': (bodyType as BodyTypeDTO).toJson(),
      'currentLocation': currentLocation,
      'status': status,
    };
  }
}

class BrandDTO extends entities.Brand {
  const BrandDTO({required super.name});

  factory BrandDTO.fromJson(Map<String, dynamic> json) {
    return BrandDTO(
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}

class ModelDTO extends entities.CarModel {
  const ModelDTO({required super.name, required super.brand});

  factory ModelDTO.fromJson(Map<String, dynamic> json) {
    return ModelDTO(
      name: json['name'] as String? ?? '',
      brand: BrandDTO.fromJson(json['brand'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': (brand as BrandDTO).toJson(),
    };
  }
}

class GenerationDTO extends entities.Generation {
  const GenerationDTO({required super.name, required super.model});

  factory GenerationDTO.fromJson(Map<String, dynamic> json) {
    return GenerationDTO(
      name: json['name'] as String? ?? '',
      model: ModelDTO.fromJson(json['model'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'model': (model as ModelDTO).toJson(),
    };
  }
}

class YearDTO extends entities.Year {
  const YearDTO({required super.id, required super.year});

  factory YearDTO.fromJson(Map<String, dynamic> json) {
    return YearDTO(
      id: json['id'] as int? ?? 0,
      year: json['year'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'year': year,
    };
  }
}

class ColorDTO extends entities.Color {
  const ColorDTO({required super.id, required super.name});

  factory ColorDTO.fromJson(Map<String, dynamic> json) {
    return ColorDTO(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class BodyTypeDTO extends entities.BodyType {
  const BodyTypeDTO({required super.name});

  factory BodyTypeDTO.fromJson(Map<String, dynamic> json) {
    return BodyTypeDTO(
      name: json['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
