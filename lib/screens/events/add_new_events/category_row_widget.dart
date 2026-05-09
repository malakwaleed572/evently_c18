

import 'package:evently/common/models/category_model.dart';
import 'package:evently/screens/events/provider/events_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CustomCategoryRow extends StatelessWidget {
  const CustomCategoryRow({super.key});

  // late int selsctedCategory =  1;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    CategoryModel selectedCtegory = Provider.of<EventsProvider>(
      context,
    ).selectedCtegory;
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ...CategoryModel.generateCategories().map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      e.iconPath,
                      colorFilter: selectedCtegory.id == e.id
                          ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : null,
                    ),
                    Text(e.title),
                  ],
                ),
                labelStyle: theme.textTheme.titleMedium!.copyWith(
                  color: selectedCtegory.id == e.id ? Colors.white : null,
                ),
                selected: selectedCtegory.id == e.id,
                onSelected: (value) {
                  Provider.of<EventsProvider>(
                    context,
                    listen: false,
                  ).editSelectedCategory(e);
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
