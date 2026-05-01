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
}
