import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black87,
        highlightColor: Colors.white54,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 50),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 15,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 10,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.black26,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black87,
        highlightColor: Colors.white54,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black87,
        highlightColor: Colors.white54,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * .93,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white70,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height / 1.8,
              width: MediaQuery.of(context).size.width / 1.4,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black87,
        highlightColor: Colors.white70,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                        //margin: EdgeInsets.only(bottom: 10),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[200]!,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                        //margin: EdgeInsets.only(bottom: 10),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white70,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              height: 46.0,
              width: MediaQuery.of(context).size.width - 50,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class LoadingWidget7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.white70,
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30.0, top: 10.0),
              padding: EdgeInsets.only(left: 25.0),
              height: 218.4,
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
