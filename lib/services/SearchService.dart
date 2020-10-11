import 'dart:convert';

import 'package:flutter_myshop/services/Storage.dart';

class SearchService {
  static const SEARCHLIST = "searchList";

  static setHistoryList(String keywords) async {
    try {
      List searchListData = json.decode(await Storage.getString(SEARCHLIST));
      bool hasData = searchListData.any((element) => keywords == element);
      if (!hasData && !["", null, false, 0].contains(keywords)) {
        searchListData.add(keywords);
        await Storage.setString(SEARCHLIST, json.encode(searchListData));
      }
    } catch (e) {
      List tempList = new List();
      tempList.add(keywords);
      await Storage.setString(SEARCHLIST, json.encode(tempList));
    }
  }

  static getHistoryList() async {
    try {
      List searchListData = json.decode(await Storage.getString(SEARCHLIST));
      return searchListData;
    } catch (e) {
      return [];
    }
  }

  static clearHistoryList() async {
    await Storage.remove(SEARCHLIST);
  }

  static removeHistoryData(String keywords) async {
    List searchListData = json.decode(await Storage.getString(SEARCHLIST));
    searchListData.remove(keywords);
    await Storage.setString(SEARCHLIST, json.encode(searchListData));
  }
}
