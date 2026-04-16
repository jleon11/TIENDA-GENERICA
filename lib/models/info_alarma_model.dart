
import 'package:tienda_motos/models/informacion_general_model.dart';

class InfoAlarmaModel extends InformacionGeneralModel {
  final String color;
  final String rangoMaximo;
  final String controles;
  final String nivelRuido;
  final String material;
  final String numeroParte;

  InfoAlarmaModel({
    required this.color,
    required this.rangoMaximo,
    required this.controles,
    required this.nivelRuido,
    required this.material,
    required this.numeroParte,
  });

  @override
  Map<String, String> toMap() {
    return {
      'Color': color,
      'Rango máximo': rangoMaximo,
      'Controles': controles,
      'Nivel de ruido': nivelRuido,
      'Material': material,
      '#Parte': numeroParte,
    };
  }
}