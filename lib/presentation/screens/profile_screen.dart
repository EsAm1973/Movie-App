import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/logic_layer/user_data/user_data_cubit.dart';
import 'package:movie_app/presentation/widgets/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserDataCubit userCubit;
  late int userId;
  @override
  void initState() {
    super.initState();
    userCubit = context.read<UserDataCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
        foregroundColor: Colors.white,
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
                    backgroundImage: NetworkImage(
                        'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/user-profile-icon.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              userCubit.state!.username,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
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
                    icon: Icons.support,
                    title: 'Support',
                    onTap: () {},
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Log Out',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onTap: () {
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const LoginScreen()),
                      //     (route) => false);
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
