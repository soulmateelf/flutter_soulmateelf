import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:soulmate/dataService/model/localChatMessage.dart';
import 'package:soulmate/utils/core/constants.dart';
import 'package:soulmate/utils/core/httputil.dart';
import 'package:soulmate/utils/plugin/plugin.dart';
import 'package:path_provider/path_provider.dart';


class ChatBlubble extends StatefulWidget {
  LocalChatMessage chatData;

  ChatBlubble({super.key, required this.chatData});
  @override
  State<ChatBlubble> createState() => _ChatBlubbleState();
}

class _ChatBlubbleState extends State<ChatBlubble> with AutomaticKeepAliveClientMixin{
  PlayerController controller = PlayerController();
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
    String path = "${appDirectory.path}/${widget.chatData.localChatId}.wav";

    File sourceFile = File(path);
    if (!sourceFile.existsSync() && widget.chatData.voiceUrl != null) {
      await HttpUtils.dio.download("${widget.chatData.voiceUrl}", path);
    }
    controller.preparePlayer(
      path: path!,
      noOfSamples: 200,
    );


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
    super.build(context);
    final isUser = widget.chatData.role == 'user';
    final color = isUser ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.24);

    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.w),
      child: Container(
        width: 348.w,
        height: 66.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 21.w),
        decoration: BoxDecoration(
            color: isUser ? primaryColor : const Color.fromRGBO(239, 239, 239, 1),
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
            const SizedBox(
              width: 10,
            ),
            AudioFileWaveforms(
              size: Size(MediaQuery.of(context).size.width / 2, 70),
              playerController: controller,
              waveformType: false ? WaveformType.fitWidth : WaveformType.long,
              playerWaveStyle: playerWaveStyle,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.chatData.voiceSize!=null?widget.chatData.voiceSize.toString():'0',
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

  @override
  bool get wantKeepAlive => true;
}
