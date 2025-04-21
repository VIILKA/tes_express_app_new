import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/features/news/presentation/components/news_block_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<Map<String, String>> newsData = [
    {
      'imagePath': 'assets/images/lixing_L9.png',
      'description':
          'Сейчас мы едем до вашего пункта назначения,готовьтесь получать',
      'title': 'Новый L9 MAX',
      'date': '12.05.2025'
    },
    {
      'imagePath': 'assets/images/lixing_L9.png',
      'description':
          'Сейчас мы едем до вашего пункта назначения,готовьтесь получать',
      'title': 'Новый L9 MAX',
      'date': '12.05.2025'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Новости',
              style: AppTheme.displayLarge,
            ),
          ),
          SizedBox(
            height: 290.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsData.length,
              itemBuilder: (context, index) {
                final car = newsData[index];
                return Container(
                  width: 230.w, // Ширина карточки
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: NewsBlockCard(
                    imagePath: car['imagePath']!,
                    title: car['title']!,
                    date: car['date']!,
                    description: car['description']!,
                    onButtonPressed: () {
                      print('Перешли на ${car['title']}');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
