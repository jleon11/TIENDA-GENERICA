import 'package:flutter/material.dart';

class InfoGeneralProductoWidget extends StatelessWidget {
  final String descripcion;
  final Map<String, String> infoGeneral;

  const InfoGeneralProductoWidget({
    super.key,
    required this.descripcion,
    required this.infoGeneral,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información del producto',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E478D),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            descripcion,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 28),
          const Divider(),
          const SizedBox(height: 18),

          if (infoGeneral.isEmpty)
            const Text(
              'No hay información adicional disponible.',
              style: TextStyle(fontSize: 15, color: Color(0xFF6B7280)),
            )
          else
            ...infoGeneral.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        e.key,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        e.value,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
