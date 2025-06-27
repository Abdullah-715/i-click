import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/short_users_cubit/short_users_cubit.dart';
import '../resources/enum_manger.dart';
import '../resources/styles.dart';
import '../widgets/story/short_user_profile.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_image.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Indicates where the progress indicators should be placed.
enum ProgressPosition { top, bottom, none }

enum IndicatorHeight { small, medium, large }

class StoryItem {
  final Duration duration;
  bool shown;

  //? This for bottom :
  final Widget? bottom;

  /// The page content
  final Widget view;

  final List<String> ids;
  StoryItem(
    this.view, {
    required this.ids,
    this.bottom,
    required this.duration,
    this.shown = false,
  });

  factory StoryItem.pageImage({
    required String url,
    required StoryController controller,
    Key? key,
    BoxFit imageFit = BoxFit.fitWidth,
    Widget? caption,
    required List<String> ids,
    bool shown = false,
    Map<String, dynamic>? requestHeaders,
    Widget? loadingWidget,
    Widget? errorWidget,
    EdgeInsetsGeometry? captionOuterPadding,
    Duration? duration,
    Widget? bottom,
  }) {
    return StoryItem(
        Container(
          key: key,
          color: Colors.black,
          child: Stack(
            children: <Widget>[
              StoryImage.url(
                url,
                controller: controller,
                fit: imageFit,
                requestHeaders: requestHeaders,
                loadingWidget: loadingWidget,
                errorWidget: errorWidget,
              ),
              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                      bottom: 24,
                    ),
                    padding: captionOuterPadding ??
                        const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                    color:
                        caption != null ? Colors.black54 : Colors.transparent,
                    child: caption ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ),
        ),
        shown: shown,
        duration: duration ?? const Duration(seconds: 3),
        bottom: bottom,
        ids: ids);
  }

  /// Shorthand for creating inline image. [controller] should be same instance as
}

class StoryView extends StatefulWidget {
  final List<StoryItem?> storyItems;
  final VoidCallback? onComplete;
  final Function(Direction?)? onVerticalSwipeComplete;

  final void Function(StoryItem storyItem, int index)? onStoryShow;

  final ProgressPosition progressPosition;

  final bool repeat;

  final bool inline;

  final StoryController controller;

  /// Indicator Color
  final Color? indicatorColor;

  /// Indicator Foreground Color
  final Color? indicatorForegroundColor;

  /// Determine the height of the indicator
  final IndicatorHeight indicatorHeight;

  /// Use this if you want to give outer padding to the indicator
  final EdgeInsetsGeometry indicatorOuterPadding;

  // final Widget Function(StoryItem soryItem) bottom;

  const StoryView({
    super.key,
    // required this.bottom,
    required this.storyItems,
    required this.controller,
    this.onComplete,
    this.onStoryShow,
    this.progressPosition = ProgressPosition.top,
    this.repeat = false,
    this.inline = false,
    this.onVerticalSwipeComplete,
    this.indicatorColor,
    this.indicatorForegroundColor,
    this.indicatorHeight = IndicatorHeight.large,
    this.indicatorOuterPadding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  });

  @override
  State<StatefulWidget> createState() {
    return StoryViewState();
  }
}

