import 'dart:js' as js;

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:waiteroclient/components/analytics_route_observer/analytics_route_observer.dart';
import 'package:waiteroclient/screens/order/order.dart';
import 'package:waiteroclient/services/database/products_repository.dart';

void main() {
  initializeApp(
    apiKey: 'AIzaSyCEQGxi6nGugPQj9clfxiGtcKg0sb0ZZI8',
    authDomain: 'waitero.firebaseapp.com',
    databaseURL: 'https://waitero.firebaseio.com',
    projectId: 'waitero',
    storageBucket: 'waitero.appspot.com',
    messagingSenderId: '62252923366',
    appId: '1:62252923366:web:aee03a8d781c3c75c67e27',
    measurementId: 'G-2MRZ9WZ1EM',
  );

  runApp(WaiteroClientApp());
}

class WaiteroClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<ProductsRepository>(create: (_) => ProductsRepository()),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: const OrderPage(),
        debugShowCheckedModeBanner: false,
        navigatorObservers: <NavigatorObserver>[
          AnalyticsRouteObserver(
            analytics: js.context.hasProperty('firebase') ? analytics() : null,
          )
        ],
      ),
    );
  }
}
