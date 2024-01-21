import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    debugPrint("hello");
    if(dictionary.isEmpty){
      readTsvFromAssets();
    }


  }

  RxString toshow = "".obs;
  RxInt random = ( Random().nextInt(120000)).obs;
  RxInt i = 0.obs;
  RxList<Map<String, String>> dictionary = RxList<Map<String, String>>();

  RxList<Map<String, String>> searchedword = RxList<Map<String, String>>();
  RxMap<String,String> exactsearch = RxMap<String,String>();
  Future<List<Map<String,String>>> readTsvFromAssets() async {
    await Future.delayed(Duration(seconds: 3));
    String fileContent = await rootBundle.loadString('assets/english_to_hindi.tsv');
    List<List<dynamic>> csvTable = CsvToListConverter(fieldDelimiter: '\t').convert(fileContent);

    List<String> headers = csvTable[0].map((header) => header.toString()).toList();

    // Remove the first row (headers) to work only with data rows


    // Map each row to a Map with column headers as keys and row values as values
    List<Map<String,String>> data = [];
    for(int i = 1;i<csvTable.length;i++){
      Map<String,String> rowdata = {};
      rowdata[headers[0]] = csvTable[i][0];
      rowdata[headers[1]] = "";
      rowdata[headers[2]] = "";
      if(csvTable[i].length>1){
        rowdata[headers[1]] = csvTable[i][1];
        rowdata[headers[2]] = csvTable[i][2];
      }


      data.add(rowdata);


    }
    debugPrint("size of list is ${data.length}");
    dictionary.value = data;
    while(dictionary[random.value]['type']==""){
      random.value = Random().nextInt(120000);
    }


    update();
    return data;
  }
  void binarySearch(String searchText) {
    toshow.value = "Did you mean";
 searchText = searchText.trim();
searchText = searchText.replaceAll(RegExp(r'\s+'), ' ');
debugPrint("word is word is ${searchText}");
 i.value = 1;
 exactsearch.clear();
for (int i = 0;i<dictionary.length;i++) {
  // debugPrint(a.toString());
  if(dictionary[i]['english'] != null){
    if (dictionary[i]['english']!.toLowerCase() == searchText.toLowerCase()) {
      exactsearch['english'] = dictionary[i]['english']!;
      exactsearch['type'] = dictionary[i]['type']!;
      exactsearch['hindi'] = dictionary[i]['hindi']!;
    }

    if (dictionary[i]['english']!.toLowerCase().contains(searchText.toLowerCase()) &&
        searchedword.length < 12 &&
        dictionary[i]['english']!.toLowerCase() != searchText.toLowerCase()) {
      searchedword.add(dictionary[i]);
      update();
    }
  }
  else{
    debugPrint("hello"+dictionary[i].toString());
  }

}

    debugPrint("${searchedword.length} this is ");
    // Not found
  }

  void secondarysearch(String s) {
    toshow.value = "$s words";
    searchedword.clear();
    int i =  Random().nextInt(100000);
    for ( i ;i<dictionary.length;i++) {

      // debugPrint(a.toString());
      if(dictionary[i]['type']!.toLowerCase()==s.toLowerCase()){
        searchedword.add(dictionary[i]);
        if(searchedword.length>=100){
          break;
        }
      }

    }


  }


}
