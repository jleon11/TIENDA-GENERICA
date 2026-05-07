import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MigaDePan extends StatelessWidget {
  final List<MigaDePanItem> items;

  const MigaDePan({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final esUltimo = i == items.length - 1;

      if (esUltimo) {
        // Último item: nombre del producto, truncado
        widgets.add(
          Flexible(
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      } else {
        // Items intermedios: texto + separador en un solo widget
        widgets.add(
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: item.ruta != null
                  ? () => GoRouter.of(context).go(item.ruta!)
                  : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF1E478D),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, size: 14, color: Colors.grey),
                ],
              ),
            ),
          ),
        );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widgets,
    );
  }
}

class MigaDePanItem {
  final String label;
  final String? ruta;

  const MigaDePanItem({required this.label, this.ruta});
}
