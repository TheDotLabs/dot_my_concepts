import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/section_divider.dart';

import 'bloc.dart';
import 'models/my_user.dart';
import 'repo/user_repository.dart';
import 'widgets/logout_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _bloc = ProfileBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MyUser>(
      stream: injector<UserRepository>().getLoggedInUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
              horizontal: 4,
            ),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              ProfileHeader(user: snapshot.data),
              SectionDivider(),
              HelpAndSupportContainer(),
              LogoutButton(),
              const SizedBox(height: kBottomNavigationBarHeight),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularLoading();
        }
      },
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final MyUser user;

  const ProfileHeader({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ProfileContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: <Widget>[
            SizedBox(width: 16.0),
            CircleAvatar(
              radius: (size.height * 0.1) / 2,
              backgroundImage: CachedNetworkImageProvider(user.avatar ?? '-'),
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.name ?? "--",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  user.email ?? "--",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class HelpAndSupportContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileContainer(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            SimpleLineIcons.info,
            color: Colors.black,
          ),
          title: Text(
            'Help & FAQ\'s',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            SimpleLineIcons.phone,
            color: Colors.black,
          ),
          title: Text(
            'Connect with us',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        )
      ],
    ));
  }
}

class ProfileContainer extends StatelessWidget {
  final Widget child;

  const ProfileContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      color: Colors.white,
      child: child,
    );
  }
}
