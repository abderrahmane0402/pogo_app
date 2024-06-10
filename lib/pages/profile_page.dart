import 'package:example_app/services/AuthenticationService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService authService = AuthService();
  final storage = const FlutterSecureStorage();
  SharedPreferences? prefs;
  String? nom;
  String? prenom;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs?.getString('user_nom');
      prenom = prefs?.getString('user_prenom');
    });
  }

  // void logout_user() async {
  //   try {
  //     final response = await authService.logout();
  //
  //   }catch{
  //     print('error');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Votre Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              elevation: 20,
              child: CircleAvatar(
                radius: 65,
                backgroundColor: const Color.fromRGBO(5, 12, 79, 1.0),
                child: CircleAvatar(
                  radius: 60,
                  child: Image.asset('assets/images/home.png'),
                ),
              ),
            ),
            Text(
              nom != null && prenom != null ? '$nom $prenom' : "Loading...",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.all(0),
                  color: const Color.fromRGBO(63, 207, 173, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      const MenuItem(
                        icon: Icons.person_3_outlined,
                        title: "Information personnels",
                        href: "/infoPersonnels",
                      ),
                      const MenuItem(
                        icon: Icons.payment_outlined,
                        title: "Vos carte bancaire",
                        href: "/carteBancaire",
                      ),
                      const MenuItem(
                        icon: Icons.notifications_outlined,
                        title: "Les notifications",
                        href: "",
                      ),
                      const MenuItem(
                        icon: Icons.history_rounded,
                        title: "Historique d'activite",
                        href: "/history",
                      ),
                      MenuItem(
                        icon: Icons.logout_outlined,
                        title: "Déconnecter",
                        href: "/beforeLogin",
                        onPressed: () async {
                          await authService.logout();
                          final token = await storage.read(key: 'auth_token');
                          print(token);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String href;
  final VoidCallback? onPressed;
  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.href,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        ),
      ),
      onPressed: onPressed ?? () => Navigator.pushNamed(context, href),
      leadingIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: const Color.fromRGBO(5, 12, 79, 1),
        ),
      ),
      trailingIcon: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 15,
        color: Color.fromRGBO(5, 12, 79, 1),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}
