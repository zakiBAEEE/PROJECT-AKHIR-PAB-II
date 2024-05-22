import 'package:flutter/material.dart';
import 'package:red_wine/widget/profile_info_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 190,
            width: double.infinity,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'PROFILE',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 190 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            radius: 65,
                          ),
                        ),
                        if (true)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.camera_alt,
                                  color: Colors.deepPurple[50]),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Pengguna
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 4,
                ),
                const ProfileInfoItem(
                  icon: Icons.lock,
                  label: "Pengguna",
                  value: "Aan Gacor",
                  iconColor: Colors.amber,
                ),

                // Nama
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 4,
                ),
                const ProfileInfoItem(
                  icon: Icons.person,
                  label: "Email",
                  value: "aanGacor@gmail.com",
                  iconColor: Colors.blue,
                  showEditIcon: true,
                ),

                //Favorit
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 4,
                ),
                const ProfileInfoItem(
                  icon: Icons.favorite,
                  label: "Favorit",
                  value: "100",
                  iconColor: Colors.red,
                ),

                //Penutup
                const SizedBox(
                  height: 4,
                ),
                Divider(
                  color: Colors.deepPurple[100],
                ),
                const SizedBox(
                  height: 20,
                ),
                // TODO: 4 Buat ProfileAction yang berisi TextButton sign in/sign out

                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(200, 40),
                          backgroundColor: Colors.amber),
                      child: const Text(
                        "Sign Out",
                        style:
                            TextStyle(color: Color.fromARGB(255, 192, 47, 47)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
