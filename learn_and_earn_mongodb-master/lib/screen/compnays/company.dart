import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/companycourse.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/companyjob.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/companyprofile.dart';
import 'package:learn_and_earn_mongodb/screen/compnays/courses/companyaddcourse.dart';
import 'package:learn_and_earn_mongodb/tools/applayout.dart';
import 'package:learn_and_earn_mongodb/tools/col.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../tools/appstate.dart';
import '../account/login.dart';

class company extends StatefulWidget {
  const company({super.key});

  @override
  State<company> createState() => _companyState();
}

class _companyState extends State<company> {
  int selectedPos = 0;

  List<TabItem> tabItems = List.of([
    TabItem(
      Icons.cases_outlined,
      "Jobs",
      col.wh,
      labelStyle:
          GoogleFonts.roboto(fontWeight: FontWeight.bold, color: col.wh),
    ),
    TabItem(
      CupertinoIcons.square_stack_3d_up,
      "Courses",
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: null,
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: const companyprofile(),
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
    Widget screen = const companyjobs();
    switch (selectedPos) {
      case 0:
        screen = const companyjobs();
        break;
      case 1:
        screen = const companycourse();
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
