// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeSlider extends StatelessWidget {
//   const HomeSlider({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       buildWhen:
//           (previous, current) =>
//               previous.homeSlidersState != current.homeSlidersState,
//       builder: (context, state) {
//         switch (state.homeSlidersState) {
//           case RequestState.loading:
//             return SizedBox(
//               height: 200,
//               child: Center(child: CircularProgressIndicator()),
//             );
//           case RequestState.loaded:
//             return
//             // FadeIn(
//             //   duration: const Duration(milliseconds: 500),
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: 175.0,
//                 viewportFraction: 0.6,
//                 // padEnds: false,
//                 onPageChanged: (index, reason) {},
//               ),
//               items:
//                   state.homeSliders.map((item) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20.0),
//                         child: CachedNetworkImage(
//                           width: 300,
//                           height: 174.0,
//                           imageUrl: item.image,

//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//             );

//           case RequestState.error:
//             return SizedBox(
//               height: 200,
//               child: Center(child: Text(state.homeSlidersMessage)),
//             );
//         }
//       },
//     );
//   }
// }

import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          return const SizedBox.shrink(); // أو عرض شيء افتراضي
        }

        if (state is HomeSildersLodding) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeSildersSucsess) {
          return CarouselSlider(
            options: CarouselOptions(
              height: 175.0,
              viewportFraction: 0.6,
              onPageChanged: (index, reason) {},
            ),
            items:
                state.homeSliders.map<Widget>((HomeSlidersModel item) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        item.image, // ✅ الآن يعمل بشكل صحيح
                        width: 300,
                        height: 174.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
          );
        }

        if (state is HomeSildersFailure) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.errorMassage)),
          );
        }

        return SizedBox.shrink(); // حالة افتراضية
      },
    );
  }
}
