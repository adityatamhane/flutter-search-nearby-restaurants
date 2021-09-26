import 'dart:convert';

import 'package:application/utils/reusableWidgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:application/api/apiHandler.dart';

class RestaurantController extends GetxController {
  var restaurants = List.empty().obs;
  var status = "".obs;
  var nextPageToken = "".obs;
  var results = "".obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getResturants();
  }

  void getResturants() async {
    isLoading.value = true;
    //await Future.delayed(Duration(seconds: 1));
    var url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&key=AIzaSyDxVclNSQGB5WHAYQiHK-VxYKJelZ_9mjk";
    var resturantsData = await ApiHandler.hitGetApi(url);
    var data = jsonDecode(resturantsData);
    status.value = data['status'];
    if (status.value == "OK") {
      nextPageToken.value = data['next_page_token'] ?? "";
      restaurants.value = data['results'] ?? List.empty();
      isLoading.value = false;
    } else {
      ReusableWidgets.normalSnackBar("Something is Wrong", "Data not found!");
      isLoading.value = false;
    }
  }

  void getSearchResturants(query) async {
    isLoading.value = true;
    //await Future.delayed(Duration(seconds: 3));
    var url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=47.6204,-122.3491&radius=2500&type=restaurant&keyword=" +
            query.trim() +
            "&key=AIzaSyDxVclNSQGB5WHAYQiHK-VxYKJelZ_9mjk";
    var resturantsData = await ApiHandler.hitGetApi(url);
    var data = jsonDecode(resturantsData);
    status.value = data['status'];
    if (status.value == "OK") {
      nextPageToken.value = data['next_page_token'] ?? "";
      restaurants.value = data['results'] ?? List.empty();
      isLoading.value = false;
    } else {
      ReusableWidgets.normalSnackBar("Ohh!", "No such restaurant found");
      isLoading.value = false;
    }
  }
}
