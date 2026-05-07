import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CarritoDrawer extends StatelessWidget {
  const CarritoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = context.watch<CarritoProvider>();

    return Container(
      width: 400,
      color: Colors.white,
      child: Column(
        children: [
          /// HEADER
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            color: SistemaConstantes.colorAzulPrimario,
            child: Row(
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Carrito de compras',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),

          /// LISTA
          Expanded(
            child: carrito.items.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Tu carrito está vacío',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: carrito.items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, i) {
                      final item = carrito.items[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.producto.imagenPrincipal,
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.producto.nombre,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₡ ${item.producto.precioActual}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          SistemaConstantes.colorAzulPrimario,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove,
                                          size: 18,
                                        ),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () => carrito.decrementar(
                                          item.producto.id,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          '${item.cantidad}',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.add, size: 18),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () =>
                                            carrito.agregar(item.producto),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 22,
                              ),
                              onPressed: () =>
                                  carrito.eliminar(item.producto.id),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          /// FOOTER
          /// FOOTER
          if (carrito.items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '₡ ${carrito.totalPrecio.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: SistemaConstantes.colorAzulPrimario,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// BOTÓN SECUNDARIO - PROFORMA
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _generarProforma(context, carrito),
                      icon: FaIcon(
                        FontAwesomeIcons.filePdf,
                        color: SistemaConstantes.colorAzulPrimario,
                        size: 18,
                      ),

                      label: const Text(
                        'Descargar Proforma',
                        style: TextStyle(
                          color: SistemaConstantes.colorAzulPrimario,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: SistemaConstantes.colorAzulPrimario,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// BOTÓN PRINCIPAL - WHATSAPP
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _enviarWhatsapp(carrito),
                      icon: const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                        size: 20,
                      ),

                      label: const Text(
                        'Finalizar por WhatsApp',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF25D366),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _enviarWhatsapp(CarritoProvider carrito) async {
    final buffer = StringBuffer();
    buffer.writeln('Hola, me interesa realizar el siguiente pedido:');
    buffer.writeln('');

    for (final item in carrito.items) {
      buffer.writeln('• ${item.producto.nombre}');
      buffer.writeln('  Código: ${item.producto.codigo}');
      buffer.writeln('  Cantidad: ${item.cantidad}');
      buffer.writeln('');
    }

    buffer.writeln('Quedo atento a su confirmación y disponibilidad.');

    final uri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '/50662984141',
      queryParameters: {'text': buffer.toString()},
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _generarProforma(
    BuildContext context,
    CarritoProvider carrito,
  ) async {
    final pdf = pw.Document();

    // 👇 CARGAR FUENTE NUNITO QUE SOPORTA ₡
    final fontRegular = await PdfGoogleFonts.nunitoRegular();
    final fontBold = await PdfGoogleFonts.nunitoBold();
    final fontItalic = await PdfGoogleFonts.nunitoItalic();

    final ahora = DateTime.now();
    final fecha =
        '${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}';
    final numeroProforma =
        'PF-${ahora.millisecondsSinceEpoch.toString().substring(7)}';

    final azul = PdfColor.fromHex('#1E478D');
    final azulClaro = PdfColor.fromHex('#EBF0FA');
    final rojo = PdfColor.fromHex('#E51F2B');
    final gris = PdfColor.fromHex('#6B7280');
    final grisFondo = PdfColor.fromHex('#F9FAFB');

    // ── Funciones locales con fuente ──────────────────────────────
    pw.Widget celdaHeader(String texto) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        child: pw.Text(
          texto,
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            font: fontBold,
            color: PdfColors.white,
            fontSize: 10,
          ),
        ),
      );
    }

    pw.Widget celda(String texto, {bool center = false, bool bold = false}) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 7),
        child: pw.Text(
          texto,
          textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
          style: pw.TextStyle(
            font: bold ? fontBold : fontRegular,
            fontSize: 10,
            color: PdfColors.black,
          ),
        ),
      );
    }

    pw.Widget obs(String texto) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '• ',
              style: pw.TextStyle(font: fontBold, fontSize: 10, color: azul),
            ),
            pw.Expanded(
              child: pw.Text(
                texto,
                style: pw.TextStyle(font: fontRegular, fontSize: 10),
              ),
            ),
          ],
        ),
      );
    }

    pw.Widget filaTotal(
      String label,
      String valor, {
      required PdfColor grisColor,
      PdfColor? colorValor,
    }) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 3, horizontal: 4),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              label,
              style: pw.TextStyle(
                font: fontRegular,
                fontSize: 11,
                color: grisColor,
              ),
            ),
            pw.Text(
              valor,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 11,
                color: colorValor ?? PdfColors.black,
              ),
            ),
          ],
        ),
      );
    }

    // ─────────────────────────────────────────────────────────────
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,

        margin: const pw.EdgeInsets.all(32),

        build: (pw.Context ctx) => [
          /// HEADER
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,

                children: [
                  pw.Text(
                    'ACCESORIOS GONZÁLEZ',

                    style: pw.TextStyle(
                      font: fontBold,
                      fontSize: 22,
                      color: azul,
                    ),
                  ),

                  pw.Text(
                    'Tu tienda confiable en accesorios y repuestos',

                    style: pw.TextStyle(
                      font: fontRegular,
                      fontSize: 10,
                      color: gris,
                    ),
                  ),
                ],
              ),

              pw.Container(
                padding: const pw.EdgeInsets.all(12),

                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: azul),

                  borderRadius: pw.BorderRadius.circular(8),
                ),

                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,

                  children: [
                    pw.Row(
                      children: [
                        pw.Text(
                          'PROFORMA  ',

                          style: pw.TextStyle(
                            font: fontBold,
                            color: azul,
                            fontSize: 13,
                          ),
                        ),

                        pw.Text(
                          numeroProforma,

                          style: pw.TextStyle(font: fontBold, fontSize: 13),
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 4),

                    pw.Text(
                      'Fecha: $fecha',

                      style: pw.TextStyle(
                        font: fontRegular,
                        fontSize: 11,
                        color: gris,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 20),

          pw.Divider(color: azul, thickness: 2),

          pw.SizedBox(height: 16),

          pw.Text(
            'FACTURA PROFORMA',

            style: pw.TextStyle(font: fontBold, fontSize: 16, color: azul),
          ),

          pw.SizedBox(height: 4),

          pw.Text(
            'Gracias por su preferencia. A continuación el detalle de su cotización.',

            style: pw.TextStyle(font: fontRegular, fontSize: 10, color: gris),
          ),

          pw.SizedBox(height: 16),

          /// TABLA
          pw.Table(
            border: pw.TableBorder.all(
              color: PdfColor.fromHex('#E5E7EB'),
              width: 0.5,
            ),

            columnWidths: {
              0: const pw.FixedColumnWidth(30),
              1: const pw.FixedColumnWidth(200),
              2: const pw.FixedColumnWidth(60),
              3: const pw.FixedColumnWidth(40),
              4: const pw.FixedColumnWidth(80),
              5: const pw.FixedColumnWidth(80),
            },

            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: azul),

                children: [
                  celdaHeader('#'),
                  celdaHeader('Producto'),
                  celdaHeader('Código'),
                  celdaHeader('Cant.'),
                  celdaHeader('Precio Unit.'),
                  celdaHeader('Subtotal'),
                ],
              ),

              ...carrito.items.asMap().entries.map((entry) {
                final idx = entry.key;
                final item = entry.value;

                final subtotal = item.producto.precio * item.cantidad;

                final fondo = idx % 2 == 0 ? PdfColors.white : grisFondo;

                return pw.TableRow(
                  decoration: pw.BoxDecoration(color: fondo),

                  children: [
                    celda('${idx + 1}', center: true),

                    celda(item.producto.nombre),

                    celda(item.producto.codigo, center: true),

                    celda('${item.cantidad}', center: true),

                    celda(
                      '₡${item.producto.precio.toStringAsFixed(2)}',
                      center: true,
                    ),

                    celda(
                      '₡${subtotal.toStringAsFixed(2)}',
                      center: true,
                      bold: true,
                    ),
                  ],
                );
              }),
            ],
          ),

          pw.SizedBox(height: 20),

          /// OBSERVACIONES + TOTALES
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,

            children: [
              pw.Expanded(
                flex: 5,

                child: pw.Container(
                  padding: const pw.EdgeInsets.all(12),

                  decoration: pw.BoxDecoration(
                    color: azulClaro,

                    borderRadius: pw.BorderRadius.circular(8),
                  ),

                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,

                    children: [
                      pw.Text(
                        'OBSERVACIONES',

                        style: pw.TextStyle(
                          font: fontBold,
                          color: azul,
                          fontSize: 11,
                        ),
                      ),

                      pw.SizedBox(height: 8),

                      obs('Precios sujetos a cambio sin previo aviso.'),

                      obs('Esta proforma no tiene validez fiscal.'),

                      obs('Cotización válida por 3 días.'),

                      obs('No incluye costos de envío.'),
                    ],
                  ),
                ),
              ),

              pw.SizedBox(width: 16),

              pw.Expanded(
                flex: 4,

                child: pw.Column(
                  children: [
                    filaTotal(
                      'Subtotal',
                      '₡${carrito.totalPrecio.toStringAsFixed(2)}',

                      grisColor: gris,
                    ),

                    filaTotal(
                      'Descuento',
                      '- ₡0.00',

                      grisColor: gris,
                      colorValor: rojo,
                    ),

                    pw.SizedBox(height: 4),

                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),

                      decoration: pw.BoxDecoration(
                        color: azul,

                        borderRadius: pw.BorderRadius.circular(6),
                      ),

                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,

                        children: [
                          pw.Text(
                            'TOTAL',

                            style: pw.TextStyle(
                              font: fontBold,
                              color: PdfColors.white,
                              fontSize: 13,
                            ),
                          ),

                          pw.Text(
                            '₡${carrito.totalPrecio.toStringAsFixed(2)}',

                            style: pw.TextStyle(
                              font: fontBold,
                              color: PdfColors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 16),

          /*
          pw.Center(
            child: pw.Text(
              'Gracias por su preferencia',
              style: pw.TextStyle(font: fontItalic, color: gris, fontSize: 11),
            ),
          ),

          pw.SizedBox(height: 4),*/
          pw.Center(
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Generado desde: ',
                  style: pw.TextStyle(
                    font: fontItalic,
                    color: gris,
                    fontSize: 11,
                  ),
                ),
                pw.UrlLink(
                  destination: 'https://mundohonda.cr/',
                  child: pw.Text(
                    'https://mundohonda.cr/',
                    style: pw.TextStyle(
                      font: fontItalic,
                      color: azul,
                      fontSize: 11,
                      decoration: pw.TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// FOOTER
          pw.Divider(color: PdfColor.fromHex('#E5E7EB')),

          pw.SizedBox(height: 8),

          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,

            children: [
              pw.Text(
                '+506 6298-4141',

                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 10,
                  color: gris,
                ),
              ),

              pw.Text(
                'ventas@accesorios.com',

                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 10,
                  color: gris,
                ),
              ),

              pw.Text(
                'Limón, Costa Rica',

                style: pw.TextStyle(
                  font: fontRegular,
                  fontSize: 10,
                  color: gris,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final bytes = await pdf.save();
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'Proforma_$numeroProforma.pdf',
    );
  }
}
