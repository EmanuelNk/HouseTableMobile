import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<JsonData> fetchJson() async {
  final response =
      await http.get('https://housetabledemo.azure-api.net/api/data');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return JsonData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load json');
  }
}

class JsonData {
  final List<Relationships> relationships;
  final List<StartRenovations> startRenovations;
  final List<StatusTypes> statusTypes;
  final List<HouseItems> houseItems;

  JsonData(
      {this.houseItems,
      this.relationships,
      this.startRenovations,
      this.statusTypes});
  // JsonData({this.relationships, this.startRenovations, this.statusTypes});

  factory JsonData.fromJson(Map<String, dynamic> json) {
    var relationshipList = json['relationships'] as List;
    print('relationships');
    List<Relationships> relationships =
        relationshipList.map((i) => Relationships.fromJson(i)).toList();

    var startRenovationList = json['start_renovations'] as List;
    print('start_renovations');
    List<StartRenovations> start_renovation =
        startRenovationList.map((i) => StartRenovations.fromJson(i)).toList();

    var statusTypesList = json['status_types'] as List;
    print('status_types');
    List<StatusTypes> status_types =
        statusTypesList.map((i) => StatusTypes.fromJson(i)).toList();

    var houseItemsList = json['house_items'] as List;
    print('house_items');
    List<HouseItems> house_items =
        houseItemsList.map((i) => HouseItems.fromJson(i)).toList();
    
    return JsonData(
        relationships: relationships,
        startRenovations: start_renovation,
        statusTypes: status_types,
        houseItems: house_items);
  }
}

class Relationships {
  final int id;
  final String type;
  final String text;

  Relationships({this.id, this.text, this.type});

  Map<String, dynamic> getValues() {
    return {'id': id, 'type': type, 'text': text};
  }

  factory Relationships.fromJson(Map<String, dynamic> json) {
    return Relationships(
        id: json['id'], text: json['text'], type: json['type']);
  }
}

class StartRenovations {
  final int id;
  final String text;

  StartRenovations({this.id, this.text});

  Map<String, dynamic> getValues() {
    return {'id': id, 'text': text};
  }

  factory StartRenovations.fromJson(Map<String, dynamic> json) {
    return StartRenovations(id: json['id'], text: json['text']);
  }
}

class StatusTypes {
  int id;
  String text;

  StatusTypes({this.id, this.text});

  factory StatusTypes.fromJson(Map<String, dynamic> json) {
    return StatusTypes(id: json['id'], text: json['text']);
  }
}

class HouseItems {
  int type;
  String name;
  List<ItemType> items;

  HouseItems({this.type, this.name, this.items});

  factory HouseItems.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    print(list.runtimeType);
    List<ItemType> items = list.map((i) => ItemType.fromJson(i)).toList();

    return HouseItems(type: json['type'], name: json['name'], items: items);
  }
}

class ItemType {
  int id;
  String name;

  ItemType({this.id, this.name});

  factory ItemType.fromJson(Map<String, dynamic> json) {
    return ItemType(id: json['id'], name: json['name']);
  }
}
