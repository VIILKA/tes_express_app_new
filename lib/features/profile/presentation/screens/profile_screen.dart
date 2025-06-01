import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/car_status_with_scale_bar.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/custom_code.dart';
import 'package:tes_express_app_new/core/widgets/history_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/logistics_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/status_card.dart';
import 'package:tes_express_app_new/core/routes/main_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Метод для показа диалога удаления аккаунта
  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red),
              SizedBox(width: 10),
              Text('Удаление аккаунта'),
            ],
          ),
          content: Text(
            'Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить. Все ваши данные будут безвозвратно удалены.',
            style: AppTheme.bodySmall,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Показываем индикатор загрузки
                _showLoadingDialog('Удаление аккаунта...');

                // Вызываем событие удаления аккаунта
                context.read<AuthBloc>().add(DeleteAccount());
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Удалить аккаунт'),
            ),
          ],
        );
      },
    );
  }

  // Показывает диалог загрузки
  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(message),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Профиль',
                    style: AppTheme.displayLarge,
                  ),
                  const SizedBox(height: 10.0),
                  // Контент профиля
                  Row(
                    children: [
                      // Аватар
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/avatar_cat.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Информация о пользователе
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          String name = 'Пользователь';
                          String phone = 'Нет данных';
                          String location = 'Нет данных';

                          if (state is AuthLoggedIn && state.userData != null) {
                            name =
                                '${state.userData!.name} ${state.userData!.surname}';
                            phone = state.userData!.phoneNumber;
                            // Можно добавить город/локацию, если API будет предоставлять такие данные
                            location = 'Пользователь';
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: AppTheme.displayMedium,
                              ),
                              Text(
                                phone,
                                style: AppTheme.bodyMedium500
                                    .copyWith(color: AppTheme.greyText),
                              ),
                              Text(
                                location,
                                style: AppTheme.bodyMedium500
                                    .copyWith(color: AppTheme.greyText),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  const Divider(
                    height: 32.0,
                    thickness: 1.0,
                    color: Colors.grey,
                  ),
                  CustomCodeWidget(
                    code: 'AVX-A1',
                    description: 'Ваш индивидуальный код',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  StatusCard(
                    inTransit: 5,
                    atWarehouse: 2,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            CarStatusWithScaleBar(
              title: 'Lixiang L7 Pro',
              vinCode: 'HLX781788912311840',
              imagePath:
                  'assets/images/lixiang_l7.png', // Путь к вашему изображению
              status: 'Доставлен',
              deliveryDate: '15.01.2025-16.01.2025',
              onButtonPressed: () {
                context.go('/profile/car_details_status', extra: {
                  'title': 'Lixiang L7 Pro',
                  'vinCode': 'HLX781788912311840',
                  'imagePath': 'assets/images/lixiang_l7.png'
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            CarStatusWithScaleBar(
              title: 'Zeekr 001 FR',
              vinCode: 'ND78124612541219',
              imagePath: 'assets/images/zeekr_001.png',
              status: 'Доставлен',
              deliveryDate: '15.01.2025-16.01.2025',
              onButtonPressed: () {
                context.go('/profile/car_details_status', extra: {
                  'title': 'Zeekr 001 FR',
                  'vinCode': 'ND78124612541219',
                  'imagePath': 'assets/images/zeekr_001.png'
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            HistoryCard(
              title: 'История',
              description:
                  'Сейчас мы едем до вашего пункта назначения, готовьтесь получать',
              onButtonPressed: () {
                context.push(
                    '${RouteConstants.profile}/${RouteConstants.orderHistory}');
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedOut) {
                  // Если после логаута состояние AuthLoggedOut,
                  // перенаправляем пользователя на /login
                  context.go('/login');
                }
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  // Кнопка выхода
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(Logout());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.main,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Выйти из аккаунта'),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Кнопка удаления аккаунта
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextButton(
                      onPressed: _showDeleteAccountDialog,
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_forever, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Удалить аккаунт'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
