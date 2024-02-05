import 'package:flutter/material.dart';

import '../../widgets/drawer_widget.dart';
import '../../widgets/linear_color.dart';


class RemoveAdsScreen extends StatelessWidget {
   RemoveAdsScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          iconSize: 40,
          color: Colors.white,
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
              ),
              const Text(
                "Remove ads",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,
      drawer: const DrawerWidget(),
      body: Container(
        decoration: buildContainerDecoration(),
        child: SafeArea(
            child: Center(
              child: Container(
                width: 350,
                height: 259,
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.asset("assets/images/SVGRepo_iconCarrier (3).png",
                                width: 61,
                                height: 61,),
                              Text("Remove ads")
                            ],
                          ),
                          Text("Rs: 350.00")
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Image.asset("assets/images/SVGRepo_iconCarrier (4).png",
                          width: 35,
                          height: 53.26,),
                          Text("Postpaid Bill"),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                    backgroundColor:  Colors.black54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                                )
                                ,child: Text("Continue",
                              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white
                              ),)),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
