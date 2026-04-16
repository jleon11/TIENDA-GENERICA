import 'package:tienda_motos/models/informacion_general_model.dart';


class InfoAceiteModel extends InformacionGeneralModel {
  final String cantidad;
  final String grado;
  final String tipoContenedor;
  final String tipoAceiteMotor;
  final String tipoVehiculo;
  final String numeroParte;

  InfoAceiteModel({
    required this.cantidad,
    required this.grado,
    required this.tipoContenedor,
    required this.tipoAceiteMotor,
    required this.tipoVehiculo,
    required this.numeroParte,
  });

  @override
  Map<String, String> toMap() {
    return {
      'Cantidad': cantidad,
      'Grado': grado,
      'Tipo de contenedor': tipoContenedor,
      'Tipo de aceite de motor': tipoAceiteMotor,
      'Tipo de vehículo': tipoVehiculo,
      '#Parte': numeroParte,
    };
  }
}