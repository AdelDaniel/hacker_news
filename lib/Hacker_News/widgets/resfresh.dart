import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import '../bloc_using_inherited_widgets/stories_bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;
  final Connectivity connection = Connectivity();
  Refresh({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final StoriesBloc? _bloc = StoriesProvider.of(context);
    return RefreshIndicator(
        child: child,
        onRefresh: () async {
          if (await connection.checkConnectivity() == ConnectivityResult.none) {
          } else {
            await _bloc!.clearCache();
            await _bloc.fetchTopIds();
          }
        });
  }
}
