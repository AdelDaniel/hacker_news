import 'package:flutter/material.dart';
import 'comments_bloc.dart';
export 'comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  CommentsProvider({Key? key, required this.child})
      : _commentsBloc = CommentsBloc(),
        super(key: key, child: child);

  final Widget child;
  final CommentsBloc _commentsBloc;

  static CommentsProvider? _of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CommentsProvider>();
  }

  static CommentsBloc? of(BuildContext context) {
    return _of(context)!._commentsBloc;
  }

  @override
  bool updateShouldNotify(CommentsProvider oldWidget) {
    return true;
  }
}
