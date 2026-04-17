import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class BoletinInformativo extends StatefulWidget {
  const BoletinInformativo({super.key});

  @override
  State<BoletinInformativo> createState() => _BoletinInformativoState();
}

class _BoletinInformativoState extends State<BoletinInformativo> {
  final TextEditingController _correoController = TextEditingController();

  @override
  void dispose() {
    _correoController.dispose();
    super.dispose();
  }

  void _suscribirse() {
    final correo = _correoController.text.trim();

    if (correo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ingrese un correo electrónico')),
      );
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Suscripción enviada: $correo')));

    _correoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final bool esMovil = SistemaConstantes.esMovil(width);

    return Container(
      width: double.infinity,
      color: SistemaConstantes.colorFondoSuave,
      padding: EdgeInsets.symmetric(
        horizontal: SistemaConstantes.paddingHorizontal(width),
        vertical: SistemaConstantes.espacioXL,
      ),

      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: SistemaConstantes.anchoBoletin(width),
          ),

          child: Container(
            padding: const EdgeInsets.all(SistemaConstantes.espacioMD),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(SistemaConstantes.radioLG),
              boxShadow: SistemaConstantes.sombraSuave,
            ),

            child: esMovil
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _info(),
                      const SizedBox(height: SistemaConstantes.espacioLG),
                      _formulario(esMovil),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(flex: 4, child: _info()),

                      const SizedBox(width: SistemaConstantes.espacioXL),

                      Expanded(flex: 5, child: _formulario(esMovil)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _info() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            color: SistemaConstantes.colorAzulPrimario,
            borderRadius: BorderRadius.circular(SistemaConstantes.radioMD),
          ),
          child: const Icon(
            Icons.email_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),

        const SizedBox(width: SistemaConstantes.espacioMD),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Suscríbete y recibe ofertas exclusivas',
                style: SistemaConstantes.tituloGrande,
              ),

              SizedBox(height: SistemaConstantes.espacioSM),

              Text(
                'Sé el primero en enterarte de nuevos productos, promociones y descuentos especiales.',
                style: SistemaConstantes.subtitulo,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _formulario(bool esMovil) {
    return Container(
      height: esMovil ? null : 64,
      padding: const EdgeInsets.all(SistemaConstantes.espacioXS),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SistemaConstantes.radioXL),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: SistemaConstantes.sombraSuave,
      ),

      child: esMovil
          ? Column(
              children: [
                TextField(
                  controller: _correoController,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa tu correo electrónico',
                    border: InputBorder.none,
                    contentPadding: SistemaConstantes.paddingInput,
                  ),
                ),

                const SizedBox(height: SistemaConstantes.espacioSM),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _suscribirse,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SistemaConstantes.colorAzulPrimario,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SistemaConstantes.radioXL,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Enviar',
                      style: SistemaConstantes.textoBoton,
                    ),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _correoController,
                    decoration: const InputDecoration(
                      hintText: 'Ingresa tu correo electrónico',
                      border: InputBorder.none,
                      contentPadding: SistemaConstantes.paddingInput,
                    ),
                  ),
                ),

                const SizedBox(width: SistemaConstantes.espacioSM),

                SizedBox(
                  width: 170,
                  height: double.infinity,
                  child: ElevatedButton(
                    onPressed: _suscribirse,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SistemaConstantes.colorAzulPrimario,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SistemaConstantes.radioXL,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Enviar',
                      style: SistemaConstantes.textoBoton,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
