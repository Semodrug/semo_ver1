import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;
  final String effect;
  final String sideEffect;
  final String overall;
  final String id;
  final bool favoriteSelected;
  int noFavorite;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        assert(map['effect'] != null),
        assert(map['sideEffect'] != null),
        assert(map['overall'] != null),
        assert(map['id'] != null),
        assert(map['favoriteSelected'] != null),
        assert(map['noFavorite'] != null),
//        assert(map['id'] != null),
//        assert(map['id'] != null),
//        assert(map['id'] != null),

        name = map['name'],
        votes = map['votes'],
        effect = map['effect'],
        sideEffect = map['sideEffect'],
        overall = map['overall'],
        id = map['id'],
        favoriteSelected = map['favoriteSelected'],
        noFavorite = map['noFavorite'];
//        id = map['id'],
//        id = map['id'],
//        id = map['id'],

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}
