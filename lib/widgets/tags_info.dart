import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';

class TagsInfo extends StatelessWidget {
  final String title;
  final List<Tags> data;

  const TagsInfo({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data != null
        ? Container(
            margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
            decoration: BoxDecoration(
              color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[700]
                            : Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3.0),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 3.0),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        //padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width,
                        height: 50.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          //shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                print(
                                    '${data.elementAt(index).title} Tag Clicked..');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SearchScreen(
                                      query: data.elementAt(index).title,
                                      isPhoto: true,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 6.0),
                                //padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 20.0),
                                width: 100.0,
                                height: 10.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17.0),
                                  color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.grey[600]
                            :  Color.fromRGBO(141, 141, 141, 1.0)
                                      .withAlpha(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: DynamicTheme.of(context)!.themeId == 2
                            ? Colors.white12
                            :  Colors.white54.withOpacity(0.5),
                                      blurRadius: 6.0,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    '${data.elementAt(index).title}',
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : SizedBox.shrink();
  }
}

/*

return data != null
        ? Container(
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: Colors.black12,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                'hello',
                style: const TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
          )
        : SizedBox.shrink();

*/

/* 
Text(
                        data,
                        style: const TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        //softWrap: true,
                      ), */
