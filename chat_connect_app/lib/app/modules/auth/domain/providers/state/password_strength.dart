	
  import 'package:flutter/material.dart';

enum Strength {
    empty('', 0 / 4, Colors.transparent),
    weak('weak', 1 / 4, Colors.red),
    medium('medium', 2 / 4, Colors.yellow),
    strong('strong', 3 / 4, Colors.blue),
    veryStrong('very strong', 4 / 4, Colors.green),
    ;
  
    final String text;
    final double value;
    final Color color;
  
    const Strength(this.text, this.value, this.color);
  }

  