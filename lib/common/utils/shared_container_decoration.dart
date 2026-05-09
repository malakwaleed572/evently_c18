import 'package:flutter/material.dart';

class SharedContainerDecoration {

 static BoxDecoration  decorationWithBorder(ThemeData theme)=> BoxDecoration(
             
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.dividerColor),
            );
}