import 'package:flutter/material.dart';

class FilterOptions{
  final Text opt;
  bool checkOptions;
  FilterOptions({this.opt,this.checkOptions});
}

List<FilterOptions> filterOptions = <FilterOptions> [
    FilterOptions(opt:Text('All'),checkOptions: true),
    FilterOptions(opt:Text('Active'),checkOptions: false),
    FilterOptions(opt:Text('Completed'),checkOptions: false),
];