//create the loading Screen 'view' as a Singleton because we want to
//enforce the fact that there should only be one inside our application
import 'dart:async';

import 'package:crosstrack_italia/views/components/loading/loading_screen_controller.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class LoadingScreen {
  LoadingScreen._sharedInstance();

  //two lined of code below are fundamental for having a singleton
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  //the class LoadingScreen is not defined as immutable because it needs
  //to hold a controller
  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = Strings.loading,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    // ignore: unnecessary_null_comparison
    if (state == null) {
      return null;
    }

    final textController = StreamController<String>();
    textController.add(text);

    //need to be careful to collect the correct context, and
    //not some nested one that does not know the correct view size.
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<String>(
                          stream: textController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.requireData,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    //in order to insert the created overlay inside the state
    state.insert(overlay);

    //we are able to control over the entire flow of the loading state,
    //controller, text, screen ...
    //Also lets the Loading Screen Controller be Self-Contained
    return LoadingScreenController(close: () {
      textController.close();
      overlay.remove();
      return true;
    }, update: (text) {
      textController.add(text);
      return true;
    });
    //q: why have all the result to return true in the function above?
    //a: because if the flow of the show() function functions correctly,
    //   i would like the function to return true.
    //   On the other hand if the loadingScreenController is null, we are
    //   we are not able to get the update function (so the result will
    //   not be true). In this case we have to create a new overlay
  }
}
