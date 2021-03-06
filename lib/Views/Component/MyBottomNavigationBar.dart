import 'package:events_app/Controllers/CurrentPageController.dart';
import 'package:flutter/material.dart';
import '../../Controllers/CurrentPageController.dart';
import 'package:provider/provider.dart';



class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({
    @required this.height,
    @required this.width,
  });

  final double height;
  final double width;

  final int tranDuration = 200;

  final Color notSelectedColor = Colors.blue.withOpacity(.5);
  final Color selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height * 0.91,
      left: 0,
      child: Container(
        height: height * .09,
        width: width,
        color: Colors.white,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  Provider.of<CurrentPageContoller>(context,listen: false).pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: tranDuration),
                    curve: Curves.easeInOut,
                  );
                },
                  child: Icon(
                Icons.home,
                size: height * .045,
                color: Provider.of<CurrentPageContoller>(context,).pageNumber == 0 ? selectedColor : notSelectedColor
              )),
              GestureDetector(
                onTap: (){
                  Provider.of<CurrentPageContoller>(context,listen: false).pageController.animateToPage(
                    1,
                    duration: Duration(milliseconds: tranDuration),
                    curve: Curves.easeInOut,
                  );
                },
                child: Icon(
                  Icons.pets,
                  size: height * .045,
                    color: Provider.of<CurrentPageContoller>(context,).pageNumber == 1 ? selectedColor : notSelectedColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
