import 'package:fazakir/Features/about_religion/domain/data/repos/video_youtube_repo_impl.dart';
import 'package:fazakir/Features/about_religion/presentation/manager/cubits/manage_about_religion_cubit/manage_about_religion_cubit.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/prayer_times_cubit/prayer_times_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrayerTimesCubit()..initPrayerTime(),
        ),
        BlocProvider(
          create: (context) => ManageAboutReligionCubit(
            VideoYoutubeRepoImpl(),
          )..fetchVideos(),
        ),
      ],
      child: const HomeViewBody(),
    );
  }
}
