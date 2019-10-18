import 'package:flutter/material.dart';

class Options{
  final Text opt;
  final Icon ic;

  const Options({this.opt,this.ic});
}

const List<Options> options = <Options> [
    const Options(opt:const Text('Delete'),ic: Icon(Icons.delete) ),
    const Options(opt:const Text('Rename'),ic: Icon(Icons.edit)),
    const Options(opt:const Text('Clear Completed'),ic: Icon(Icons.clear_all)),
    const Options(opt:const Text('Mark all complete'),ic: Icon(Icons.done_all)),
];