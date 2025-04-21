import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // если нужен адаптивный размер
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class MapWithMarker extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapWithMarker({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  _MapWithMarkerState createState() => _MapWithMarkerState();
}

class _MapWithMarkerState extends State<MapWithMarker> {
  String? locationName;

  @override
  void initState() {
    super.initState();
    _fetchLocationName();
  }

  Future<void> _fetchLocationName() async {
    final lat = widget.latitude;
    final lon = widget.longitude;
    // Формируем URL для обратного геокодирования с указанием языка (ru)
    final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=$lat&lon=$lon&accept-language=ru");

    try {
      // Указываем User-Agent для корректной работы Nominatim
      final response = await http.get(url, headers: {
        "User-Agent":
            "com.example.myapp/1.0", // Замените на идентификатор вашего приложения
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data["address"] as Map<String, dynamic>?;
        final shortName = address?["city"] ??
            address?["town"] ??
            address?["village"] ??
            address?["hamlet"];
        setState(() {
          locationName = shortName ?? "Неизвестное место";
        });
      } else {
        setState(() {
          locationName = "Неизвестное место";
        });
      }
    } catch (e) {
      setState(() {
        locationName = "Ошибка получения данных";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Создаем объект LatLng на основе переданных координат
    final LatLng location = LatLng(widget.latitude, widget.longitude);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),

      width: double.infinity,
      height: 360
          .h, // если используете flutter_screenutil, иначе можно указать фиксированное значение
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: location,
            initialZoom: 8.0,
          ),
          children: [
            // Слой тайлов с использованием cyclOSM (можно заменить на другой, если потребуется)
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.myapp',
              // Замените на идентификатор вашего приложения
            ),
            // Слой с маркером
            MarkerLayer(
              markers: [
                Marker(
                  point: location,
                  width: 100.w,
                  height: 100.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: AppTheme.greyText),
                        child: Container(
                          width: 10.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppTheme.orange),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.main,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          locationName ?? 'Загрузка...',
                          textAlign: TextAlign.center,
                          style: AppTheme.buttonText
                              .copyWith(color: AppTheme.whiteGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
