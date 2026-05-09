import 'package:evently/common/models/category_model.dart';
import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier {
  CategoryModel selectedCtegory = CategoryModel.generateCategories().first;
   DateTime? selectedDate; //2026/5/1  15:7pm
  TimeOfDay? selectedTime; //15:7pm

  editSelectedCategory(CategoryModel newwCat) {
    selectedCtegory = newwCat;
    notifyListeners();
  }
  editDate(DateTime newDate){
selectedDate=newDate;
notifyListeners();
  }
  editTime(TimeOfDay newTime){
selectedTime=newTime;
notifyListeners();
  }
}


