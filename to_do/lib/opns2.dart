import 'package:flutter/material.dart';

class ChoiceOptions{
  final Text opt;
  final Icon ic;

  const ChoiceOptions({this.opt,this.ic});
}

const List<ChoiceOptions> choiceoptions = <ChoiceOptions> [
    const ChoiceOptions(opt:const Text('Delete'),ic: Icon(Icons.delete)),
    const ChoiceOptions(opt:const Text('Rename'),ic: Icon(Icons.edit)),
];