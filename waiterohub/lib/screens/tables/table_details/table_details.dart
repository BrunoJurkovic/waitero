import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:waitero/components/scaffold/no_nav_scaffold.dart';
import 'package:waitero/components/submit_button/submit_button.dart';
import 'package:waitero/routing/router.gr.dart';

import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart' as pdfpack;
import 'package:pdf/widgets.dart' as pdfs;

class TableDetails extends StatefulWidget {
  const TableDetails({
    Key key,
    @required this.id,
    @required this.qrCodeURL,
    @required this.isRound,
  }) : super(key: key);

  final String id;
  final bool isRound;
  final String qrCodeURL;

  @override
  _TableDetailsState createState() => _TableDetailsState();
}

class _TableDetailsState extends State<TableDetails> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  pdfs.PageTheme myPageTheme(pdfpack.PdfPageFormat format) {
    const pdfpack.PdfColor green = pdfpack.PdfColor.fromInt(0xff9ce5d0);
    const pdfpack.PdfColor lightGreen = pdfpack.PdfColor.fromInt(0xffcdf1e7);
    return pdfs.PageTheme(
      pageFormat: format.applyMargin(
          left: 2.0 * pdfpack.PdfPageFormat.cm,
          top: 4.0 * pdfpack.PdfPageFormat.cm,
          right: 2.0 * pdfpack.PdfPageFormat.cm,
          bottom: 2.0 * pdfpack.PdfPageFormat.cm),
      buildBackground: (pdfs.Context context) {
        return pdfs.FullPage(
          ignoreMargins: true,
          child: pdfs.CustomPaint(
            size: pdfpack.PdfPoint(format.width, format.height),
            painter: (pdfpack.PdfGraphics canvas, pdfpack.PdfPoint size) {
              context.canvas
                ..setColor(lightGreen)
                ..moveTo(0, size.y)
                ..lineTo(0, size.y - 230)
                ..lineTo(60, size.y)
                ..fillPath()
                ..setColor(green)
                ..moveTo(0, size.y)
                ..lineTo(0, size.y - 100)
                ..lineTo(100, size.y)
                ..fillPath()
                ..setColor(lightGreen)
                ..moveTo(30, size.y)
                ..lineTo(110, size.y - 50)
                ..lineTo(150, size.y)
                ..fillPath()
                ..moveTo(size.x, 0)
                ..lineTo(size.x, 230)
                ..lineTo(size.x - 60, 0)
                ..fillPath()
                ..setColor(green)
                ..moveTo(size.x, 0)
                ..lineTo(size.x, 100)
                ..lineTo(size.x - 100, 0)
                ..fillPath()
                ..setColor(lightGreen)
                ..moveTo(size.x - 30, 0)
                ..lineTo(size.x - 110, 50)
                ..lineTo(size.x - 150, 0)
                ..fillPath();
            },
          ),
        );
      },
    );
  }

  Future<List<int>> writePdf(pdfpack.PdfPageFormat format) async {
    final ByteData font =
        await rootBundle.load('assets/fonts/Diodrum-Semibold.ttf');
    final pdfs.Font ttf = pdfs.Font.ttf(font);
    final pdfs.PageTheme pageTheme = myPageTheme(format);
    final pdfs.Document pdf = pdfs.Document();
    pdf.addPage(
      pdfs.Page(
        pageTheme: pageTheme,
        build: (pdfs.Context context) {
          return pdfs.Center(
            child: pdfs.Container(
              child: pdfs.Column(
                children: <pdfs.Widget>[
                  pdfs.QrCodeWidget(
                    data:
                        'https://waitero.firebaseapp.com/?tableID=${widget.id}#',
                    version: 3,
                    size: 200,
                  ),
                  pdfs.SizedBox(height: 25),
                  pdfs.Text(
                    'Welcome!',
                    textAlign: pdfs.TextAlign.center,
                    style: pdfs.TextStyle(
                        fontSize: 50,
                        fontWeight: pdfs.FontWeight.bold,
                        font: ttf),
                  ),
                  pdfs.SizedBox(height: 15),
                  pdfs.Text(
                    'Scan this QR code',
                    textAlign: pdfs.TextAlign.center,
                    style: pdfs.TextStyle(
                        fontSize: 30,
                        font: ttf),
                  ),
                  pdfs.SizedBox(height: 15),
                  pdfs.Text(
                    'to make an order!',
                    textAlign: pdfs.TextAlign.center,
                    style: pdfs.TextStyle(
                        fontSize: 30,
                        font: ttf),
                  ),
                  pdfs.SizedBox(height: 5),
                  pdfs.Text(
                    'Powered by Waitero <3',
                    textAlign: pdfs.TextAlign.center,
                    style: pdfs.TextStyle(
                        fontSize: 8,
                        font: ttf),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return NoNavScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Container(
            height: 50,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 32,
                  onPressed: () {
                    Router.navigator.pop();
                  },
                ),
                const SizedBox(width: 8),
                Text(
                  'Manage "${widget.id.trim()}"',
                  style: const TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 64.0),
                      child: FormBuilder(
                        key: _fbKey,
                        initialValue: <String, dynamic>{
                          'id': 'TBL-${widget.id}',
                          'isRound':
                              widget.isRound ? 'Circular' : 'Rectangular',
                        },
                        autovalidate: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FormBuilderTextField(
                              attribute: 'id',
                              enabled: false,
                              readOnly: true,
                              style: const TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'Diodrum',
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                  labelText: 'ID',
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                            ),
                            FormBuilderDropdown(
                              attribute: 'isRound',
                              decoration: const InputDecoration(
                                labelText: 'Table Shape',
                                labelStyle: TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'Diodrum',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: 'Diodrum',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              items: <String>['Circular', 'Rectangular']
                                  .map(
                                    (String type) => DropdownMenuItem<String>(
                                      child: Text(
                                        '$type',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          fontFamily: 'Diodrum',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      value: type,
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: const Image(
                                  image: AssetImage('assets/images/rest.png'),
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SubmitButton(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  text: 'Submit Tables',
                                  gradient: const LinearGradient(
                                    colors: <Color>[
                                      Color(0xFFEF7198),
                                      Color(0xFFF296B7),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      Router.navigator
                                          .pop(_fbKey.currentState.value);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          QrImage(
                            data:
                                'https://waitero.firebaseapp.com/?tableID=${widget.id}#',
                            version: QrVersions.auto,
                            size: 300,
                          ),
                          Container(
                            child: const Text(
                              'Print QR Code',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Diodrum',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SubmitButton(
                              width: MediaQuery.of(context).size.width * 0.35,
                              height: MediaQuery.of(context).size.height * 0.08,
                              text: 'Print',
                              onPressed: () async {
                                await Printing.layoutPdf(
                                  onLayout: (pdfpack.PdfPageFormat format) =>
                                      writePdf(format),
                                );
                              },
                              gradient: const LinearGradient(colors: <Color>[
                                Color(0xFF5EC999),
                                Color(0xFF7EDDB9),
                              ]),
                            ),
                          ),
                        ],
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
