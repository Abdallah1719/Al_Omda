// import 'package:al_omda/core/utils/enum.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
// import 'package:carousel_slider/carousel_slider.dart';

// class HomeSlider extends StatelessWidget {
//   const HomeSlider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state.homeSlidersState == RequestState.loading) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state.homeSlidersState == RequestState.loaded) {
//           final List<HomeSlidersModel> sliders = state.homeSliders;

//           return CarouselSlider(
//             options: CarouselOptions(
//               height: 175.0,
//               viewportFraction: 0.8,
//               autoPlay: true,
//               enlargeCenterPage: false,
//               onPageChanged: (index, reason) {},
//             ),
//             items:
//                 sliders.map<Widget>((item) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20.0),
//                       child: Image.network(
//                         item.image,
//                         width: double.infinity,
//                         height: 174.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           );
//         }

//         if (state.homeSlidersState == RequestState.error) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: Text(state.homeSlidersMessage)),
//           );
//         }

//         return SizedBox.shrink();
//       },
//     );
//   }
// }

import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.homeSlidersState == RequestState.loading) {
          return const HomeSlidersShimmerLoading();
        }

        if (state.homeSlidersState == RequestState.loaded) {
          final List<HomeSlidersModel> sliders = state.homeSliders;

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

        if (state.homeSlidersState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.homeSlidersMessage)),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

class HomeSlidersShimmerLoading extends StatelessWidget {
  const HomeSlidersShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 175.0,
        viewportFraction: 0.8,
        autoPlay: false, // Disable autoPlay for shimmer
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {},
      ),
      items: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const ShimmerWidget.rectangular(
              width: double.infinity,
              height: 174.0,
            ),
          ),
        ),
      ),
    );
  }
}
