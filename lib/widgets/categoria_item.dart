import 'package:flutter/material.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';

class CategoriaItem extends StatefulWidget {
  final String nombre;
  final IconData icono;
  final bool activa;
  final VoidCallback? onTap;

  const CategoriaItem({
    super.key,
    required this.nombre,
    required this.icono,
    this.activa = false,
    this.onTap,
  });

  @override
  State<CategoriaItem> createState() => _CategoriaItemState();
}

class _CategoriaItemState extends State<CategoriaItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final bool resaltado = widget.activa || hover;

    final width = MediaQuery.of(context).size.width;

    final esMovil = width < SistemaConstantes.mobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        setState(() {
          hover = true;
        });
      },

      onExit: (_) {
        setState(() {
          hover = false;
        });
      },

      child: GestureDetector(
        onTap: widget.onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),

          width: esMovil ? 92 : 125,

          padding: EdgeInsets.symmetric(
            horizontal: esMovil ? 4 : 10,
            vertical: esMovil ? 4 : 8,
          ),

          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),

                width: esMovil ? 68 : 90,
                height: esMovil ? 68 : 90,

                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  color: resaltado ? const Color(0xFF1E478D) : Colors.white,

                  border: Border.all(
                    color: const Color(0xFF1E478D),
                    width: esMovil ? 2.2 : 3,
                  ),

                  boxShadow: resaltado
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.10),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ]
                      : [],
                ),

                child: Icon(
                  widget.icono,

                  size: esMovil ? 28 : 38,

                  color: resaltado ? Colors.white : const Color(0xFF1E478D),
                ),
              ),

              SizedBox(height: esMovil ? 7 : 12),

              Text(
                widget.nombre,

                textAlign: TextAlign.center,

                maxLines: 2,

                overflow: TextOverflow.ellipsis,

                style: TextStyle(
                  fontSize: esMovil ? 12 : 14,

                  height: 1.2,

                  fontWeight: FontWeight.w700,

                  color: resaltado ? const Color(0xFF1E478D) : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
