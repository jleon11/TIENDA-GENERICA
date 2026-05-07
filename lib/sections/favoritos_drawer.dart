import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:tienda_motos/constants/constantes_sistema.dart';
import 'package:tienda_motos/providers/carrito_provider.dart';
import 'package:tienda_motos/providers/favoritos_provider.dart';

class FavoritosDrawer extends StatelessWidget {
  const FavoritosDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = context.watch<FavoritosProvider>();

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
                const Icon(Icons.favorite, color: Colors.white),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'Mi lista de deseos',
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
            child: favs.items.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Tu lista de deseos está vacía',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: favs.items.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, i) {
                      final producto = favs.items[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                producto.imagenPrincipal,
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
                                    producto.nombre,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₡ ${producto.precioActual}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color:
                                          SistemaConstantes.colorAzulPrimario,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 22,
                              ),
                              onPressed: () => favs.toggleFavorito(producto),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          /// FOOTER
          if (favs.items.isNotEmpty)
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
                  Text(
                    '${favs.total} producto${favs.total == 1 ? '' : 's'} guardado${favs.total == 1 ? '' : 's'}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _generarPdfFavoritos(context, favs),
                      icon: const FaIcon(
                        FontAwesomeIcons.filePdf,
                        color: Colors.white,
                        size: 18,
                      ),
                      label: const Text(
                        'Descargar lista de deseos',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final carrito = context.read<CarritoProvider>();

                        favs.enviarTodosAlCarrito(carrito);

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      label: const Text(
                        'Enviar todo al carrito',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SistemaConstantes.colorAzulPrimario,
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

  Future<void> _generarPdfFavoritos(
    BuildContext context,
    FavoritosProvider favs,
  ) async {
    final pdf = pw.Document();

    final fontRegular = await PdfGoogleFonts.nunitoRegular();
    final fontBold = await PdfGoogleFonts.nunitoBold();
    final fontItalic = await PdfGoogleFonts.nunitoItalic();

    final ahora = DateTime.now();
    final fecha =
        '${ahora.day.toString().padLeft(2, '0')}/${ahora.month.toString().padLeft(2, '0')}/${ahora.year}';

    final azul = PdfColor.fromHex('#1E478D');
    final gris = PdfColor.fromHex('#6B7280');
    final grisFondo = PdfColor.fromHex('#F9FAFB');
    final rosadoClaro = PdfColor.fromHex('#FDECEA');

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
                    pw.Text(
                      'LISTA DE DESEOS',
                      style: pw.TextStyle(
                        font: fontBold,
                        color: azul,
                        fontSize: 13,
                      ),
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
            'PRODUCTOS QUE ME GUSTAN',
            style: pw.TextStyle(font: fontBold, fontSize: 16, color: azul),
          ),

          pw.SizedBox(height: 4),

          pw.Text(
            'Esta es mi lista de productos favoritos de Accesorios González.',
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
              1: const pw.FixedColumnWidth(220),
              2: const pw.FixedColumnWidth(80),
              3: const pw.FixedColumnWidth(130),
            },
            children: [
              pw.TableRow(
                decoration: pw.BoxDecoration(color: azul),
                children: [
                  celdaHeader('#'),
                  celdaHeader('Producto'),
                  celdaHeader('Código'),
                  celdaHeader('Precio'),
                ],
              ),
              ...favs.items.asMap().entries.map((entry) {
                final idx = entry.key;
                final producto = entry.value;
                final fondo = idx % 2 == 0 ? PdfColors.white : grisFondo;

                return pw.TableRow(
                  decoration: pw.BoxDecoration(color: fondo),
                  children: [
                    celda('${idx + 1}', center: true),
                    celda(producto.nombre),
                    celda(producto.codigo, center: true),
                    celda(
                      '₡${producto.precio.toStringAsFixed(2)}',
                      center: true,
                      bold: true,
                    ),
                  ],
                );
              }),
            ],
          ),

          pw.SizedBox(height: 20),

          /// NOTA FINAL
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: rosadoClaro,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Text(
              'Puedes adquirir estos productos visitando nuestra tienda o contactándonos por WhatsApp al +506 6298-4141.',
              style: pw.TextStyle(font: fontRegular, fontSize: 10, color: gris),
            ),
          ),

          pw.SizedBox(height: 16),

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

          /*
          
          pw.Center(
            child: pw.Text(
              'Generado desde Accesorios González',
              style: pw.TextStyle(font: fontItalic, color: gris, fontSize: 11),
            ),
          ),

          */
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

    /*
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
      name: 'ListaDeseos_$fecha.pdf',
    );*/

    final bytes = await pdf.save();
    await Printing.sharePdf(
      bytes: bytes,
      filename: 'ListaDeseos_$fecha.pdf', // 👈 este sí respeta el nombre
    );
  }
}
