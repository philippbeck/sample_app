import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:sample_app/core/utils/url_launcher_helper.dart';
import 'package:sample_app/features/list_view/business_logic/cubit/gender_cubit.dart';
import 'package:sample_app/features/list_view/data/enums/gender.dart';
import 'package:sample_app/features/list_view/data/models/item.dart';

/// A widget that displays a slider of items
class ItemSlider extends StatelessWidget {
  /// Default constructor
  const ItemSlider({required this.items, super.key});

  /// The items to display
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenderCubit, Gender?>(
      builder: (context, state) {
        return FlutterCarousel(
          options: FlutterCarouselOptions(
            height: 200.0,
            slideIndicator: CircularSlideIndicator(),
          ),
          items:
              items
                  .where((element) => element.gender == state || state == null)
                  .map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            UrlLauncherHelper.openUrl(url: item.url);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: NetworkImage(item.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                item.headline,
                                style: const TextStyle(
                                  fontSize: 22.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  })
                  .toList(),
        );
      },
    );
  }
}
