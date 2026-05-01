import 'dart:math';

import 'package:evently/common/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryRow extends StatefulWidget {
  const CategoryRow({super.key, this.showAll = false});
  final bool showAll;
  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  late int selsctedCategory = widget.showAll ? 0 : 1;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (widget.showAll)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ChoiceChip(
                label: Row(
                  spacing: 4,
                  children: [
                    Icon(
                      Icons.category,
                      color: selsctedCategory == 0 ? Colors.white : null,
                    ),
                    Text("All"),
                  ],
                ),
                labelStyle: theme.textTheme.titleMedium!.copyWith(
                  color: selsctedCategory == 0 ? Colors.white : null,
                ),
                selected: selsctedCategory == 0,
                onSelected: (value) {
                  setState(() {
                    selsctedCategory=0;
                  });
                },
                showCheckmark: false,
                backgroundColor: theme.cardColor,
                selectedColor: theme.colorScheme.primary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),
            ),

          ...CategoryModel.generateCategories().map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      e.iconPath,
                      colorFilter:selsctedCategory == e.id ? ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ):null,
                    ),
                    Text(e.title),
                  ],
                ),
                labelStyle: theme.textTheme.titleMedium!.copyWith(
                  color: selsctedCategory == e.id ? Colors.white : null,
                ),
                selected: selsctedCategory == e.id,
                onSelected: (value) {
                  setState(() {
                    selsctedCategory = e.id;
                  });
                },
                showCheckmark: false,
                backgroundColor: theme.cardColor,
                selectedColor: theme.colorScheme.primary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
