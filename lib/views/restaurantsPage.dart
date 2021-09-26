import 'package:application/controllers/restaurantsController.dart';
import 'package:application/utils/reusableWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestaurantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: RestaurantsPageHome());
  }
}

class RestaurantsPageHome extends StatefulWidget {
  @override
  _RestaurantsPageHomeState createState() => _RestaurantsPageHomeState();
}

class _RestaurantsPageHomeState extends State<RestaurantsPageHome> {
  late RestaurantController restaurantController;
  late ScrollController _scrollController;
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() {
    restaurantController = Get.put(RestaurantController());
    _scrollController = new ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //If we are bottom of the page then will call next page api here and append data in restaurantController.restaurants
      }
    });
  }

  Widget restaurantListView() {
    if (restaurantController.isLoading.value) {
      return ReusableWidgets.centerCircularLoader();
    } else {
      return Expanded(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: restaurantController.restaurants.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                    //height: 200,
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Align(
                                  alignment: Alignment.topCenter,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/images/placeholder.jpeg',
                                        image: restaurantController
                                            .restaurants[index]['icon'],
                                        height: 5,
                                        width: 5,
                                      ),
                                    ),
                                  ))),
                          Expanded(
                              flex: 3,
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                restaurantController
                                                    .restaurants[index]["name"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                          SizedBox(height: 10),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  restaurantController
                                                          .restaurants[index]
                                                      ["vicinity"],
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.4)))),
                                          SizedBox(height: 10),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Total Rating : " +
                                                      restaurantController
                                                          .restaurants[index][
                                                              "user_ratings_total"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.8)))),
                                        ],
                                      )))),
                          Expanded(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FractionallySizedBox(
                                        widthFactor: 1,
                                        child: TextButton(
                                            child: Text(restaurantController
                                                .restaurants[index]["rating"]
                                                .toString()),
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor: Colors.green,
                                              onSurface: Colors.green,
                                              elevation: 5,
                                            ),
                                            onPressed: () {
                                              print('Pressed');
                                            })),
                                  ))),
                        ])),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              );
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Obx(() {
      return Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Search for restraurants",
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(Icons.search),
                    ),
                  ),
                  onChanged: (val) {
                    restaurantController.getSearchResturants(val);
                  },
                ),
              )),
          restaurantListView()
        ],
      );
    })));
  }
}
