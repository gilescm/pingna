import 'package:flutter/material.dart';
import 'package:pingna/core/constants.dart';
import 'package:provider/provider.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/viewmodels/home_view_model.dart';

import 'package:pingna/resources/widgets/home/shop_item.dart';
import 'package:pingna/resources/widgets/layouts/drawer.dart';
import 'package:pingna/resources/widgets/layouts/home_app_bar.dart';

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
          PostcodePin(),
        ],
      ),
      drawer: PingnaDrawer(),
      body: Consumer<HomeViewModel>(
        builder: (context, model, _) => CustomScrollView(
          slivers: <Widget>[
            HomeAppBar(user: model.user),
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
                            scrollDirection: Axis.horizontal,
                            itemCount: shops.length,
                            itemBuilder: (context, shopIndex) {
                              final shop = shops[shopIndex];
                              final labels = model.shopLabelsFor(shop);
                              return HomeShopItem(
                                item: shop,
                                labels: labels,
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
              SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              )
          ],
        ),
      ),

      // TODO: Use FAB as basket icon if one is active
    );
  }
}

class PostcodePin extends StatelessWidget {
  const PostcodePin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, postcodeRoute),
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
    );
  }
}
