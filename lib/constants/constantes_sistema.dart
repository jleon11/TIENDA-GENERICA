import 'package:flutter/material.dart';

class SistemaConstantes {
  SistemaConstantes._();

  /*Tamaños de pantalla dinamicas y demas caracteristicas*/

  static const double anchoMaximoContenido = 1400;
  static const double anchoMaximoHeader = 1400;

  static const double mobile = 768;
  static const double tablet = 1024;
  static const double desktop = 1400;

  static double anchoBoletin(double width) {
    return (width * 0.96).clamp(320.0, 1800.0);
  }

  static bool esMovil(double width) {
    return width < mobile;
  }

  // ==================================
  // COLORES PRINCIPALES
  // ==================================

  static const Color colorAzulPrimario = Color(0xFF1E478D);
  static const Color colorAzulSecundario = Color(0xFF0E2A5A);

  static const Color colorSecundario = Color(0xFFE53935);

  static const Color colorExito = Color(0xFF43A047);

  static const Color colorTexto = Color(0xFF1E1E1E);

  static const Color colorGris = Color(0xFF757575);

  static const Color colorBorde = Color(0xFFE0E0E0);

  static const Color colorFondo = Colors.white;

  static const Color colorTextoSuave = Color(0xFF6B7280);

  static const Color colorFondoSuave = Color(0xFFF2F5FA);

  //==================================================
  // TEXTO TAMAÑOS
  //==================================================

  static const double textoXS = 11;
  static const double textoSM = 13;
  static const double textoMD = 15;
  static const double textoLG = 18;
  static const double textoXL = 22;
  static const double textoXXL = 26;

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

  static double paddingHorizontal(double width) {
    if (width < mobile) return 16;
    if (width < tablet) return 24;
    return 40;
  }

  /*
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(
    horizontal: 20,
  );*/

  static const EdgeInsets paddingInput = EdgeInsets.symmetric(horizontal: 18);

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

  static List<BoxShadow> sombraSuave = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

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

  static const TextStyle tituloExtraGrande = TextStyle(
    fontSize: textoXXL,
    fontWeight: FontWeight.w800,
    color: colorAzulPrimario,
  );

  static const TextStyle tituloGrande = TextStyle(
    fontSize: textoXL,
    fontWeight: FontWeight.w800,
    color: colorAzulPrimario,
  );

  static const TextStyle subtitulo = TextStyle(
    fontSize: textoMD,
    height: 1.5,
    color: colorTextoSuave,
  );

  static const TextStyle tituloSeccion = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
    color: colorAzulPrimario,
  );

  static const TextStyle textoBoton = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const TextStyle precio = TextStyle(
    color: colorAzulPrimario,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle precioAnterior = TextStyle(
    color: colorGris,
    fontSize: 12,
    decoration: TextDecoration.lineThrough,
  );

  static const Color colorPrimarioSuave = Color(0xFFF2F5FA);

  static const double textoTituloXL = 24;
  static const double textoNormal = 15;

  static const double radioXL = 40;
  static const double altoInputGrande = 58;

  static const TextStyle tituloBoletin = TextStyle(
    fontSize: textoTituloXL,
    fontWeight: FontWeight.w800,
    color: colorAzulPrimario,
  );

  /*CARDS*/

  static const double cardSmallAncho = 240;
  static const double cardSmallAlto = 360;

  /// CARD NORMAL
  static const double cardNormalAncho = 320;
  static const double cardNormalAlto = 470;

  /// CARD HERO
  static const double cardGrandeAncho = 360;
  static const double cardGrandeAlto = 505;
}
