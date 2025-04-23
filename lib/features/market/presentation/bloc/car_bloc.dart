import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tes_express_app_new/features/market/domain/entities/car.dart';
import 'package:tes_express_app_new/features/market/domain/repositories/car_repository.dart';

// Events
abstract class CarEvent extends Equatable {
  const CarEvent();

  @override
  List<Object?> get props => [];
}

/// Событие для загрузки всех автомобилей
class GetCarsEvent extends CarEvent {}

/// Событие для фильтрации автомобилей
class FilterCarsEvent extends CarEvent {
  final String filter;

  const FilterCarsEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

// States
abstract class CarState extends Equatable {
  const CarState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class CarInitial extends CarState {}

/// Состояние загрузки данных
class CarLoading extends CarState {}

/// Состояние с загруженными данными
class CarLoaded extends CarState {
  final List<Car> cars;

  const CarLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}

/// Состояние ошибки
class CarError extends CarState {
  final String message;

  const CarError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Состояние ошибки неподтвержденного аккаунта
class CarUnauthorizedError extends CarState {
  final String message;

  const CarUnauthorizedError(this.message);

  @override
  List<Object?> get props => [message];
}

/// BLoC для управления состоянием автомобилей
class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository carRepository;
  List<Car> _allCars = [];
  String _currentFilter = 'Все';

  CarBloc({required this.carRepository}) : super(CarInitial()) {
    on<GetCarsEvent>(_onGetCars);
    on<FilterCarsEvent>(_onFilterCars);
  }

  Future<void> _onGetCars(GetCarsEvent event, Emitter<CarState> emit) async {
    developer.log('CarBloc: Загрузка автомобилей');
    emit(CarLoading());

    try {
      developer.log('CarBloc: Запрос к репозиторию');
      _allCars = await carRepository.getCars();
      developer.log('CarBloc: Получено ${_allCars.length} автомобилей');

      // Применяем текущий фильтр, если он есть
      if (_currentFilter != 'Все') {
        _applyFilter(emit, _currentFilter);
      } else {
        emit(CarLoaded(_allCars));
      }
    } catch (e) {
      developer.log('CarBloc: Ошибка загрузки', error: e);

      // Проверяем, является ли ошибка ошибкой неавторизованного доступа (401)
      if (e is DioException && e.response?.statusCode == 401) {
        emit(CarUnauthorizedError(
            'Ваш аккаунт ещё не подтвержден модераторами. Пожалуйста, дождитесь подтверждения и попробуйте позже.'));
      } else {
        emit(CarError(
            'Не удалось загрузить список автомобилей: ${e.toString()}'));
      }
    }
  }

  void _onFilterCars(FilterCarsEvent event, Emitter<CarState> emit) {
    developer.log('CarBloc: Фильтрация по ${event.filter}');
    _currentFilter = event.filter;
    _applyFilter(emit, event.filter);
  }

  void _applyFilter(Emitter<CarState> emit, String filter) {
    if (_allCars.isEmpty) {
      developer.log('CarBloc: Список автомобилей пуст, фильтрация невозможна');
      return;
    }

    if (filter == 'Все') {
      developer.log('CarBloc: Выбраны все автомобили (${_allCars.length})');
      emit(CarLoaded(_allCars));
      return;
    }

    developer.log('CarBloc: Применение фильтра: $filter');
    final filteredCars = _allCars.where((car) {
      switch (filter) {
        case 'Электро':
          // Проверяем по названию модели или другим признакам
          return car.model.name.toLowerCase().contains('электро');
        case 'Гибрид':
          // Проверяем по названию модели или другим признакам
          return car.model.name.toLowerCase().contains('гибрид');
        case 'Бензин':
          // Проверяем по названию модели или другим признакам
          return !car.model.name.toLowerCase().contains('электро') &&
              !car.model.name.toLowerCase().contains('гибрид');
        case 'Новые':
          // Для примера считаем новыми автомобили последних 2-х лет
          return car.year.year >= DateTime.now().year - 1;
        case 'С пробегом':
          // Для примера считаем с пробегом автомобили старше 2-х лет
          return car.year.year < DateTime.now().year - 1;
        default:
          return true;
      }
    }).toList();

    developer.log(
        'CarBloc: Отфильтровано ${filteredCars.length} автомобилей из ${_allCars.length}');
    emit(CarLoaded(filteredCars));
  }
}
