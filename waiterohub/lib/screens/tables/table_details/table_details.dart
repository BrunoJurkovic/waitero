import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:waitero/components/scaffold/no_nav_scaffold.dart';
import 'package:waitero/routing/router.gr.dart';

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
                          'id': widget.id,
                          'isRound':
                              widget.isRound ? 'Circular' : 'Rectangular',
                        },
                        autovalidate: true,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                              decoration:
                                  const InputDecoration(labelText: 'ID'),
                            ),
                            FormBuilderDropdown(
                              attribute: 'isRound',
                              decoration:
                                  const InputDecoration(labelText: 'Table Shape'),
                              validators: <String Function(dynamic)>[
                                FormBuilderValidators.required()
                              ],
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
                                          ))
                                  .toList(),
                            ),
                            // Container(
                            //   height: 100,
                            //   child: TextFormField(
                            //     readOnly: true,
                            //     enabled: false,
                            //     initialValue: id,
                            //     style: const TextStyle(
                            //       fontSize: 30.0,
                            //       fontFamily: 'Diodrum',
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //     decoration: const InputDecoration(
                            //       labelText: 'Table ID',
                            //       border: OutlineInputBorder(),
                            //     ),
                            //   ),
                            // ),
                            // Container(
                            //   height: 100,
                            //   child: TextFormField(
                            //     enabled: true,
                            //     initialValue: id,
                            //     style: const TextStyle(
                            //       fontSize: 30.0,
                            //       fontFamily: 'Diodrum',
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //     decoration: const InputDecoration(
                            //       labelText: 'Table ID',
                            //       border: OutlineInputBorder(),
                            //     ),
                            //   ),
                            // ),
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
                          if (widget.qrCodeURL != null) ...<Widget>[
                            Container(
                              child:
                                  Image(image: NetworkImage(widget.qrCodeURL)),
                            ),
                            Container(
                              child: const Text(
                                'Please scan this QR code.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Diodrum',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ] else
                            Container(
                              child: const Text(
                                'No QR code found',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Diodrum',
                                  fontWeight: FontWeight.w600,
                                ),
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
