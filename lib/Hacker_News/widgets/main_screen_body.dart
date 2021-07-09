import 'package:flutter/material.dart';

import '../bloc_using_inherited_widgets/stories_bloc/stories_provider.dart';
import 'hacker_news_item_widget.dart';
import 'no_internet_widget.dart';
import 'resfresh.dart';

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoriesBloc? bloc = StoriesProvider.of(context);
    bloc!.fetchTopIds();

    return Column(
      children: <Widget>[
        NoInternetWidget(),
        Expanded(
          child: StreamBuilder<List<int>>(
            stream: bloc.topIdsStream,
            builder:
                (BuildContext buildContext, AsyncSnapshot<List<int>> snapShot) {
              // print(snapShot.connectionState);
              if (snapShot.connectionState == ConnectionState.waiting) {
                bloc.fetchTopIds();
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapShot.hasData || snapShot.data!.isEmpty) {
                return const Center(child: Text('No Existing Data!!'));
              }

              return Refresh(
                child: ListView.builder(
                    itemCount:
                        snapShot.data == null ? 0 : snapShot.data!.length,
                    itemBuilder: (BuildContext buildContext, int index) {
                      bloc.fetchItem(snapShot.data![index]);
                      return NewsItemWidget(newsId: snapShot.data![index]);
                    }),
              );
            },
          ),
        ),
      ],
    );
  }
}
