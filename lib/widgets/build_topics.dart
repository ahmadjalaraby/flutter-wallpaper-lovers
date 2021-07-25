import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/screens/screens.dart';

class BuildTopics extends StatelessWidget {
  final List<Topic> topics;
  const BuildTopics({
    Key? key,
    required this.topics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 46.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              itemCount: topics.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TopicScreen(
                        topic: topics.elementAt(index),
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 13.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: DynamicTheme.of(context)!.themeId == 2
                                      ? Colors.grey[800]
                                    : Colors.grey[400]!.withAlpha(55),
                      boxShadow: [
                        BoxShadow(
                          color: DynamicTheme.of(context)!.themeId == 2
                                      ? Colors.white12
                                    : Colors.white38,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    //width: 100.0,
                    //height: 30.0,
                    child: Text(topics.elementAt(index).title),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
