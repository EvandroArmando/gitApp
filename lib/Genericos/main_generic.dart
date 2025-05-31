import 'package:flutter/material.dart';
import 'package:git_app/Genericos/person.dart';

void main() {
  Person<String> pessoa = Person('Evandro Armando');

  pessoa.returnValue();
}
