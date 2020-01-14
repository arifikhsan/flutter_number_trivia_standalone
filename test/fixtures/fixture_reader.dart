import 'dart:io';

fixture(String name) => File('test/fixtures/$name').readAsStringSync();
