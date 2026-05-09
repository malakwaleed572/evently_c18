import 'package:evently/common/category_row_widget.dart';
import 'package:evently/common/gen/assets.gen.dart';
import 'package:evently/common/models/event_model.dart';
import 'package:evently/common/theme/text_style.dart';
import 'package:evently/network/event_service.dart';
import 'package:evently/screens/home/tabs/home_tab/home_provider.dart';
import 'package:evently/screens/home/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
   
    
    return Column(
      children: [
        
        CategoryRow(
  
          onChange: (id) {
            Provider.of<HomeProvider>(
              context,
              listen: false,
            ).updateSelectedCat(id);
          },
        ),

        Expanded(
          child: FutureBuilder(
            future: Provider.of<HomeProvider>(
              context,
              listen: false,
            ).getEvents(),
            builder: (context, snapshot) {
             
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Icon(Icons.error, size: 50));
              } else {
                List<EventModel> events = Provider.of<HomeProvider>(
                  context,
                ).events;
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      EventCard(eventModel: events[index]),
                  itemCount: events.length,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
