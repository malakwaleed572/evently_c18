import 'package:evently/common/category_row_widget.dart';
import 'package:evently/common/gen/assets.gen.dart';
import 'package:evently/common/theme/text_style.dart';
import 'package:evently/screens/home/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListView(
      children: [
        Row(
          children: [
            Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back ✨",
                  style: theme.textTheme.labelSmall!.copyWith(
                    color: theme.hintColor,
                  ),
                ),
                Text(
                  "Name", //TODO:with provider
                  style: theme.textTheme.displayMedium!.copyWith(
                    //color: Colors.white,
                  ),
                ),
              ],
            ),
            Spacer(),

            IconButton(onPressed: () {}, icon: Icon(Icons.wb_sunny_outlined)),
            SizedBox(
              height: 32,
              width: 32,
              child: FilledButton(
                onPressed: () {},

                style: FilledButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.all(0),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                child: Text(
                  "EN",
                  style: AppTextStyle.style14w500Black.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        CategoryRow(showAll: true),
        EventCard(),
      ],
    );
  }
}
