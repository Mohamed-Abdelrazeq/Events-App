import 'package:events_app/Controllers/ImagePickerController.dart';
import 'package:events_app/Controllers/LocationController.dart';
import 'package:events_app/Controllers/UserInfoController.dart';
import 'package:events_app/Model/EventModel.dart';
import 'package:events_app/Services/ImageStorage.dart';
import 'package:events_app/Views/Component/MyFlushBar.dart';
import 'package:events_app/Views/Component/MyTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'PleaseLogin.dart';



class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();

}

class _AddEventScreenState extends State<AddEventScreen> {
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  DateTime _eventDate =  DateTime.now();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Provider.of<UserInfoController>(context).username != null ? GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Stack(
          children:[
            Container(
              padding: EdgeInsets.only(
                  left: width * .05,right: width * .05),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: height*.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Add Event',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: height * .05,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .2),
                    child: Divider(
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),

                  Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .04,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  MyTextField(
                    myColor: Colors.blue,
                    myController: _titleController,
                    height: height,
                    width: width,
                    myWidth: .8,
                    myHeight: .1,
                    hint: 'Event Title',
                  ),
                  SizedBox(
                    height: height * .02,
                  ),

                  Text(
                    'About',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .04,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .02)),
                    child: Center(
                      child: TextField(
                        controller: _summaryController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                        cursorColor: Colors.black87,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'About Your Event',
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 30, top: 30, right: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),

                  Text(
                    'Date',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .04,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime.now(),
                          maxTime: DateTime(2030, 1, 1), onChanged: (date) {
                        setState(() {
                          _eventDate = date;
                        });
                          }, onConfirm: (date) {
                          }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Container(
                      width: width,
                      height: height*.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text(
                          _eventDate.toString().substring(0,10),
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),),
                  SizedBox(
                    height: height * .02,
                  ),

                  Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .04,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/MyMapPicker');
                    },
                    child: Container(
                      width: width,
                      height: height*.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text(Provider.of<LocationController>(context).getSelectionBool == true ? 'Place Picked' : 'Pick Place',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),),
                  SizedBox(
                    height: height * .02,
                  ),

                  Text(
                    'Poster',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: height * .04,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  TextButton(
                    onPressed: () async {
                      await Provider.of<ImagePickerController>(context,listen: false).getImage();
                    },
                    child: Container(
                      width: width,
                      height: height*.1,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(
                        child: Text(
                          Provider.of<ImagePickerController>(context).image == null ? 'Pick Poster' : 'Image Selected',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),),
                  SizedBox(
                    height: height * .16,
                  ),
                ],
              ),
            ),
            Positioned(
              top: height*.87,
              width: width,
              child: TextButton(
                onPressed: () async {

                  MyFlushBar().show(context, 'Please Wait');
                  await ImageStorage().uploadFile(Provider.of<ImagePickerController>(context,listen: false).image,_titleController.text.trim());
                  await Provider.of<ImageStorage>(context,listen: false).downloadURL(_titleController.text.trim());
                  await EventModel(
                      title: _titleController.text,
                      about: _summaryController.text,
                      date: _eventDate,
                      organizer: Provider.of<UserInfoController>(context,listen: false).username,
                      location: Provider.of<LocationController>(context,listen: false).getPartyLocationName,
                      xAxis: Provider.of<LocationController>(context,listen: false).getSelectedPartyLocationXAxis,
                      yAxis:  Provider.of<LocationController>(context,listen: false).getSelectedPartyLocationYAxis,
                      posterUrl: Provider.of<ImageStorage>(context,listen: false).getDownloadURL,
                  ).addEvent();
                  Navigator.pop(context);

                },
                child: Container(
                  width: width*.8,
                  height: height*.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text(
                      'Add Event',
                      style: TextStyle(color: Colors.blue,fontSize: height*.03),
                    ),
                  ),
                ),),
            ),
          ],
        ),
      ),
    ) : PleaseLogin(width: width, height: height);
  }
}

