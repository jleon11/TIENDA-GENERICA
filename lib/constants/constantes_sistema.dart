import 'package:flutter/material.dart';

class SistemaConstantes {
  SistemaConstantes._();

  // ==================================
  // COLORES PRINCIPALES
  // ==================================

  static const Color colorPrimario = Color(0xFF1E478D);

  static const Color colorSecundario = Color(0xFFE53935);

  static const Color colorExito = Color(0xFF43A047);

  static const Color colorTexto = Color(0xFF1E1E1E);

  static const Color colorGris = Color(0xFF757575);

  static const Color colorBorde = Color(0xFFE0E0E0);

  static const Color colorFondo = Colors.white;

  // ==================================
  // ANCHOS GENERALES
  // ==================================

  static const double anchoMaximoContenido = 1200;

  static const double anchoMaximoHeader = 1400;

  // ==================================
  // ALTURAS
  // ==================================

  static const double altoHeader = 80;

  static const double altoBoton = 42;

  // ==================================
  // ESPACIADOS
  // ==================================

  static const double espacioXS = 6;
  static const double espacioSM = 10;
  static const double espacioMD = 20;
  static const double espacioLG = 40;
  static const double espacioXL = 80;

  static const double espacioSeccion = 40;

  // ==================================
  // PADDINGS
  // ==================================

  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: 20,
  );

  static const EdgeInsets paddingCard = EdgeInsets.all(12);

  static const EdgeInsets paddingSeccion = EdgeInsets.symmetric(vertical: 10);

  // ==================================
  // BORDES
  // ==================================

  static const double radioSM = 8;
  static const double radioMD = 12;
  static const double radioLG = 24;

  // ==================================
  // SOMBRAS
  // ==================================

  static const double cardSmallAncho = 220;
  static const double cardSmallAlto = 380;

  /// CARD NORMAL
  static const double cardNormalAncho = 260;
  static const double cardNormalAlto = 430;

  /// CARD HERO
  static const double cardGrandeAncho = 300;
  static const double cardGrandeAlto = 500;

  static List<BoxShadow> sombraCard = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> sombraHover = [
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  // ==================================
  // TEXTOS
  // ==================================

  static const TextStyle tituloSeccion = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
    color: colorPrimario,
  );

  static const TextStyle textoBoton = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle precio = TextStyle(
    color: colorPrimario,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle precioAnterior = TextStyle(
    color: colorGris,
    fontSize: 12,
    decoration: TextDecoration.lineThrough,
  );
}
