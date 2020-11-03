import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pingna/resources/widgets/forms/submit_button.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/constants.dart';
import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/preloader.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // This video is loaded from assets for demo purposes. It would be better
    // practise to load this video via network in order to cut down on the app
    // size.
    _controller = VideoPlayerController.asset(
      onboardingVideoPath,
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true, // Stop other music from cancelling during playback
      ),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : PreloaderWidget(),
        ),
        PingnaSubmitButton(
          label: 'onboarding.get_started'.tr(),
          onPressed: () => Navigator.of(context).pushNamed(
            postcodeRoute,
            arguments: {
              "show_sign_up_bonus": true,
            },
          ),
          style: PingnaButtonStyle.primary,
        ),
      ],
    );
  }
}
