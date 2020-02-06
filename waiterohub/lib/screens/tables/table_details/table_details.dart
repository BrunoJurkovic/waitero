import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:waitero/components/scaffold/no_nav_scaffold.dart';
import 'package:waitero/components/submit_button/submit_button.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/services/database/tables_repo.dart';

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
                               height: MediaQuery.of(context).size.height * 0.3,
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
                              onPressed: null,
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
