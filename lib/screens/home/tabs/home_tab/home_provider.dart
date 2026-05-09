import 'package:evently/common/models/event_model.dart';
import 'package:evently/network/event_service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<EventModel> events = [];
  List<EventModel> allEvents = [];
  int selectedCategory=0;
  updateSelectedCat(int id){
    selectedCategory=id;
    notifyListeners();
    getEvents();
  }
  Future<String?> getEvents() async {
    try {
      if(selectedCategory==0)
     { events = await EventService.getAllEvents();
      }else{
        events=await EventService.getFillterEvents(selectedCategory);

      }
      if(hasListeners){
      notifyListeners();}
    } on Exception catch (e) {
      return e.toString();
    }
  }

 // filterEventsByCatId(int id) {
    //if (id == 0) {
    //  events = [...allEvents];
    }
    //events = [...allEvents.where((element) => element.catid == id).toList()];
   // notifyListeners();
 // }
//}
