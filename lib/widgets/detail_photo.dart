import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/models.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class DetailPhoto extends StatelessWidget {
  final Photo photo;

  const DetailPhoto({
    Key? key,
    required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          DynamicTheme.of(context)!.themeId == 2 ? Colors.grey[800] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width / 3.8,
              height: 7.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: DynamicTheme.of(context)!.themeId == 2
                    ? Colors.grey[850]
                    : Colors.black26.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          /* Divider(
                thickness: 1.0,
                height: 2.0,
                color: Colors.amber,
              ), */
          UserDetailPhoto(photo: photo),
          //SizedBox(height: 5.0),
          DescriptionInfo(title: 'Description:', data: photo.description),
          DescriptionInfo(title: 'AltDescription:', data: photo.altDescription),
          photo.tags != null
              ? TagsInfo(title: 'Tags:', data: photo.tags)
              : SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DetailInfoItem(
                icon: Icons.info,
                title: 'Wallpaper ID:',
                data: photo.id,
                onTap: () => print('id clicked..'),
              ),
              DetailInfoItem(
                icon: Icons.photo_size_select_actual_outlined,
                title: 'Dimensions',
                data: '${photo.width} X ${photo.height}',
                onTap: () => print('width and height clicked..'),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DetailInfoItem(
                icon: Icons.create_rounded,
                title: 'Created At:',
                data: photo.createdAt,
                onTap: () => print('created at clicked..'),
              ),
              DetailInfoItem(
                icon: Icons.update_outlined,
                title: 'Updated At:',
                data: photo.updatedAt,
                onTap: () => print('updated at clicked..'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              DetailInfoItem(
                icon: Icons.favorite_outline,
                title: 'Likes:',
                data: '${photo.likes}',
                onTap: () => print('likes clicked..'),
              ),
              DetailInfoItem(
                icon: Icons.download_outlined,
                title: 'Downloads:',
                data: '${photo.downloads}',
                onTap: () => print('downloads clicked..'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
