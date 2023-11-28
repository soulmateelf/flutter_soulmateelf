import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:path_provider/path_provider.dart';

import '../../../models/chat.dart';

class ChatBlubble extends StatefulWidget {
  ChatHistory chatData;

  ChatBlubble({super.key, required this.chatData});

  @override
  State<ChatBlubble> createState() => _ChatBlubbleState();
}

class _ChatBlubbleState extends State<ChatBlubble> {
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;
  bool isPlaying = false;

  final playerWaveStyle = const PlayerWaveStyle(
    fixedWaveColor: Colors.white54,
    liveWaveColor: Colors.white,
    spacing: 6,
  );

  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();
    playerStateSubscription = controller.onPlayerStateChanged.listen((_) {
      if (controller.playerState == PlayerState.playing) {
        isPlaying = true;
      } else {
        isPlaying = false;
      }
      setState(() {});
    });
  }

  void _preparePlayer() async {
    // Prepare player with extracting waveform if index is even.

    final appDirectory = await getApplicationDocumentsDirectory();
    String path = "${appDirectory.path}/${widget.chatData.chatId}.wav";
    await HttpUtils.dio.download("${widget.chatData.voiceUrl}",path);

    controller.preparePlayer(
      path: path!,
    );

    controller
        .extractWaveformData(
          path: path!,
          noOfSamples: playerWaveStyle.getSamplesForWidth(200),
        )
        .then((waveformData) => debugPrint(waveformData.toString()));
  }

  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  void playOrPause() async {
    try {
      if (isPlaying) {
        await controller.pausePlayer();
      } else {
        await controller.startPlayer(
            finishMode: FinishMode.pause, forceRefresh: false);
      }
    } catch (err) {
      APPPlugin.logger.e(err.toString());
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.chatData.role == 'user';
    final color = isUser ? Colors.white : Color.fromRGBO(0, 0, 0, 0.24);

    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.w),
      child: Container(
        width: 348.w,
        height: 76.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 26.w),
        decoration: BoxDecoration(
            color: isUser ? primaryColor : Color.fromRGBO(239, 239, 239, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
              bottomLeft: isUser ? Radius.circular(borderRadius) : Radius.zero,
              bottomRight: isUser ? Radius.zero : Radius.circular(borderRadius),
            )),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                playOrPause();
              },
              child: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: color,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width / 2, 70),
              playerController: controller,
              waveformType: false ? WaveformType.fitWidth : WaveformType.long,
              playerWaveStyle: playerWaveStyle,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "${controller.maxDuration}",
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontFamily: FontFamily.SFProRoundedMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
