import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/viewmodels/home_view_model.dart';

import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/home/shop_item.dart';
import 'package:pingna/resources/widgets/layouts/drawer.dart';

class HomeView extends StatelessWidget {
  HomeView({Key key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(Icons.menu),
        ),
        actionsIconTheme: Theme.of(context).iconTheme,
        actions: [
          GestureDetector(
            child: Consumer<User>(
              builder: (context, user, _) => Row(
                children: [
                  Icon(Icons.pin_drop_outlined),
                  if (user.postCode != null)
                    Text(
                      user.postCode,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: PingnaDrawer(),
      body: Consumer<HomeViewModel>(
        builder: (context, model, _) => CustomScrollView(
          slivers: <Widget>[
            SearchAppBar(user: model.user),
            if (model.isInitialised) ...[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final shopTypeItem = model.shopTypes[index];
                    final shops = model.shopsBy(shopTypeItem.id);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              shopTypeItem.name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_outlined),
                        ),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: shops.length,
                            itemBuilder: (context, shopIndex) {
                              final shop  = shops[shopIndex];
                              final labels = model.shopLabelsFor(shop);
                              return HomeShopItem(
                                item: shop,
                                labels: labels,
                                picIndex: model.randomId,
                              );
                            },
                          ),
                        )
                      ],
                    );
                  },
                  childCount: model.shopTypes.length,
                ),
              ),
            ],
            if (!model.isInitialised)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Placeholder();
                  },
                  childCount: 3,
                ),
              )
          ],
        ),
      ),

      // TODO: Use FAB as basket icon if one is active
    );
  }
}

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      // TODO: Make expandedHeight dynamic based on device text size
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: ListTile(
          dense: true,
          title: Text(
            'home.greeting'.tr(args: [user.name]),
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text('home.subtitle'.tr()),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.only(bottom: 4.0),
          child: ListTile(
            title: Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightcharcoalColor),
                borderRadius: BorderRadius.circular(4.0),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Theme.of(context).textTheme.bodyText2.color,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'home.search'.tr(),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
