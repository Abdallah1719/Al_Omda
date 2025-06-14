import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:al_omda/features/home/presentation/widgets/homeSlider_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/data/models/home_slider_items_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.homeSliderItemsState == RequestState.loading) {
          return const HomeSliderShimmerLoading();
        }
        if (state.homeSliderItemsState == RequestState.loaded) {
          final List<HomeSliderItemsModel> sliders = state.homeSliderItems;

          return CarouselSlider(
            options: CarouselOptions(
              height: 175.0,
              viewportFraction: 0.8,
              autoPlay: true,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {},
            ),
            items:
                sliders.map<Widget>((item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        item.image,
                        width: double.infinity,
                        height: 174.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
          );
        }
        if (state.homeSliderItemsState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.homeSliderItemsMessage)),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
