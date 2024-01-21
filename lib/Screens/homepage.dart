import 'dart:ffi';
import 'dart:math';

import 'package:dictionary/Controller/datacontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
   Homepage({Key? key}) : super(key: key);
final  DataController dataController = Get.put(DataController());
final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text("Dictionary"),
      ),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => dataController.dictionary.isEmpty?  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
              ),
              const Center(child: CircularProgressIndicator()),
            ],
          ):
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 3
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20)
                    )

                  ),
                  child: Row(
                    children: [

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // Other decoration properties if needed
                            ),
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){
                        if(searchController.text.isEmpty){
                          Get.snackbar("Word cannot be empty", "Invalid Response");
                        }
                        else{
                          debugPrint("search text is ${searchController.text}");
                          dataController.searchedword.clear();
                          dataController.binarySearch(searchController.text);
                          if(dataController.exactsearch.isEmpty){
                            Get.snackbar("Word Not Found", "Please try a different word");
                          }

                        }
                      }, icon: Icon(Icons.search,color: Colors.black,)),
                    ],
                  ),
                ),
              ),
 Obx(() =>            dataController.searchedword.isEmpty&&dataController.exactsearch.isEmpty? dataController.i.value==0? Padding(
   padding:  EdgeInsets.all(8.0),
   child: Column(
     children: [
       SizedBox(
         height: MediaQuery.of(context).size.height*0.2,
       ),
       Center(
           child: Padding(
             padding:  EdgeInsets.only(top: 8.0),
             child: Container(
               decoration: BoxDecoration(
                 border: Border.all(
                     color: Colors.black
                 )
                 ,
                 borderRadius: BorderRadius.all(
                     Radius.circular(21)
                 ),
               ),
               child: ListTile(
                 title: const Center(child: const Text("Did You Know?\n",style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 22
                 ),)),
                 subtitle: Padding(
                   padding: const EdgeInsets.only(top: 8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       RichText(
                         text: TextSpan(
                           children: <TextSpan>[
                             TextSpan(
                               text: '${dataController.dictionary[dataController.random.value]['english']}',
                               style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 color: Colors.red,
                                 fontSize: 20,
                               ),
                             ),
                             TextSpan(
                               text: ' means ${dataController.dictionary[dataController.random.value]['hindi']}\n',
                               style: TextStyle(
                                 color: Colors.grey.shade800,
                                 fontSize: 20,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ],
                         ),
                       ),
                       Center(
                         child: RichText(
                           text: TextSpan(
                             children: <TextSpan>[
                               TextSpan(
                                 text: "Only ",
                                 style: TextStyle(
                                     color: Colors.grey.shade800,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w500
                                 ),
                               ),
                               TextSpan(
                                 text: '${dataController.dictionary[dataController.random.value]['type']}',
                                 style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   color: Colors.red,
                                   fontSize: 20,
                                 ),
                               ),
                               TextSpan(
                                 text: ' students know that!',
                                 style: TextStyle(
                                   color: Colors.grey.shade800,
                                   fontSize: 20,
                                   fontWeight: FontWeight.w500,
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                       // Text("Only ${dataController.dictionary[dataController.random.value]['type']} students know that!",style: TextStyle(
                       //     fontSize: 18,
                       //     fontWeight: FontWeight.w500
                       // ),)
                     ],
                   ),
                 ) ,

                 onTap: (){
                   // Do something when the ListTile is tapped
                 },
               ),
             ),
           )
       ),
     ],
   ),
 ):
 Padding(
   padding:  EdgeInsets.all(8.0),
   child: Column(
     children: [
       SizedBox(
         height: MediaQuery.of(context).size.height*0.2,
       ),
       Center(
           child: Padding(
             padding:  EdgeInsets.only(top: 8.0),
             child: Container(
               decoration: BoxDecoration(
                 border: Border.all(
                     color: Colors.black
                 )
                 ,
                 borderRadius: BorderRadius.all(
                     Radius.circular(21)
                 ),
               ),
               child: ListTile(

                 title:  Padding(
                   padding: const EdgeInsets.only(top: 8.0),
                   child: Column(

                     children: [
                       Text(" Sorry,Word Not Found",style: TextStyle(
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.black.withOpacity(0.6)
                       ),)
                           ],
                   ),
                 ) ,

                 onTap: (){
                   // Do something when the ListTile is tapped
                 },
               ),
             ),
           )
       ),
     ],
   ),
 ):
 Padding(
   padding: const EdgeInsets.all(8.0),
   child: Center(child:Column(
     children: [
       dataController.exactsearch.isEmpty?SizedBox():Column(
         children: [
           Container(
             width: MediaQuery.of(context).size.width*0.7,
             decoration: BoxDecoration(
               color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20)
             ),
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 8),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(top:8.0,left: 35),
                           child: Align(
                             alignment: Alignment.center,
                             child: Text(dataController.exactsearch['english']!,style: TextStyle(
                               fontSize: 18,
                               color: Colors.black,
                               fontWeight: FontWeight.bold
                             ),),
                           ),
                         ),
                       ),
                       IconButton(icon:Icon(Icons.copy,color: Colors.black,), onPressed: () {
                         copyToClipboard("${dataController.exactsearch['english']!} ${convertToHin(dataController.exactsearch['hindi']!)}");
                       },),

                     ],
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Expanded(
                         child: Padding(
                           padding: const EdgeInsets.only(bottom: 8),
                           child: Align(
                             alignment: Alignment.center,
                             child: Text(convertToHin(dataController.exactsearch['hindi']!),style:TextStyle(
                                 fontSize: 16,
                                 color: Colors.black,
                             )),
                           ),
                         ),
                       ),
                     ],
                   ),
                 )
               ],
             ),

           ),
           Padding(
             padding: const EdgeInsets.only(top: 10),
             child: Container(
               width: MediaQuery.of(context).size.width,
               decoration: BoxDecoration(
                   color: Colors.grey.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(20)
               ),
               child: Column(
                 children: [
                    dataController.exactsearch['type']!.isEmpty?SizedBox():InkWell(
                      onTap: (){
                           dataController.secondarysearch(dataController.exactsearch['type']!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0,top:10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text( dataController.exactsearch['type']!,style: TextStyle(
                            fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  //  Padding(
                  //    padding:  const EdgeInsets.only(top:8.0),
                  //    child: Text("${dataController.exactsearch['english']}",style: TextStyle(
                  //        color: Colors.black,
                  //        fontSize: 16
                  //    ),) ,
                  //  ),
                  // const Padding(
                  //    padding: const EdgeInsets.only(top:8.0),
                  //    child: Text("Definition",style: TextStyle(
                  //      color: Colors.black,
                  //      fontSize: 16
                  //    ),),
                  //  ),

                   Padding(
                     padding: const EdgeInsets.all(8),
                     child: Text(convertToHin2(dataController.exactsearch['hindi']!)),
                   )
                 ],
               ),

             ),
           )
         ],
       ),
       SizedBox(height: 30,),
       dataController.searchedword.isEmpty?const SizedBox():Text("${dataController.toshow.value} ->"),
       SizedBox(height: 10,),
       ListView.builder(
         shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dataController.searchedword.length,
              itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                    color: Colors.black
                    )
                        ,
                    borderRadius: BorderRadius.all(
                      Radius.circular(21)
                    ),
                  ),
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${dataController.searchedword[index]['english']}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                              // Other text styles can be added here
                            ),
                          ),
                          TextSpan(
                            text: ' ${dataController.searchedword[index]['type']!.isEmpty ? "" : "(${dataController.searchedword[index]['type']})"}\n${dataController.searchedword[index]['hindi']}',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 17,
                              fontWeight: FontWeight.w500

                              // Add your other styles here
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                    trailing: IconButton(icon:Icon(Icons.copy,color: Colors.black,), onPressed: () {
                        copyToClipboard("${dataController.searchedword[index]['english']!} ${dataController.searchedword[index]['hindi']!}");
                    },),
                    onTap: (){
                      // Do something when the ListTile is tapped
                      print('Tapped on ${dataController.searchedword[index]}');
                    },
                  ),
                ),
              );
              },
          ),
     ],
   ) ),
 ),)
            ],
          )),
        ),
      ),


    );

  }
   String convertToHin(String mean) {
     String result = '';
     RegExp pattern = RegExp(r'(?<=[a-zA-Z0-9])[, -]+(?=[a-zA-Z0-9])'); // Matches , - or spaces between English letters

     String cleanedString = mean.replaceAllMapped(pattern, (match) {
       return ''; // Replace matched characters with an empty string
     });
     RegExp pattern2 = RegExp(r'[^, \-\u0900-\u097F]+'); // Matches characters to be removed

     result = cleanedString.replaceAll(pattern2, '');
     // RegExp hindiPattern = RegExp(r'[^\u0000-\u007F]+');
     //
     // List<String> hindiWords = hindiPattern.allMatches(mean).map((match) {
     //   return match.group(0)!; // Extracting the matched Hindi word
     // }).toList();
     // for(int i = 0;i<hindiWords.length;i++){
     //
     //   result += "${hindiWords[i]}, ";
     // }

     // for (int i = 0; i < mean.length; i++) {
     //   String currentChar = mean[i];
     //
     //   if ((RegExp(r'[a-zA-Z]').hasMatch(currentChar) ||
     //       !RegExp(r'[\u0900-\u097F0-9]').hasMatch(currentChar))&&currentChar!=','&&currentChar!=' ') {
     //     // Remove non-Hindi characters and non-numbers
     //     continue;
     //   } else if (RegExp(r'\d').hasMatch(currentChar)) {
     //     // Replace numbers with newline followed by the number
     //     result += '\n$currentChar';
     //   } else {
     //     // Keep Hindi characters unchanged
     //     result += currentChar;
     //   }
     // }
     result = result.replaceAll(RegExp(r'\s+'), ' ');

     // Remove extra commas between words
     result = result.replaceAll(RegExp(r',+,+'), ',');

     // Remove leading and trailing commas
     result = result.replaceAll(RegExp(r'^,+|,+$'), '');

     // Remove leading and trailing spaces
     result = result.trim();
     result = result.replaceAll(RegExp(r',\s+'), ',');
     result = result.replaceAll(RegExp(r',{2,}'), ',');

     return result;
   }

   String convertToHin2(String mean) {
     StringBuffer buffer = StringBuffer();

    for(int i = 0;i<mean.length-1;i++){
      if(mean[i].contains(RegExp(r'[0-9]'))&&mean[i+1].contains('.')){
        buffer.write('\n');
      }
      buffer.write(mean[i]);
    }
     return buffer.toString();
   }
   void copyToClipboard(String text) {
     Clipboard.setData(ClipboardData(text: text))
         .then((_) => print('Copied to clipboard: $text'))
         .catchError((e) => print('Error copying to clipboard: $e'));
   }




}
