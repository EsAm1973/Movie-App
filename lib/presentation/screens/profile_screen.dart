import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic_layer/theme_cubit/theme_cubit.dart';

import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';
import 'package:movie_app/presentation/widgets/profile_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserDataCubit userCubit;

  @override
  void initState() {
    super.initState();
    userCubit = context.read<UserDataCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = themeCubit.state is ThemeChanged &&
        (themeCubit.state as ThemeChanged).themeData.brightness ==
            Brightness.dark;

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage(
                      'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/user-profile-icon.png',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.edit,
                        size: 18,
                        color: theme.iconTheme.color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(userCubit.state!.username,
                style: theme.textTheme.headlineSmall),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ProfileItem(
                    icon: Icons.person,
                    title: userCubit.state!.username,
                    onTap: () {},
                  ),
                  ProfileItem(
                    icon: Icons.email,
                    title: 'example@gmail.com',
                    onTap: () {},
                  ),
                  ProfileItem(
                    icon: Icons.lock,
                    title: '${userCubit.state!.password}',
                    onTap: () {},
                  ),
                  ProfileItem(
                    icon: Icons.location_on,
                    title: 'Egypt, Cairo',
                    onTap: () {},
                  ),
                  ProfileItem(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    onTap: () {},
                    trailingWidget: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        themeCubit.toggleTheme();
                      },
                      activeColor: theme.colorScheme.primary,
                      inactiveThumbColor: theme.disabledColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: theme.iconTheme.color,
                    ),
                    title: Text(
                      'Log Out',
                      style: theme.textTheme.bodyMedium,
                    ),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
