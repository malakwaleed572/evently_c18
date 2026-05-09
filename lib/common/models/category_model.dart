import 'package:evently/common/gen/assets.gen.dart';

class CategoryModel {
  String title;
  String iconPath;
  String image;
  int id;
  CategoryModel({
    required this.iconPath,
    required this.id,
    required this.image,
    required this.title,
  });
  static generateCategories() {

    return [
      CategoryModel(
        iconPath: Assets.icons.bookIconUnselected.path,
        id: 1,
        image: Assets.images.bookclubDesign.path,
        title: "Book club",
      ),
      CategoryModel(
        iconPath: Assets.icons.sportIconUnselected.path,
        id: 2,
        image: Assets.images.sportDesign.path,
        title: "Sports",
      ),
      CategoryModel(
        iconPath: Assets.icons.birthdayIconUnselected.path,
        id: 3,
        image:Assets.images.birthdayDesign.path,
        title: "Birthday",
      ),
    ];
  }
static String getCatImage(int id){
  List<CategoryModel>categories=generateCategories();
  if(id==1)return categories[0].image;
  if(id==2)return categories[1].image;
  if(id==3)return categories[2].image;
  if(id==4)return categories[3].image;
  
return categories[0].image;
}
}
