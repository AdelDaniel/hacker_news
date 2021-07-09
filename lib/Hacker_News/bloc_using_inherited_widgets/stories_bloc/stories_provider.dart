import 'package:flutter/material.dart';

import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  StoriesProvider({Key? key, required this.child})
      : storiesBloc = StoriesBloc(),
        super(key: key, child: child);

  final Widget child;
  final StoriesBloc storiesBloc;

  static StoriesProvider? _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StoriesProvider>();
  }

  static StoriesBloc? of(BuildContext context) {
    final StoriesProvider? _storiesProvider = StoriesProvider._of(context);
    if (_storiesProvider != null) {
      return _storiesProvider.storiesBloc;
    } else {
      return null;
    }
  }

  @override
  bool updateShouldNotify(StoriesProvider oldWidget) => true;
}
