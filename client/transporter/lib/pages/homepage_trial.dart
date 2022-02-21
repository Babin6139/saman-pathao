import 'package:flutter/material.dart';
import 'package:transporter/widgets/colored_tab_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  final imageUrl =
      'https://images.unsplash.com/photo-1566275529824-cca6d008f3da?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8cGhvdG98ZW58MHx8MHx8&w=1000&q=80';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
            automaticallyImplyLeading: false,
            title: Text(
              "Saman Pathao",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
                ),
              )
            ],
            bottom: ColoredTabBar(
              Color(0xFF90B5B7),
              TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(text: "My Bids"),
                  Tab(text: "New Bids"),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(children: [
                  TabBarView(
                    children: [
                      Text("Page1"),
                      Text("Page2"),
                    ],
                  ),
                ]),
                SizedBox(height: 20)
              ],
            ),
          ),
          // body: Column(
          //   children: [
          //     CustomScrollView(
          //       slivers: [
          //         SliverAppBar(
          //           automaticallyImplyLeading: false,
          //           backgroundColor: Color(0xFF399DBC).withOpacity(0.65),
          //           expandedHeight: 50,
          //           floating: true,
          //           pinned: false,
          //           title: Text(
          //             'Saman Pathao',
          //             style: TextStyle(color: Colors.black),
          //           ),
          //           actions: [
          //             GestureDetector(
          //               onTap: () {},
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: CircleAvatar(
          //                     backgroundImage: NetworkImage(imageUrl)),
          //               ),
          //             )
          //           ],
          //           bottom: TabBar(tabs: [Tab(text: "My Bids")]),
          //         )
          //       ],
          //     ),
          //     TabBarView(
          //       controller: _tabController,
          //       children:
          //       [

          //       ]
          //     )
          //   ],
          // ),
        ),
      ),
    );
  }
}
