// import 'package:al_omda/features/home/data/models/home_sliders_model.dart';
// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class HomeSlider extends StatelessWidget {
//   const HomeSlider({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         if (state is HomeInitial) {
//           return const SizedBox.shrink(); // أو عرض شيء افتراضي
//         }

//         if (state is HomeSildersLodding) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }

//         if (state is HomeSildersSucsess) {
//           return CarouselSlider(
//             options: CarouselOptions(
//               height: 175.0,
//               viewportFraction: 0.6,
//               onPageChanged: (index, reason) {},
//             ),
//             items:
//                 state.homeSliders.map<Widget>((HomeSlidersModel item) {
//                   return Padding(
//                     padding: const EdgeInsets.only(right: 10),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20.0),
//                       child: Image.network(
//                         item.image, // ✅ الآن يعمل بشكل صحيح
//                         width: 300,
//                         height: 174.0,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           );
//         }

//         if (state is HomeSildersFailure) {
//           return SizedBox(
//             height: 200,
//             child: Center(child: Text(state.errorMassage)),
//           );
//         }

//         return SizedBox.shrink(); // حالة افتراضية
//       },
//     );
//   }
// }

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
        // 👇 حالة التحميل
        if (state.homeSlidersState == RequestState.loading) {
          return SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // 👇 حالة النجاح
        if (state.homeSlidersState == RequestState.loaded) {
          final List<HomeSlidersModel> sliders = state.homeSliders;

          return CarouselSlider(
            options: CarouselOptions(
              height: 175.0,
              viewportFraction: 0.6,
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
                        width: 300,
                        height: 174.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
          );
        }

        // 👇 حالة الخطأ
        if (state.homeSlidersState == RequestState.error) {
          return SizedBox(
            height: 200,
            child: Center(child: Text(state.homeSlidersMessage)),
          );
        }

        // 👇 حالة افتراضية (مثلاً initial)
        return SizedBox.shrink();
      },
    );
  }
}
