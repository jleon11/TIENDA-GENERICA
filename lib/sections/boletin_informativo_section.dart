import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class BoletinInformativo extends StatefulWidget {
  const BoletinInformativo({super.key});

  @override
  State<BoletinInformativo> createState() => _BoletinInformativoState();
}

class _BoletinInformativoState extends State<BoletinInformativo> {
  final TextEditingController _correoController = TextEditingController();
  String? _errorCorreo;

  static final RegExp _regexCorreo = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void dispose() {
    _correoController.dispose();
    super.dispose();
  }

  bool _validarCorreo(String correo) {
    if (correo.isEmpty) {
      setState(() => _errorCorreo = 'El correo electrónico es obligatorio.');
      return false;
    }
    if (!_regexCorreo.hasMatch(correo)) {
      setState(
        () => _errorCorreo =
            'Ingresa un correo electrónico válido (ej: usuario@dominio.com).',
      );
      return false;
    }
    setState(() => _errorCorreo = null);
    return true;
  }

  void _suscribirse() {
    final correo = _correoController.text.trim();
    if (!_validarCorreo(correo)) return;

    _correoController.clear();
    setState(() => _errorCorreo = null);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Cerrar',
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) => _AlertSuscripcion(correo: correo),
      transitionBuilder: (_, anim, __, child) {
        final curved =
            CurvedAnimation(parent: anim, curve: Curves.easeOutBack);
        return ScaleTransition(
          scale: curved,
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
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
        vertical: SistemaConstantes.espacioLG,
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
              borderRadius: BorderRadius.circular(SistemaConstantes.radioSM),
              boxShadow: SistemaConstantes.sombraSuave,
            ),
            child: esMovil
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _info(),
                      const SizedBox(height: SistemaConstantes.espacioSM),
                      _formulario(esMovil),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: esMovil ? null : 64,
          padding: const EdgeInsets.all(SistemaConstantes.espacioXS),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(SistemaConstantes.radioXL),
            border: Border.all(
              color: _errorCorreo != null
                  ? Colors.red.shade400
                  : Colors.grey.shade300,
            ),
            boxShadow: SistemaConstantes.sombraSuave,
          ),
          child: esMovil
              ? Column(
                  children: [
                    TextField(
                      controller: _correoController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (_) {
                        if (_errorCorreo != null)
                          setState(() => _errorCorreo = null);
                      },
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
                          'Suscribirme',
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
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (_) {
                          if (_errorCorreo != null)
                            setState(() => _errorCorreo = null);
                        },
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
                          'Suscribirme',
                          style: SistemaConstantes.textoBoton,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        if (_errorCorreo != null) ...[
          const SizedBox(height: 6),
          Row(
            children: [
              const SizedBox(width: 12),
              Icon(Icons.error_outline, size: 14, color: Colors.red.shade600),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  _errorCorreo!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Alert estilo SweetAlert con animación
// ─────────────────────────────────────────────

class _AlertSuscripcion extends StatefulWidget {
  final String correo;
  const _AlertSuscripcion({required this.correo});

  @override
  State<_AlertSuscripcion> createState() => _AlertSuscripcionState();
}

class _AlertSuscripcionState extends State<_AlertSuscripcion>
    with SingleTickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _circleAnim;
  late Animation<double> _checkAnim;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _circleAnim = CurvedAnimation(
      parent: _checkController,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );

    _checkAnim = CurvedAnimation(
      parent: _checkController,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 150), () {
      if (mounted) _checkController.forward();
    });
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth < 400 ? screenWidth * 0.88 : 320.0;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: dialogWidth,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScaleTransition(
                scale: _circleAnim,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: SistemaConstantes.colorAzulPrimario.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: AnimatedBuilder(
                    animation: _checkAnim,
                    builder: (_, __) => CustomPaint(
                      painter: _CheckPainter(
                        progress: _checkAnim.value,
                        color: SistemaConstantes.colorAzulPrimario,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '¡Suscripción exitosa!',
                style: SistemaConstantes.tituloGrande,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Te has suscrito con ${widget.correo}.\nPronto recibirás nuestras mejores ofertas.',
                style: SistemaConstantes.subtitulo,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
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
                    'Entendido',
                    style: SistemaConstantes.textoBoton,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Painter del checkmark animado
// ─────────────────────────────────────────────

class _CheckPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _CheckPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final cx = size.width / 2;
    final cy = size.height / 2;

    final p1 = Offset(cx - 12, cy);
    final p2 = Offset(cx - 3, cy + 9);
    final p3 = Offset(cx + 13, cy - 10);

    final seg1 = (p2 - p1).distance;
    final seg2 = (p3 - p2).distance;
    final totalLen = seg1 + seg2;
    final drawn = totalLen * progress;

    final path = Path();

    if (drawn <= 0) return;

    if (drawn <= seg1) {
      final t = drawn / seg1;
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(
        p1.dx + (p2.dx - p1.dx) * t,
        p1.dy + (p2.dy - p1.dy) * t,
      );
    } else {
      final t = (drawn - seg1) / seg2;
      path.moveTo(p1.dx, p1.dy);
      path.lineTo(p2.dx, p2.dy);
      path.lineTo(
        p2.dx + (p3.dx - p2.dx) * t,
        p2.dy + (p3.dy - p2.dy) * t,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter old) => old.progress != progress;
}