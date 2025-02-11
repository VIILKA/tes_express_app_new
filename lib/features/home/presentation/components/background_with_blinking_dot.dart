import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/core/widgets/blue_button.dart';

class BackgroundWithBlinkingDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Color(0xFF0F0F0F),
        borderRadius: BorderRadius.circular(16.0),
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/map_black.png'), // Путь к вашему изображению
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '72',
                    style: AppTheme.displayLarge
                        .copyWith(color: AppTheme.green, height: 0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Машин в пути к клиентам',
                    style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.whiteGrey,
                        height: 0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '12',
                    style: AppTheme.displayLarge
                        .copyWith(color: AppTheme.green, height: 0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Машин выезжают из Хоргоса',
                    style: AppTheme.bodyLarge.copyWith(
                        color: AppTheme.whiteGrey,
                        height: 0,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Spacer(),
              BlueButton(text: 'Просмотреть', onPressed: () {})
            ],
          ),
          // Мигающая точка
          Positioned(
            top: screenHeight * 0.2, // Расположить 20% от высоты экрана
            left: screenWidth * 0.6,
            child: const BlinkingDot(
              size: 55.0,
              color: Color(0xFFDEB236),
            ),
          ),
        ],
      ),
    );
  }
}

class BlinkingDot extends StatefulWidget {
  final double size;
  final Color color;

  const BlinkingDot({
    Key? key,
    this.size = 30.0,
    this.color = Colors.orange,
  }) : super(key: key);

  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Длительность мигания
      vsync: this,
    )..repeat(reverse: true); // Анимация повторяется

    _opacityAnimation =
        Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
