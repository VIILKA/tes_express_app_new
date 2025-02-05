import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/features/home/presentation/screens/components/available_car.dart';
import 'package:tes_test_app/core/widgets/circular_avatar.dart';
import 'package:tes_test_app/features/home/presentation/screens/components/car_status_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Главное',
                  style: AppTheme.displayLarge,
                ),
                CircularAvatar(
                    imageUrl: 'assets/images/avatar_cat.png',
                    size: 30.0,
                    borderWidth: 0.0,
                    borderColor: AppTheme.black),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CarStatusCard(),
            SizedBox(
              height: 20,
            ),
            AvailableCar(
              onButtonPressed: () {},
            ),
            SizedBox(
              height: 20,
            ),
            CarStatusCard(),
            SizedBox(
              height: 20,
            ),
            AvailableCar(
              onButtonPressed: () {},
            )
          ],
        ),
      ),
    )));
  }
}
