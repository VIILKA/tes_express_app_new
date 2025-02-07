import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/features/logistic/presentation/screens/components/car_details_card.dart';
import 'package:tes_test_app/features/profile/presentation/screens/components/custom_code.dart';
import 'package:tes_test_app/features/profile/presentation/screens/components/history_card.dart';
import 'package:tes_test_app/features/profile/presentation/screens/components/logistics_card.dart';
import 'package:tes_test_app/features/profile/presentation/screens/components/status_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Андрей',
                            style: AppTheme.displayMedium,
                          ),
                          Text(
                            '+996 550 88-99-11',
                            style: AppTheme.bodyMedium500
                                .copyWith(color: AppTheme.greyText),
                          ),
                          Text(
                            'Bishkek',
                            style: AppTheme.bodyMedium500
                                .copyWith(color: AppTheme.greyText),
                          ),
                        ],
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
                  LogisticsCard(
                    title: 'Логистика',
                    buttonText: 'Посмотреть',
                    onButtonPressed: () {
                      print('Кнопка "Посмотреть" нажата');
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            CarDetailsCard(
              title: 'Lixiang L7 Pro',
              vinCode: 'HLX781788912311840',
              imagePath:
                  'assets/images/lixiang_l7.png', // Путь к вашему изображению
              status: 'Доставлен',
              deliveryDate: '15.01.2025-16.01.2025',
              onButtonPressed: () {
                print('Нажата кнопка "Посмотреть"');
              },
            ),
            SizedBox(
              height: 10,
            ),
            CarDetailsCard(
              title: 'Lixiang L7 Pro',
              vinCode: 'HLX781788912311840',
              imagePath:
                  'assets/images/lixiang_l7.png', // Путь к вашему изображению
              status: 'Доставлен',
              deliveryDate: '15.01.2025-16.01.2025',
              onButtonPressed: () {
                print('Нажата кнопка "Посмотреть"');
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
                print('Кнопка "Посмотреть" нажата');
              },
            ),
          ],
        ),
      )),

      // BlocListener<AuthBloc, AuthState>(
      //   listener: (context, state) {
      //     if (state is AuthLoggedOut) {
      //       // Если после логаута состояние AuthLoggedOut,
      //       // перенаправляем пользователя на /login
      //       context.go('/login');
      //     }
      //   },
      //   child: Center(
      //     child: ElevatedButton(
      //       onPressed: () {
      //         // При нажатии вызываем событие Logout
      //         context.read<AuthBloc>().add(Logout());
      //       },
      //       child: const Text('Выйти из аккаунта'),
      //     ),
      //   ),
      // ),
    );
  }
}
