import 'package:tienda_motos/models/informacion_general_model.dart';

class BateriaModel extends InformacionGeneralModel {
  final String marca;
  final String linea;
  final String anclaje;
  final String dimensiones;
  final String capacidad;
  final String cca;
  final String postes;
  final String positivo;
  final String numeroParte;

  BateriaModel({
    required this.marca,
    required this.linea,
    required this.anclaje,
    required this.dimensiones,
    required this.capacidad,
    required this.cca,
    required this.postes,
    required this.positivo,
    required this.numeroParte,
  });

  @override
  Map<String, String> toMap() {
    return {
      'Línea': linea,
      'Anclaje': anclaje,
      'Dimensiones': dimensiones,
      'Capacidad': capacidad,
      'CCA': cca,
      'Postes': postes,
      'Positivo': positivo,
      '#Parte': numeroParte,
    };
  }
}