class StoryViewState extends State<StoryView> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _currentAnimation;
  Timer? _nextDebouncer;

  StreamSubscription<PlaybackState>? _playbackSubscription;

  VerticalDragInfo? verticalDragInfo;

  StoryItem? get _currentStory {
    return widget.storyItems.firstWhereOrNull((it) => !it!.shown);
  }

  Widget get _currentView {
    var item = widget.storyItems.firstWhereOrNull((it) => !it!.shown);
    item ??= widget.storyItems.last;
    return item?.view ?? Container();
  }

  Widget? get _currentBottom {
    var item = widget.storyItems.firstWhereOrNull((it) => !it!.shown);
    item ??= widget.storyItems.last;
    return item!.bottom;
  }

  List<String>? get _currentIds {
    var item = widget.storyItems.firstWhereOrNull((it) => !it!.shown);
    item ??= widget.storyItems.last;
    print(item?.ids);
    return item?.ids;
  }

  @override
  void initState() {
    super.initState();

    // All pages after the first unshown page should have their shown value as
    // false
    final firstPage = widget.storyItems.firstWhereOrNull((it) => !it!.shown);
    if (firstPage == null) {
      for (var it2 in widget.storyItems) {
        it2!.shown = false;
      }
    } else {
      final lastShownPos = widget.storyItems.indexOf(firstPage);
      widget.storyItems.sublist(lastShownPos).forEach((it) {
        it!.shown = false;
      });
    }

    this._playbackSubscription =
        widget.controller.playbackNotifier.listen((playbackStatus) {
      switch (playbackStatus) {
        case PlaybackState.play:
          _removeNextHold();
          this._animationController?.forward();
          break;

        case PlaybackState.pause:
          _holdNext(); // then pause animation
          this._animationController?.stop(canceled: false);
          break;

        case PlaybackState.next:
          _removeNextHold();
          _goForward();
          break;

        case PlaybackState.previous:
          _removeNextHold();
          _goBack();
          break;
      }
    });

    _play();
  }

  @override
  void dispose() {
    _clearDebouncer();

    _animationController?.dispose();
    _playbackSubscription?.cancel();

    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _play() {
    _animationController?.dispose();
    // get the next playing page
    final storyItem = widget.storyItems.firstWhere((it) {
      return !it!.shown;
    })!;

    final storyItemIndex = widget.storyItems.indexOf(storyItem);

    if (widget.onStoryShow != null) {
      widget.onStoryShow!(storyItem, storyItemIndex);
    }

    _animationController =
        AnimationController(duration: storyItem.duration, vsync: this);

    _animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        storyItem.shown = true;
        if (widget.storyItems.last != storyItem) {
          _beginPlay();
        } else {
          // done playing
          _onComplete();
        }
      }
    });

    _currentAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_animationController!);

    widget.controller.play();
  }

  void _beginPlay() {
    setState(() {});
    _play();
  }

  void _onComplete() {
    if (widget.onComplete != null) {
      widget.controller.pause();
      widget.onComplete!();
    }

    if (widget.repeat) {
      for (var it in widget.storyItems) {
        it!.shown = false;
      }

      _beginPlay();
    }
  }

  void _goBack() {
    _animationController!.stop();

    if (this._currentStory == null) {
      widget.storyItems.last!.shown = false;
    }

    if (this._currentStory == widget.storyItems.first) {
      _beginPlay();
    } else {
      this._currentStory!.shown = false;
      int lastPos = widget.storyItems.indexOf(this._currentStory);
      final previous = widget.storyItems[lastPos - 1]!;

      previous.shown = false;

      _beginPlay();
    }
  }

  void _goForward() {
    if (this._currentStory != widget.storyItems.last) {
      _animationController!.stop();

      // get last showing
      final _last = this._currentStory;

      if (_last != null) {
        _last.shown = true;
        if (_last != widget.storyItems.last) {
          _beginPlay();
        }
      }
    } else {
      // this is the last page, progress animation should skip to end
      _animationController!
          .animateTo(1.0, duration: const Duration(milliseconds: 10));
    }
  }

  void _clearDebouncer() {
    _nextDebouncer?.cancel();
    _nextDebouncer = null;
  }

  void _removeNextHold() {
    _nextDebouncer?.cancel();
    _nextDebouncer = null;
  }

  void _holdNext() {
    _nextDebouncer?.cancel();
    _nextDebouncer = Timer(const Duration(milliseconds: 500), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          _currentView,
          Visibility(
            visible: widget.progressPosition != ProgressPosition.none,
            child: Align(
              alignment: widget.progressPosition == ProgressPosition.top
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              child: SafeArea(
                bottom: widget.inline ? false : true,
                // we use SafeArea here for notched and bezeles phones
                child: Container(
                  padding: widget.indicatorOuterPadding,
                  child: PageBar(
                    widget.storyItems
                        .map((it) => PageData(it!.duration, it.shown))
                        .toList(),
                    this._currentAnimation,
                    key: UniqueKey(),
                    indicatorHeight: widget.indicatorHeight,
                    indicatorColor: widget.indicatorColor,
                    indicatorForegroundColor: widget.indicatorForegroundColor,
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              heightFactor: 1,
              child: GestureDetector(
                onTapDown: (details) {
                  widget.controller.pause();
                },
                onTapCancel: () {
                  widget.controller.play();
                },
                onTapUp: (details) {
                  // if debounce timed out (not active) then continue anim
                  if (_nextDebouncer?.isActive == false) {
                    widget.controller.play();
                  } else {
                    widget.controller.next();
                  }
                },
                onVerticalDragStart: widget.onVerticalSwipeComplete == null
                    ? null
                    : (details) {
                        widget.controller.pause();
                      },
                onVerticalDragCancel: widget.onVerticalSwipeComplete == null
                    ? null
                    : () {
                        widget.controller.play();
                      },
                onVerticalDragUpdate: widget.onVerticalSwipeComplete == null
                    ? null
                    : (details) {
                        verticalDragInfo ??= VerticalDragInfo();

                        verticalDragInfo!.update(details.primaryDelta!);
                      },
                onVerticalDragEnd: widget.onVerticalSwipeComplete == null
                    ? null
                    : (details) {
                        widget.controller.play();
                        // finish up drag cycle
                        if (!verticalDragInfo!.cancel &&
                            widget.onVerticalSwipeComplete != null) {
                          widget.onVerticalSwipeComplete!(
                              verticalDragInfo!.direction);
                        }

                        verticalDragInfo = null;
                      },
              )),
          Align(
            alignment: Alignment.centerLeft,
            heightFactor: 1,
            child: SizedBox(
                width: 70,
                child: GestureDetector(onTap: () {
                  widget.controller.previous();
                })),
          ),
          _currentBottom != null
              ? Positioned(
                  bottom: 20.h,
                  left: 20.w,
                  child: TextButton(
                    onPressed: () {
                      //* stop the indicator :
                      widget.controller.pause();

                      //* view the modal bottom sheet :
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          //* get users :
                          context
                              .read<ShortUsersCubit>()
                              .getUsersById(ids: _currentIds ?? []);

                          //* modal bottom sheet :
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 10.h,
                            ),
                            child:
                                BlocBuilder<ShortUsersCubit, ShortUsersState>(
                              builder: (context, state) {
                                if (state.status == DeafultBlocStatus.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.status ==
                                    DeafultBlocStatus.error) {
                                  return ErrorTextWidget(
                                      message: state.message,
                                      onRefresh: () async {
                                        context
                                            .read<ShortUsersCubit>()
                                            .getUsersById(
                                                ids: _currentIds ?? []);
                                      });
                                }
                                return ListView(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Views",
                                        style: Styles.bodySemibold,
                                      ),
                                    ),
                                    if (state.users.isNotEmpty)
                                      ...state.users
                                          .map((user) => ShortUserProfile(
                                                user: user,
                                              )),
                                    if (state.users.isEmpty)
                                      Center(
                                        child: Text(
                                          "There is no views yet!",
                                          style: Styles.caption,
                                        ),
                                      )
                                  ],
                                );
                              },
                            ),
                          );
                        },
                      ).whenComplete(() {
                        widget.controller.play();
                      });
                    },
                    child: _currentBottom!,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class PageData {
  Duration duration;
  bool shown;

  PageData(this.duration, this.shown);
}

class PageBar extends StatefulWidget {
  final List<PageData> pages;
  final Animation<double>? animation;
  final IndicatorHeight indicatorHeight;
  final Color? indicatorColor;
  final Color? indicatorForegroundColor;

  const PageBar(
    this.pages,
    this.animation, {
    this.indicatorHeight = IndicatorHeight.large,
    this.indicatorColor,
    this.indicatorForegroundColor,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return PageBarState();
  }
}

class PageBarState extends State<PageBar> {
  double spacing = 4;

  @override
  void initState() {
    super.initState();

    int count = widget.pages.length;
    spacing = (count > 15) ? 2 : ((count > 10) ? 3 : 4);

    widget.animation!.addListener(() {
      setState(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  bool isPlaying(PageData page) {
    return widget.pages.firstWhereOrNull((it) => !it.shown) == page;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.pages.map((it) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.only(
                right: widget.pages.last == it ? 0 : this.spacing),
            child: StoryProgressIndicator(
              isPlaying(it) ? widget.animation!.value : (it.shown ? 1 : 0),
              indicatorHeight: widget.indicatorHeight == IndicatorHeight.large
                  ? 5
                  : widget.indicatorHeight == IndicatorHeight.medium
                      ? 3
                      : 2,
              indicatorColor: widget.indicatorColor,
              indicatorForegroundColor: widget.indicatorForegroundColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Custom progress bar. Supposed to be lighter than the
/// original [ProgressIndicator], and rounded at the sides.
class StoryProgressIndicator extends StatelessWidget {
  /// From `0.0` to `1.0`, determines the progress of the indicator
  final double value;
  final double indicatorHeight;
  final Color? indicatorColor;
  final Color? indicatorForegroundColor;

  const StoryProgressIndicator(
    this.value, {
    super.key,
    this.indicatorHeight = 5,
    this.indicatorColor,
    this.indicatorForegroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromHeight(
        this.indicatorHeight,
      ),
      foregroundPainter: IndicatorOval(
        this.indicatorForegroundColor ?? Colors.white.withOpacity(0.8),
        this.value,
      ),
      painter: IndicatorOval(
        this.indicatorColor ?? Colors.white.withOpacity(0.4),
        1.0,
      ),
    );
  }
}

class IndicatorOval extends CustomPainter {
  final Color color;
  final double widthFactor;

  IndicatorOval(this.color, this.widthFactor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = this.color;
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width * this.widthFactor, size.height),
            const Radius.circular(3)),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// Concept source: https://stackoverflow.com/a/9733420
class ContrastHelper {
  static double luminance(int? r, int? g, int? b) {
    final a = [r, g, b].map((it) {
      double value = it!.toDouble() / 255.0;
      return value <= 0.03928
          ? value / 12.92
          : pow((value + 0.055) / 1.055, 2.4);
    }).toList();

    return a[0] * 0.2126 + a[1] * 0.7152 + a[2] * 0.0722;
  }

  static double contrast(rgb1, rgb2) {
    return luminance(rgb2[0], rgb2[1], rgb2[2]) /
        luminance(rgb1[0], rgb1[1], rgb1[2]);
  }
}
