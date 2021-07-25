import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/screens/screens.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

bool isSwitched1 = false, isSwitched2 = true;
bool isSwitched3 = false, isSwitched4 = false;
bool isSwitched5 = false, isSwitched6 = true;

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: DynamicTheme.of(context)!.themeId == 2
          ? Colors.grey[850]
          : Colors.white,
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "Settings",
                style: TextStyle(
                  color: DynamicTheme.of(context)!.themeId == 2
                      ? Colors.white
                      : Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Text("Select Language",
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                    Text("English, US",
                        style: TextStyle(color: Colors.blue, fontSize: 15.0)),
                    Container(width: 10)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                setState(() {
                  isSwitched1 = !isSwitched1;
                  if (isSwitched1) {
                    DynamicTheme.of(context)!.setTheme(AppThemes.Dark);
                  } else {
                    DynamicTheme.of(context)!.setTheme(AppThemes.LightBlue);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Dark Mode",
                            style: TextStyle(
                                color: DynamicTheme.of(context)!.themeId == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Switch(
                          value: isSwitched1,
                          onChanged: (value) {
                            setState(() {
                              isSwitched1 = value;
                              if (isSwitched1) {
                                DynamicTheme.of(context)!
                                    .setTheme(AppThemes.Dark);
                              } else {
                                DynamicTheme.of(context)!
                                    .setTheme(AppThemes.LightBlue);
                              }

                              print(value);
                            });
                          },
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.grey,
                        )
                      ],
                    ),
                    Text(
                        'The design reduces the light emitted by device screens while maintaining the minimum color contrast ratios required for readability.',
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[300]
                                : Colors.grey[700])),
                    Container(height: 15)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                setState(() {
                  isSwitched2 = !isSwitched2;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("App Sound",
                            style: TextStyle(
                                color: DynamicTheme.of(context)!.themeId == 2
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                        Spacer(),
                        Switch(
                          value: isSwitched2,
                          onChanged: (value) {
                            setState(() {
                              isSwitched2 = value;
                            });
                          },
                          activeColor: Colors.blue,
                          inactiveThumbColor: Colors.grey,
                        )
                      ],
                    ),
                    Text(
                        "Sound Effects during using the app, like tap sound etc. ",
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[300]
                                : Colors.grey[700])),
                    Container(height: 15)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            Container(height: 25),
            Container(
              child: Text("Push Notification",
                  style: TextStyle(
                      color: DynamicTheme.of(context)!.themeId == 2
                          ? Colors.white
                          : Colors.black,
                      //color: Colors.grey[900],
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSwitched3 = !isSwitched3;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("Recommended photos",
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[200]
                                : Colors.grey[800])),
                    Spacer(),
                    Switch(
                      value: isSwitched3,
                      onChanged: (value) {
                        setState(() {
                          isSwitched3 = value;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                setState(() {
                  isSwitched4 = !isSwitched4;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("Recommended collections",
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[200]
                                : Colors.grey[800])),
                    Spacer(),
                    Switch(
                      value: isSwitched4,
                      onChanged: (value) {
                        setState(() {
                          isSwitched4 = value;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                setState(() {
                  isSwitched5 = !isSwitched5;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("New feautres",
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[200]
                                : Colors.grey[800])),
                    Spacer(),
                    Switch(
                      value: isSwitched5,
                      onChanged: (value) {
                        setState(() {
                          isSwitched5 = value;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                setState(() {
                  isSwitched6 = !isSwitched6;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: <Widget>[
                    Text("New updates",
                        style: TextStyle(
                            color: DynamicTheme.of(context)!.themeId == 2
                                ? Colors.grey[200]
                                : Colors.grey[800])),
                    Spacer(),
                    Switch(
                      value: isSwitched6,
                      onChanged: (value) {
                        setState(() {
                          isSwitched6 = value;
                        });
                      },
                      activeColor: Colors.blue,
                      inactiveThumbColor: Colors.grey,
                    )
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            Container(height: 25),
            Container(
              child: Text("More",
                  style: TextStyle(
                      color: DynamicTheme.of(context)!.themeId == 2
                          ? Colors.white
                          : Colors.black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text("Ask a Question",
                    style: TextStyle(
                        color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[200]
                            : Colors.grey[800])),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text("F A Q",
                    style: TextStyle(
                        color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[200]
                            : Colors.grey[800])),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Text("Privacy Policy",
                    style: TextStyle(
                        color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[200]
                            : Colors.grey[800])),
              ),
            ),
            Divider(height: 0),
            Container(height: 15),
          ],
        ),
      ),
    );
  }
}
