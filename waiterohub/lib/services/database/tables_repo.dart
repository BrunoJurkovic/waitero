import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:waitero/providers/table.dart';

/*
  ! In this file we manage everything related to tables.
  ? U ovoj datoteci upravljamo svime sto je vezano za stoloves.
*/

class TablesRepository with ChangeNotifier {
  ///!EN: We get a ref to the database at '/tables/'.
  ///
  ///?HR: Nabavimo ref za databazu na '/tables/'.
  CollectionReference ref = Firestore.instance.collection('tables');

  final Map<String, RestaurantTable> _localTables = <String, RestaurantTable>{};

  void init() {
    _getAllTables();
  }

  ///!EN: This function sets the [localTables] variable to the result of a query that fetches
  ///! all tables, then uses [.map] on each of them to return a table.
  ///
  ///?HR: Ova funkcija postavi [localTables] varijablu na rezultat query-a koji nabavi
  ///? sve stolove, onda koristi [.map] na svakom rezultatu, pa vrati stol.
  Future<void> _getAllTables() async {
    final QuerySnapshot query = await ref.getDocuments();
    final List<RestaurantTable> allTables = query.documents
        .map((DocumentSnapshot doc) => RestaurantTable.fromDocument(doc))
        .toList();
    for (final RestaurantTable table in allTables) {
      _localTables[table.id] = table;
    }
    notifyListeners();
  }

  ///!EN: This getter returns the [_localTablet, unless if it is empty, then it returns an empty map.
  ///
  ///?HR: Ovaj getter vrati [_localTables], osim ako je prazna, onda vrati praznu mapu.
  Map<String, RestaurantTable> get tables {
    return _localTables ?? <String, RestaurantTable>{};
  }

  ///!EN: This function creates a new table at the index of the table id.
  ///
  ///?HR: Ova funkcija napravi novi stol na indeksu prema id stola.
  void createLocalTable(RestaurantTable table) {
    _localTables[table.id] = table;
    notifyListeners();
  }

  ///!EN: This function is called when the user discards their changes, by calling [_getAllTables()]
  ///! which resets [_localTables] to the database version.
  ///
  ///?HR: Ova funkcija je zvana kada korisnik odbaci promjene, na nacin da zove [_getAllTables()]
  ///? koja resetira [_localTables] na verziju iz databaze.
  void discardChanges() {
    _getAllTables();
  }

  int getNextID() {
    int tempId = 0;
    final List<int> ids = <int>[];

    if (_localTables.isEmpty) {
      return 0;
    }

    _localTables.forEach((String id, RestaurantTable table) {
      ids.add(
        int.parse(id),
      );
    });

    for (final int id in ids) {
      if (ids.isEmpty) {
        return 0;
      }
      if (id == tempId) {
        tempId++;
        continue;
      } else {
        break;
      }
    }
    return tempId;
  }

  ///!EN: This function updates the table offset, it gets a 'tableID' and a 'newOffset',
  ///! then sets the 'newOffset' at the table that has the same 'tableID'.
  ///
  ///?HR: Ova funkcija azurira poziciju stola, uzima 'tableID' i 'newOffset',
  ///? onda azurira 'newOffset' sa stolom koji ima isti 'tableID'
  void updateLocalTableOffset(String tableID, Offset newOffset) {
    final RestaurantTable table = _localTables[tableID];
    table.tablePosition = newOffset;
    _localTables[tableID] = table;
  }

  ///!EN: This function updates the table in the database. It takes a 'id' and 'newTable',
  ///! then it runs [updateData] on the 'tableId' and pushes it to the database.
  ///
  ///?HR: Ova funkcija azurira stolove u databazi. Uzima 'id' i 'newTable',
  ///? onda zove [updateData] na stolu 'tableId' i posalje u databazu.
  Future<void> updateTable(String id, RestaurantTable newTable) async {
    _localTables[id] = newTable;
    await ref.document(id).updateData(newTable.toJson());
    notifyListeners();
  }

  Future<void> switchTableShape(String id, bool isRound) async {
    print(isRound);
    _localTables[id].tableShape = isRound;
    print(_localTables[id].isRound);
    await ref.document(id).updateData(
      <String, bool>{
        'isRound': isRound,
      }
    );
    notifyListeners();
  }

  ///!EN: This function sends all of the local tables to the database.
  ///
  ///?HR: Ova funkcija posalje sve lokalne stolove u databazu.
  Future<void> sendTables() {
    final WriteBatch batch = Firestore.instance.batch();
    for (final String id in _localTables.keys) {
      final DocumentReference docRef = ref.document(id);
      batch.setData(docRef, _localTables[id].toJson());
    }
    return batch.commit();
  }

  ///!EN: This function deletes a table. It takes an 'tableID', first it finds it locally and deletes it,
  ///! then it finds it in the database and deletes it.
  ///
  ///?HR: Ova funkcija izbrise stol. Uzima 'tableID', prvo pronade stol lokalno i izbrise ga,
  ///? onda ga nade u databazi i izbrise ga.
  Future<void> deleteTable(String tableID) async {
    _localTables.remove(tableID);
    await ref.document(tableID).delete();
    notifyListeners();
  }
}
