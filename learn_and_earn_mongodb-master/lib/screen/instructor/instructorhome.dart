import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/instructor/instructorprofile.dart';
import 'package:learn_and_earn_mongodb/screen/instructor/instructorrequests.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/applayout.dart';
import '../../tools/appstate.dart';
import 'instructorclasses.dart';
import 'instructorcourses.dart';

class instructorhome extends StatefulWidget {
  const instructorhome({super.key});

  @override
  State<instructorhome> createState() => _instructorState();
}

class _instructorState extends State<instructorhome> {
  int selectedPos = 0;

  List<TabItem> tabItems = List.of([
    TabItem(
      CupertinoIcons.square_stack_3d_up,
      "Lectures",
      col.wh,
      labelStyle:
          GoogleFonts.roboto(fontWeight: FontWeight.bold, color: col.wh),
    ),
    TabItem(
      Icons.class_outlined,
      "Classes",
      col.wh,
      labelStyle:
          GoogleFonts.roboto(fontWeight: FontWeight.bold, color: col.wh),
    ),
    TabItem(
      Icons.request_page_outlined,
      "Requests",
      col.wh,
      labelStyle:
      GoogleFonts.roboto(fontWeight: FontWeight.bold, color: col.wh),
    ),
  ]);

  late CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: null,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const instructorprofile(),
              ),
            );
          },
          child: Stack(
            children: [
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: provider.prefs.getString('img'),
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    provider.prefs.getString('name'),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [Expanded(child: bodyContainer()), bottomNav()],
        ),
      ),
    );
  }

  Widget bodyContainer() {
    Widget screen = const instructorcourses();
    switch (selectedPos) {
      case 0:
        screen = const instructorcourses();
        break;
      case 1:
        screen = const instructorclasses();
        break;
      case 2:
        screen = const instructorrequest();
        break;
    }

    return SizedBox(
      width: AppLayout.getwidth(context),
      height: AppLayout.getheight(context),
      child: Center(child: screen),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barBackgroundColor: col.pruple,
      selectedIconColor: col.pruple,
      normalIconColor: col.wh,
      animationDuration: const Duration(milliseconds: 700),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
