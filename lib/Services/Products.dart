import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Widgets/GridViewStreamBuilder.dart';

class ProductServices {
  final db = FirebaseFirestore.instance.collection('Products');

  //get all jackets from database and using a streambuilder to build it
  Widget getJackets() {
    final Stream<QuerySnapshot> snapshots =
        db.where('type', isEqualTo: p_type_jacket).orderBy('Name').snapshots();

    return CustomStreamBuilder(snapshots: snapshots);
  }

  //get all trousers from database and using a streambuilder to build it
  Widget getTrousers() {
    final Stream<QuerySnapshot> snapshots = db
        .where('type', isEqualTo: p_type_trousers)
        .orderBy('Name')
        .snapshots();
    return CustomStreamBuilder(snapshots: snapshots);
  }

  //get all shirts from database and using a streambuilder to build it
  Widget getShirts() {
    final Stream<QuerySnapshot> snapshots =
        db.where('type', isEqualTo: p_type_shirt).orderBy('Name').snapshots();
    return CustomStreamBuilder(snapshots: snapshots);
  }

  //get all shoes from database and using a streambuilder to build it
  Widget getShoes() {
    final Stream<QuerySnapshot> snapshots =
        db.where('type', isEqualTo: p_type_shoes).orderBy('Name').snapshots();
    return CustomStreamBuilder(snapshots: snapshots);
  }
}
