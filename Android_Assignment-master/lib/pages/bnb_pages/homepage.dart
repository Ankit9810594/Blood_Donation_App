import 'package:blood_donation/pages/blood_group/a_negative.dart';
import 'package:blood_donation/pages/blood_group/a_positive.dart';
import 'package:blood_donation/pages/blood_group/ab_negative.dart';
import 'package:blood_donation/pages/blood_group/ab_positive.dart';
import 'package:blood_donation/pages/blood_group/b_negative.dart';
import 'package:blood_donation/pages/blood_group/b_positive.dart';
import 'package:blood_donation/pages/blood_group/o_negative.dart';
import 'package:blood_donation/pages/blood_group/o_positive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sliderBanner(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            " Blood Group",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          bloodGroups(context),
          const SizedBox(
            height: 5,
          ),
          tabBarView()
        ],
      ),
    );
  }

  Expanded tabBarView() {
    return Expanded(
        child: TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _tabController,
      children: const [
        APositive(),
        OPositive(),
        BPositive(),
        ABPositive(),
        ANegative(),
        ONegative(),
        BNegative(),
        ABNegative(),
      ],
    ));
  }

  Container bloodGroups(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        // isScrollable: true,
        labelPadding: const EdgeInsets.symmetric(horizontal: 3.0),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.all(2),
        indicator: ShapeDecoration(
            color: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0))),
        unselectedLabelColor: Colors.black87,
        labelColor: Colors.white,
        labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        tabs: const [
          Tab(
            text: "A+",
          ),
          Tab(
            text: "O+",
          ),
          Tab(
            text: "B+",
          ),
          Tab(
            text: "AB+",
          ),
          Tab(
            text: "A-",
          ),
          Tab(
            text: "O-",
          ),
          Tab(
            text: "B-",
          ),
          Tab(
            text: "AB-",
          ),
        ],
      ),
    );
  }

  Widget sliderBanner() {
    return SizedBox(
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  height: 180,
                  autoPlayInterval: const Duration(seconds: 5),
                  enlargeCenterPage: false,
                  autoPlayAnimationDuration: const Duration(milliseconds: 500),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return GestureDetector(
                      onTap: () {},
                      child: SizedBox(
                          width: double.maxFinite,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              "assets/images/banner${index}.png",
                              fit: BoxFit.cover,
                            ),
                          )));
                },
                itemCount: 3),
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 2.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      shape: BoxShape.circle,
                      color: _currentIndex == index
                          ? Color.fromARGB(255, 36, 83, 170)
                          : Colors.transparent,
                    ),
                  );
                },
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
