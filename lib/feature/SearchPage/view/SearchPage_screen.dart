import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../../../core/init/network/food_service.dart';
import '../../../core/init/theme/color/color_theme.dart';
import '../../../product/widgets/customElevatedButton.dart';
import '../../../product/widgets/customSlider.dart';
import '../../HomePage/model/category_card_model.dart';

class SearchItems extends StatefulWidget {
  SearchItems({Key? key}) : super(key: key);

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  static const String prefSearchKey = "previousSearches";
  bool inErrorState = false;
  List<String> previousSearches = [];
  final FoodService _foodService = FoodService();
  var searchTextController = TextEditingController();
  String searchWord = '';
  final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
  final FocusNode _focus = FocusNode();
  String selectedCatagory = 'Food';
  double cookingTime = 10;

  List<FoodCategory> categoryList = [
    FoodCategory(category: 'Food', selected: true),
    FoodCategory(category: 'Drink', selected: false),
    FoodCategory(category: 'All', selected: false),
  ];

  Stream<QuerySnapshot<Object?>>? itemsC;
  @override
  void initState() {
    super.initState();
    itemsC = _foodService.getFood('All');
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  double _value = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: context.highBorderRadius.topLeft,
                    topRight: context.highBorderRadius.topLeft),
              ),
              context: context,
              builder: (context) => StatefulBuilder(
                builder: (context, setStateSB) => _buildSheet(setStateSB),
              ),
            ),
            icon: const Icon(Icons.filter_list_rounded),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
        title: _searchBar(context),
      ),
      body: Column(children: [
        SizedBox(height: context.dynamicHeight(0.1)),
        (_focus.hasPrimaryFocus == true)
            ? _showSearchHistory()
            : _getCategoryItems()
      ]),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _getCategoryItems() {
    return StreamBuilder<QuerySnapshot>(
        stream: itemsC,
        builder: (context, snaphot) {
          return !snaphot.hasData
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
        });
  }

  ListView _showSearchHistory() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: previousSearches.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: const Icon(Icons.arrow_drop_up_outlined),
            leading: const Icon(Icons.access_time_sharp),
            title: Text(previousSearches[index]),
            onTap: () {
              searchTextController.text = previousSearches[index];
              startSearch(searchTextController.text);
            },
          );
        });
  }

  SizedBox _searchBar(BuildContext context) {
    return SizedBox(
      height: 55,
      child: CupertinoSearchTextField(
        onSuffixTap: () {
          searchTextController.clear();
          setState(() {
            itemsC = _foodService.getFood('All');
          });
          _focus.unfocus();
        },
        focusNode: _focus,
        padding: context.horizontalPaddingNormal,
        borderRadius: BorderRadius.circular(30),
        onChanged: (String value) {},
        onSubmitted: (String value) {
          if (!previousSearches.contains(value)) {
            previousSearches.add(value);
            savePreviousSearches();
          }
          _focus.unfocus();
          if (value != '') {
            searchWord = value;
            itemsC = _foodService.SearchFood(value);
          }
        },
        prefixInsets: const EdgeInsets.only(left: 15),
        controller: searchTextController,
      ),
    );
  }

  _buildSheet(var setStateSB) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.dynamicHeight(0.015)),
          Expanded(
            flex: 1,
            child: Align(
              child: Text(
                'Add a Filter',
                style: context.textTheme.bodyLarge,
              ),
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.02)),
          Expanded(
              flex: 1,
              child: Text(
                'Category',
                style: context.textTheme.bodyLarge,
              )),
          SizedBox(height: context.dynamicHeight(0.02)),
          Expanded(
              flex: 2,
              child: _buildCategories(context, categoryList, setStateSB)),
          SizedBox(height: context.dynamicHeight(0.03)),
          Expanded(
              flex: 1,
              child: Text('Cooking Duration ',
                  style: context.textTheme.bodyLarge)),
          Expanded(
              flex: 2,
              child:
                  // _sliderBar(setStateSB)
                  CustomSilder(
                value: _value,
                cookingTime: cookingTime,
              )),
          SizedBox(height: context.dynamicHeight(0.03)),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  buttonText: 'Cancel',
                  onpressedFun: () {
                    Navigator.pop(context);
                  },
                  isCancel: true,
                ),
                CustomElevatedButton(
                  buttonText: 'Done',
                  onpressedFun: () {
                    setState(() {
                      itemsC = _foodService.filerFoodByCatagoryBytime(
                          cookingTime.toInt(), selectedCatagory);
                    });
                    Navigator.pop(context);
                  },
                  isCancel: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  SfSlider _sliderBar(setStateSB) {
    return SfSlider(
      activeColor: AppColors().green,
      stepSize: 20,
      min: 0.0,
      max: 40.0,
      interval: 20,
      labelFormatterCallback: (dynamic actualValue, String formattedText) {
        switch (actualValue) {
          case 0:
            cookingTime = 10;
            return '<10';
          case 20:
            cookingTime = 30;

            return '30';
          case 40:
            cookingTime = 60;

            return '>60';
        }
        return actualValue.toString();
      },
      showTicks: true,
      showLabels: true,
      showDividers: true,
      value: _value,
      minorTicksPerInterval: 1,
      onChanged: (dynamic newValue) {
        setStateSB(() {
          _value = newValue;
        });
      },
    );
  }

  void startSearch(String value) {
    setState(() {
      if (!previousSearches.contains(value)) {
        previousSearches.add(value);

        savePreviousSearches();
      }
    });
  }

  void romveSearch(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
  }

  void getPreviousSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      previousSearches = prefs.getStringList(prefSearchKey)!;
    }
  }

  void savePreviousSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
    if (previousSearches.length > 3) {
      setState(() {
        previousSearches.removeAt(0);
      });
    }
  }

  Stream<QuerySnapshot<Object?>> filterSearchResults(String query) {
    var searchedItems = _foodService.SearchFood(query);
    return searchedItems;
  }

  _buildCategories(BuildContext context, var categoryList, setStateSB) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return Row(children: [
          SizedBox(
            height: 50,
            width: 90,
            child: ElevatedButton(
              onPressed: () {
                for (int i = 0; i < categoryList.length; i++) {
                  if (index == i) {
                    setStateSB(() {
                      categoryList[index].selected =
                          !categoryList[index].selected;
                      selectedCatagory = categoryList[index].category;
                    });
                  } else {
                    setStateSB(() {
                      categoryList[i].selected = false;
                    });
                  }
                }
              },
              child: Text(
                "${categoryList[index].category}",
                style: context.textTheme.bodyLarge,
              ),
              style: ElevatedButton.styleFrom(
                  primary: categoryList[index].selected == true
                      ? AppColors().green
                      : AppColors().lightGrey),
            ),
          ),
          SizedBox(
            width: context.dynamicWidth(0.05),
          )
        ]);
      },
    );
  }
}
