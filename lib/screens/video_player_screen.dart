import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String? notesUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl, required this.title, this.notesUrl});
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
    _controller = YoutubePlayerController(initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(children: [
        YoutubePlayer(controller: _controller, showVideoProgressIndicator: true),
        if (widget.notesUrl != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Download Notes PDF'),
              onPressed: () => launchUrl(Uri.parse(widget.notesUrl!)),
            ),
          ),
      ]),
    );
  }
}
