import 'package:flutter/material.dart';

class IconosCategoriaHelper {
  static final Map<String, IconData> mapa = {
    'home': Icons.home,
    'speaker': Icons.speaker,
    'extension': Icons.extension,
    'directions_car': Icons.directions_car,
    'wb_sunny': Icons.wb_sunny,
    'build': Icons.build,
    'bolt': Icons.bolt,
    'memory': Icons.memory,
    'shopping_bag': Icons.shopping_bag,
    'sports_esports': Icons.sports_esports,
    'pets': Icons.pets,
    'celebration': Icons.celebration,
    'cleaning_services': Icons.cleaning_services,
    'kitchen': Icons.kitchen,
    'local_shipping': Icons.local_shipping,

    /// NUEVOS
    'chair_alt': Icons.chair_alt,
    'business_center': Icons.business_center,
    'security': Icons.security,
    'devices': Icons.devices,
    'videocam': Icons.videocam,
    'notifications_active': Icons.notifications_active,
  };

  static IconData obtenerIcono(String? nombre) {
    if (nombre == null || nombre.trim().isEmpty) {
      return Icons.category;
    }

    return mapa[nombre.trim().toLowerCase()] ?? Icons.category;
  }
}
