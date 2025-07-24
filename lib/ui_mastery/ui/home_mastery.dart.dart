import 'package:flutter/material.dart';

class HomeMasteryDart extends StatefulWidget {
  const HomeMasteryDart({Key? key}) : super(key: key);

  @override
  _HomeMasteryDartState createState() => _HomeMasteryDartState();
}

class _HomeMasteryDartState extends State<HomeMasteryDart>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  PageController pageController = PageController(initialPage: 0);

  List<Widget> _widgts = [
    Container(width: 60, height: 30, color: Colors.amber),
    Container(width: 60, height: 30, color: Colors.blue),
    Container(width: 60, height: 30, color: Colors.black),
  ];
  @override
  void initState() {
    setState(() {
      tabController = TabController(length: 3, vsync: this);
    });
    super.initState();
  }

  final List<String> _imageAssets = const [
    'assets/images/snack-2635035.jpg',
    'assets/images/imagem3.jpg',
    'assets/images/imagem2.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: TabBar(
            controller: tabController,
            tabs: [
              Tab(child: Text("home")),
              Tab(child: Text("settings")),
              Tab(child: Text("profile")),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(color: Colors.amber),
            child: TabBarView(
              controller: tabController,
              children: [
                Container(height: 120, color: Colors.amber),
                Container(height: 120, color: Colors.green),
                Container(height: 120, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 400,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(18),
              width: MediaQuery.of(context).size.width,
              height: 140,
              child: PageView.builder(
                itemCount: _widgts.length,
                itemBuilder: (context, index) {
                  return _widgts[index];
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
              margin: EdgeInsets.all(16),
              height: 60,
              child: TabPageSelector(
                controller: tabController,
                selectedColor: Colors.white,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
