import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_express_app_new/features/market/presentation/bloc/car_bloc.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/components/car_card.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/components/filter_chips.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  String _selectedFilter = 'Все';

  @override
  void initState() {
    super.initState();
    // Запрашиваем загрузку данных при создании экрана
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CarBloc>().add(GetCarsEvent());
    });
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    context.read<CarBloc>().add(FilterCarsEvent(filter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Автомобили',
          style: AppTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CarBloc, CarState>(
          builder: (context, state) {
            if (state is CarLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CarError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CarBloc>().add(GetCarsEvent());
                      },
                      child: const Text('Попробовать снова'),
                    ),
                  ],
                ),
              );
            }

            if (state is CarUnauthorizedError) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 64.sp,
                        color: AppTheme.main,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Требуется авторизация',
                        style: AppTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.message,
                        style: AppTheme.bodyMedium500
                            .copyWith(color: AppTheme.greyText),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.go(RouteConstants.login);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.main,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text(
                            'Войти',
                            style: AppTheme.bodyMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(ContinueAsGuest());
                        },
                        child: Text(
                          'Продолжить как гость',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.greyText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is CarLoaded) {
              if (state.cars.isEmpty) {
                return const Center(
                  child: Text('Список автомобилей пуст'),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  FilterChips(
                    selectedFilter: _selectedFilter,
                    onFilterSelected: _onFilterSelected,
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: state.cars.length,
                      itemBuilder: (context, index) {
                        final car = state.cars[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: CarCard(
                            title: car.name,
                            subtitle: car.details,
                            color: car.color.name,
                            bodyType: car.bodyType.name,
                            onViewPressed: () {
                              // Переходим на страницу деталей автомобиля с передачей параметров
                              final carId = car.id.toString();
                              final carName = car.name;
                              final description = car.details;

                              context.push(
                                '${RouteConstants.market}/${RouteConstants.cars}/$carId',
                                extra: {
                                  'carId': carId,
                                  'carName': carName,
                                  'description': description,
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            // Показываем загрузку по умолчанию
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
