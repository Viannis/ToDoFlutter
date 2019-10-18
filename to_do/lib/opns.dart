import 'package:flutter/material.dart';

class Opns{
  final Text opt;
  final Icon ic;
  const Opns({this.opt,this.ic});
}

const List<Opns> options = <Opns> [
    const Opns(opt:const Text('Delete'),ic: Icon(Icons.delete) ),
    const Opns(opt:const Text('Edit'),ic: Icon(Icons.edit)),
];