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

      widgets.add(
        esUltimo
            ? Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              )
            : MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: item.ruta != null
                      ? () => GoRouter.of(context).go(item.ruta!)
                      : null,
                  child: Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF1E478D),
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
      );

      if (!esUltimo) {
        widgets.add(
          const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        );
      }
    }

    return Wrap(
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: widgets,
    );
  }
}

class MigaDePanItem {
  final String label;
  final String? ruta;

  const MigaDePanItem({required this.label, this.ruta});
}
