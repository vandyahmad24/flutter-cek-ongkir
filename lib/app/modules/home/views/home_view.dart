import 'package:cek_ongkir/app/config/config.dart';
import 'package:cek_ongkir/app/data/models/city_model.dart';
import 'package:cek_ongkir/app/data/models/province_model.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final String apiKey =
      "f680c6d9374b15bae31a97033abf3fa404dc47f4a5b31cbd7d0772325b3171df";
  String? idProv = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Aplikasi Cek Ongkir',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: Text(
              "Alamat Pengiriman",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.black, thickness: 1),
          SizedBox(height: 15),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DropdownSearch<Province>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item.province ?? ""),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    );
                  },
                ),
                dropdownBuilder: (context, item) =>
                    Text(item?.province ?? "Pilih Provinsi"),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Pilih Provinsi",
                    hintText: "Silahkan Pilih Provinsi",
                  ),
                ),
                asyncItems: (String filter) async {
                  try {
                    var response = await Dio().get(
                      Config.apiUrl + '/province',
                      options: Options(
                        headers: {"key": Config.apiKey},
                      ),
                    );

                    if (response.statusCode == 200) {
                      List<dynamic> jsonList =
                          response.data['rajaongkir']['results'];
                      var provinces = Province.fromJsonList(jsonList);
                      return provinces;
                    } else {
                      print('Failed to load provinces');
                      return [];
                    }
                  } catch (e) {
                    print('Error: $e');
                    return [];
                  }
                },
                onChanged: (Province? data) {
                  controller.provAsalId.value = data?.provinceId ?? "";
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DropdownSearch<City>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item.cityName ?? ""),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    );
                  },
                ),
                dropdownBuilder: (context, item) =>
                    Text(item?.cityName ?? "Pilih Kota"),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Pilih Kota",
                    hintText: "Silahkan Pilih Kota",
                  ),
                ),
                asyncItems: (String filter) async {
                  if (controller.provAsalId.value.isEmpty) {
                    return []; // Return empty list if province ID is empty
                  }
                  try {
                    var response = await Dio().get(
                      Config.apiUrl +
                          '/city?province=${controller.provAsalId.value}',
                      options: Options(
                        headers: {"key": Config.apiKey},
                      ),
                    );

                    if (response.statusCode == 200) {
                      List<dynamic> jsonList =
                          response.data['rajaongkir']['results'];
                      var city = City.fromJsonList(jsonList);
                      return city;
                    } else {
                      print('Failed to load city');
                      return [];
                    }
                  } catch (e) {
                    print('Error: $e');
                    return [];
                  }
                },
                onChanged: (City? data) {
                  controller.cityAsalId.value = data?.cityId ?? "";
                },
              ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              "Alamat Penerima",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.black, thickness: 1),
          SizedBox(height: 15),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DropdownSearch<Province>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item.province ?? ""),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    );
                  },
                ),
                dropdownBuilder: (context, item) =>
                    Text(item?.province ?? "Pilih Provinsi"),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Pilih Provinsi",
                    hintText: "Silahkan Pilih Provinsi",
                  ),
                ),
                asyncItems: (String filter) async {
                  try {
                    var response = await Dio().get(
                      Config.apiUrl + '/province',
                      options: Options(
                        headers: {"key": Config.apiKey},
                      ),
                    );

                    if (response.statusCode == 200) {
                      List<dynamic> jsonList =
                          response.data['rajaongkir']['results'];
                      var provinces = Province.fromJsonList(jsonList);
                      return provinces;
                    } else {
                      print('Failed to load provinces');
                      return [];
                    }
                  } catch (e) {
                    print('Error: $e');
                    return [];
                  }
                },
                onChanged: (Province? data) {
                  controller.provTujuanId.value = data?.provinceId ?? "";
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DropdownSearch<City>(
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item.cityName ?? ""),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    );
                  },
                ),
                dropdownBuilder: (context, item) =>
                    Text(item?.cityName ?? "Pilih Kota"),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Pilih Kota",
                    hintText: "Silahkan Pilih Kota",
                  ),
                ),
                asyncItems: (String filter) async {
                  if (controller.provTujuanId.value.isEmpty) {
                    return []; // Return empty list if province ID is empty
                  }
                  try {
                    var response = await Dio().get(
                      Config.apiUrl +
                          '/city?province=${controller.provTujuanId.value}',
                      options: Options(
                        headers: {"key": Config.apiKey},
                      ),
                    );

                    if (response.statusCode == 200) {
                      List<dynamic> jsonList =
                          response.data['rajaongkir']['results'];
                      var city = City.fromJsonList(jsonList);
                      return city;
                    } else {
                      print('Failed to load city');
                      return [];
                    }
                  } catch (e) {
                    print('Error: $e');
                    return [];
                  }
                },
                onChanged: (City? data) {
                  controller.cityTujuanId.value = data?.cityId ?? "";
                },
              ),
            ),
          ),
          SizedBox(height: 25),
          Center(
            child: Text(
              "Ekspedisi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(color: Colors.black, thickness: 1),
          SizedBox(height: 15),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: DropdownSearch<Map<String, dynamic>>(
                items: [
                  {
                    "code": "jne",
                    "name": "JNE",
                  },
                  {
                    "code": "tiki",
                    "name": "TIKI",
                  },
                  {"code": "pos", "name": "Pos Indonesia"}
                ],
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  itemBuilder: (context, item, isSelected) {
                    return ListTile(
                      title: Text(item["name"] ?? ""),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    );
                  },
                ),
                dropdownBuilder: (context, item) =>
                    Text(item?["name"] ?? "Pilih Ekspedisi"),
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "Pilih Ekspedisi",
                    hintText: "Silahkan Pilih Eskpedisi",
                  ),
                ),
                onChanged: (value) =>
                    controller.eskpedisi.value = value?["code"] ?? "",
              ),
            ),
          ),
          SizedBox(height: 15),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: TextField(
                controller: controller.beratC,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  labelText: "Berat",
                  hintText: "Silahkan Input Berat",
              )
              ),
            ),
          ),
          SizedBox(height: 25),
          Obx(() => FloatingActionButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.cekOngkir();
                  }
                },
                child: controller.isLoading.isFalse
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          Text("Cek Ongkir"),
                        ],
                      )
                    : CircularProgressIndicator(),
              )),
        ],
      ),
    );
  }
}
