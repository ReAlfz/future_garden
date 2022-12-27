import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'model.dart';

class Services extends ChangeNotifier {
  List<DataItem> list = [];

  addListServices(DataItem item) {
    list.add(item);
    notifyListeners();
  }

  removeListServices(int index) {
    list.removeAt(index);
    notifyListeners();
  }
}

class LoadJson {
  Future<HeadList> getData() async {
    final response =
    await http.get(Uri.parse("https://api.npoint.io/809cd58bb91c61db7ff0"));

    if (response.statusCode == 200) {
      return HeadList.fromJson(jsonDecode(response.body));
    } else {
      return getData();
    }
  }
}

class Currency {
  static String convertToIDR(dynamic number) {
    NumberFormat currency = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currency.format(number);
  }
}