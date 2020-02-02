import 'package:flutter/material.dart';
import 'package:waitero/components/scaffold/no_nav_scaffold.dart';
import 'package:waitero/routing/router.gr.dart';

class TableDetails extends StatelessWidget {
  const TableDetails({
    Key key,
    @required this.id,
    @required this.qrCodeURL,
  }) : super(key: key);

  final String id;
  final String qrCodeURL;

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
                  'Manage "${id.trim()}"',
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 100,
                            child: TextFormField(
                              readOnly: true,
                              enabled: false,
                              initialValue: id,
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontFamily: 'Diodrum',
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Table ID',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          if (qrCodeURL != null) ...<Widget>[
                            Container(
                              child: Image(image: NetworkImage(qrCodeURL)),
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
