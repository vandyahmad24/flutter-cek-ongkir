import 'package:cek_ongkir/app/config/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController {
  RxString provAsalId="".obs;
  RxString cityAsalId="".obs;
  RxString provTujuanId="".obs;
  RxString cityTujuanId="".obs;
  RxString eskpedisi="".obs;
  RxBool isLoading=false.obs;
  TextEditingController beratC= TextEditingController(text: "0");

void cekOngkir() async{
  if(provAsalId.value.isNotEmpty && cityAsalId.value.isNotEmpty && provTujuanId.value.isNotEmpty && cityTujuanId.value.isNotEmpty && eskpedisi.value.isNotEmpty){
   try{
    isLoading.value=true;
    print(isLoading.value);
    print("start cek ongkir");
    var response = await Dio().post(
      "https://api.rajaongkir.com/starter/cost",
      data: {
        "origin": cityAsalId.value,
        "destination": cityTujuanId.value,
        "weight": int.parse(beratC.text),
        "courier":eskpedisi.value
      },
      options: Options(
        headers: {
          "key": Config.apiKey,
          "content-type": "application/x-www-form-urlencoded",
        }
      )
     );
     print(response);
     isLoading.value=false;
   }catch(e){
      print(e);
     Get.dialog(
       AlertDialog(
         title: Text("Error"),
         content: Text("Terdapat Kesalahan"),
       ),
     );
     isLoading.value=false;
     return;
   }


  }else{
    Get.dialog(
      AlertDialog(
        title: Text("Error"),
        content: Text("Data tidak boleh kosong"),
      ),
    );
    return;
  }
}

}
