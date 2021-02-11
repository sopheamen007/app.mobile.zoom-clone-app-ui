import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/json/home_json.dart';
import 'package:zoom_clone/pages/join_meeting_page.dart';
import 'package:zoom_clone/theme/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activetab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: headerAndFooter,
      appBar: getAppBar(),
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: headerAndFooter,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.settings,
            color: grey,
          ),
          Spacer(),
          Row(
              children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: activetab == index ? grey : grey.withOpacity(0.2)),
              ),
            );
          })),
          Spacer()
        ],
      ),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 200,
      decoration: BoxDecoration(color: headerAndFooter),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (_) => JoinMeetingPage()));
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(builder: (_) => RootApp()));
              },
              child: Container(
                width: size.width * 0.75,
                height: 50,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    "Join a Meeting",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    return CarouselSlider(
        viewportFraction: 0.99,
        height: size.height,
        onPageChanged: (index) {
          setState(() {
            activetab = index;
          });
        },
        items: List.generate(items.length, (index) {
          return Container(
            width: size.width,
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(items[index]['title'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: grey)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(items[index]['description'],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: grey))
                  ],
                ),
                items[index]['img'] == null
                    ? Container()
                    : Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(items[index]['img']))),
                      )
              ],
            ),
          );
        }));
  }
}
