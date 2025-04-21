import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/features/home/presentation/components/available_car.dart';
import 'package:tes_express_app_new/core/widgets/circular_avatar.dart';
import 'package:tes_express_app_new/features/home/presentation/components/background_with_blinking_dot.dart';
import 'package:tes_express_app_new/features/home/presentation/components/car_card_widget.dart';
import 'package:tes_express_app_new/features/home/presentation/components/car_selection_card.dart';
import 'package:tes_express_app_new/features/home/presentation/components/car_status_card_widget.dart';
import 'package:tes_express_app_new/features/home/presentation/components/news_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  final List<Map<String, String>> carData = [
    {
      'imagePath': 'assets/images/two_L7.jpeg',
      'title': 'Lixiang L7 Pro',
      'price': 'От 5.6 млн рублей',
    },
    {
      'imagePath': 'assets/images/xiaomi_SU7_ultra.png',
      'title': 'Xiaomi SU7 Ultra',
      'price': 'От 6.2 млн рублей',
    }
  ];

  final List<Map<String, String>> newsData = [
    {
      'imagePath': 'assets/images/two_L7.jpeg',
      'title': 'Новые машины в МСК\n oт Zeekr 001 до Tesla Model S',
    },
    {
      'imagePath': 'assets/images/xiaomi_SU7_ultra.png',
      'title': 'Новая К5 2025 года:\nВедро без колес',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final itemWidth = 300.0; // Ширина одного элемента, включая отступы
    final newIndex = (offset / itemWidth).round();
    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Машины в наличии',
                        style: AppTheme.displayLarge,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                  Text(
                    'Сейчас мы едем до вашего пункта назначения,\nготовьтесь получать',
                    style:
                        AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 340,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: carData.length,
                      itemBuilder: (context, index) {
                        final car = carData[index];
                        return Container(
                          width: 280, // Ширина карточки
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: CarCardWidget(
                            imagePath: car['imagePath']!,
                            title: car['title']!,
                            price: car['price']!,
                            onButtonPressed: () {
                              print('Перешли на ${car['title']}');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      carData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentIndex == index ? 12.0 : 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.black
                              : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Статистика',
                        style: AppTheme.displayLarge,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                  Text(
                    'Сейчас мы едем до вашего пункта назначения,\nготовьтесь получать',
                    style:
                        AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BackgroundWithBlinkingDot(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CarSelectionCard(
              title: 'Подобрать машину',
              subtitle:
                  'Сейчас мы едем до вашего пункта назначения,\nготовьтесь получать',
              imagePath:
                  'assets/images/Frame48096169.png', // Замените на путь к вашему изображению
              onButtonPressed: () {
                print('Нажата кнопка "Подобрать"');
              },
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Статистика',
                        style: AppTheme.displayLarge,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                  Text(
                    'Сейчас мы едем до вашего пункта назначения,\nготовьтесь получать',
                    style:
                        AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: newsData.length,
                      itemBuilder: (context, index) {
                        final car = newsData[index];
                        return Container(
                          width: 280, // Ширина карточки
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: NewsCard(
                            imagePath: car['imagePath']!,
                            title: car['title']!,
                            onButtonPressed: () {
                              print('Перешли на ${car['title']}');
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
