import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter/constants/global_colors.dart';
import 'package:store_api_flutter/models/users_modal.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final usersModelProvider = Provider.of<UsersModal>(context);
    Size size = MediaQuery.of(context).size;

    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: const Icon(
          IconlyBold.danger,
          color: Colors.red,
          size: 40,
        ),
        imageUrl:
            usersModelProvider.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title: Text(usersModelProvider.name!),
      subtitle: Text(usersModelProvider.email.toString()),
      trailing: Text(
        usersModelProvider.role.toString(),
        style: TextStyle(
          color: lightIconsColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
