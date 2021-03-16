import 'package:bellbirdmvp/Providers/customs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditingScren extends StatefulWidget {
  @override
  _EditingScrenState createState() => _EditingScrenState();
}

class _EditingScrenState extends State<EditingScren> {
  @override
  Widget build(BuildContext context) {
    final serviceData = Provider.of<Customs>(context);

    final pieces = serviceData.items;

    var xgroup = serviceData.xGroupvalue;
    var xhandler = serviceData.changeHandler;

    double padding = 3;
    double elevation = 7;
    return DefaultTabController(
        length: 6,
        child: Scaffold(
//                appBar: AppBar(
//                  title: Text(title),
//                ),
            body: SafeArea(
                child: Column(children: <Widget>[
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height /
                1.8, // Also Including Tab-bar height.
//                        chContainer(

            child: ListView(children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: GestureDetector(
                          child: Container(
                              child: Material(
                                  elevation: elevation,
                                  child: Image.asset(
                                      'assets/parts/shldr right.png')),
                              padding: EdgeInsets.all(padding)))),
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset(
                          'assets/parts/nck.png',
                        )),
                    padding: EdgeInsets.all(padding),
                  )),
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset('assets/parts/shldr left.png')),
                    padding: EdgeInsets.all(padding),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Material(
                          elevation: elevation,
                          child: Image.asset(
                            'assets/parts/slve right.png',
                          )),
                      padding: EdgeInsets.all(padding),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset('assets/parts/bttm.png')),
                    padding: EdgeInsets.all(padding),
                  )),
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset('assets/parts/slve left.png')),
                    padding: EdgeInsets.all(padding),
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset(
                          'assets/parts/chq right.png',
                          fit: BoxFit.fill,
                        )),
                    padding: EdgeInsets.all(padding),
                  )),
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset(
                          'assets/parts/dmn.png',
                          fit: BoxFit.fill,
                        )),
                    padding: EdgeInsets.all(padding),
                  )),
                  Expanded(
                      child: Container(
                    child: Material(
                        elevation: elevation,
                        child: Image.asset(
                          'assets/parts/chq left.png',
                          fit: BoxFit.fill,
                        )),
                    padding: EdgeInsets.all(padding),
                  )),
                ],
              ),
            ]),
          )
//                          controller: _chewieController,
//                        ),
          ,
          Container(
            height: 37,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(7.0),
            ),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                new Tab(
                    child: Text(
                  "FEATURED",
                  style: TextStyle(fontFamily: 'Graphik'),
                )),
                new Tab(
                    child: Text(
                  "MEN",
                  style: TextStyle(fontFamily: 'Graphik'),
                )),
                new Tab(
                    child: Text(
                  "SHOWCASE",
                  style: TextStyle(fontFamily: 'Graphik'),
                )),
                new Tab(
                    child: Text(
                  "WOMEN",
                  style: TextStyle(fontFamily: 'Graphik'),
                )),
                new Tab(
                    child: Text(
                  "COMING SOON",
                  style: TextStyle(fontFamily: 'Graphik'),
                )),
                new Tab(
                    child: Text(
                  "KIDS",
                  style: TextStyle(fontFamily: 'Graphik'),
                )),
              ],
              indicatorColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          //TabBarView(children: [ImageList(),])
          Expanded(
            child: TabBarView(
              children: [
                GridView.builder(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10.0),
                  itemCount: pieces.length,
                  itemBuilder: (ctx, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GridTile(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              xhandler(pieces[i].value);

                              print(xgroup);
                            });
                          },
                          child: Image.asset(
                            pieces[i].imageUrl,
                            fit: BoxFit.contain,
                          )),
                      footer: Radio(
                        onChanged: (v) {
                          setState(() {
                            xhandler(v);

                            print(xgroup);
                          });

                          print(xgroup);
                        },
                        groupValue: xgroup,
                        value: pieces[i].value,
                      ),
                    ),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                ),
                Container(
                  color: Colors.red,
                  child: Center(child: Text('Tab2')),
                ),
                Container(
                  color: Colors.yellowAccent,
                  child: Center(child: Text('Tab3')),
                ),
                Container(
                  color: Colors.deepOrange,
                  child: Center(child: Text('Tab1')),
                ),
                Container(
                  color: Colors.red,
                  child: Center(child: Text('Tab2')),
                ),
                Container(
                  color: Colors.yellowAccent,
                  child: Center(child: Text('Tab3')),
                ) // class name
              ],
            ),
          ),
        ]))));
  }
}
