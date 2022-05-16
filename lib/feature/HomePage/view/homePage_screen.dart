import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:recipeapp/core/init/network/food_service.dart';
import 'package:recipeapp/feature/HomePage/view/myProfiledSearch.dart';
import '../../../core/constant/strings/homePage_string.dart';
import '../../../core/init/theme/color/color_theme.dart';
import '../model/category_card_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final FoodService _foodService = FoodService();

  late TabController _tabController = TabController(vsync: this, length: 2);

  final TextEditingController _searchController = TextEditingController();
  String ctg = 'Food';
  final List<Map> myProducts =
      List.generate(15, (index) => {"id": index, "name": "Product $index"})
          .toList();
  List<FoodCategory> categoryList = [
    FoodCategory(category: 'Food', selected: true),
    FoodCategory(category: 'Drink', selected: false),
    FoodCategory(category: 'All', selected: false),
  ];
  @override
  void initState() {
    super.initState();
    //_tabController =
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.dynamicHeight(0.1)),
            const MySearch(),
            SizedBox(height: context.dynamicHeight(0.03)),
            Text(HomePageString.categoryText,
                style: context.textTheme.headline5),
            SizedBox(height: context.dynamicHeight(0.02)),
            _buildCategories(context, categoryList, setState, _foodService),
            SizedBox(height: context.dynamicHeight(0.04)),
          ],
        ),
        padding: context.horizontalPaddingMedium,
      ),
      Divider(thickness: 11, height: 10, color: AppColors().lightGrey),
      Expanded(
          child: DefaultTabController(
              length: 2,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                  constraints: const BoxConstraints.expand(height: 50),
                  child: TabBar(
                      labelStyle:
                          context.textTheme.headline6?.copyWith(fontSize: 18),
                      indicator: ShapeDecoration(
                        shape: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: AppColors().green,
                          width: 2,
                        )),
                      ),
                      tabs: [
                        Tab(text: HomePageString.leftText),
                        Tab(text: HomePageString.rightText),
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    _getFood(context, _foodService, ctg),
                    _rightList()
                  ]),
                )
              ])))
    ]));
  }

  Widget _rightList() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      //key: PageStorageKey(key),
      itemBuilder: (_, i) => ListTile(title: Text("${i}")),
    );
  }

// _buildSearchBar(BuildContext context) {

  _buildCategories(BuildContext context, var categoryList, setState,
      FoodService foodService) {
    return SizedBox(
        height: context.height * 0.06,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Row(children: [
              SizedBox(
                height: 80,
                width: 90,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (int i = 0; i < categoryList.length; i++) {
                        if (index == i) {
                          categoryList[index].selected =
                              !categoryList[index].selected;
                          ctg = categoryList[index].category;
                        } else {
                          categoryList[i].selected = false;
                        }
                      }
                    });
                  },
                  child: Text("${categoryList[index].category}",
                      style:
                          context.textTheme.bodyText1?.copyWith(fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    primary: (categoryList[index].selected == true)
                        ? AppColors().green
                        : AppColors().lightGrey,
                  ),
                ),
              ),
              SizedBox(
                width: context.dynamicWidth(0.05),
              )
            ]);
            // _buttons(mypost: mypost);
          },
        ));
  }

  _getFood(BuildContext context, FoodService foodService, String catagoryname) {
    return Padding(
        padding: context.paddingLow.copyWith(
            right: context.paddingLow.right * 2,
            left: context.paddingLow.left * 2,
            bottom: context.paddingLow.bottom * 2),
        child: StreamBuilder<QuerySnapshot>(
            stream: foodService.getFood(catagoryname),
            builder: (context, snaphot) {
              return !snaphot.hasData
                  ? const CircularProgressIndicator()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemCount: snaphot.data!.docs.length,
                      itemBuilder: (BuildContext ctx, index) {
                        DocumentSnapshot mypost = snaphot.data!.docs[index];

                        return Container(
                          alignment: Alignment.center,
                          child: Text("${mypost['foodName']}"),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15)),
                        );
                      });
            })
            );
  }
}
