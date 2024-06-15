import 'package:example_app/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InfoPersonnel extends StatefulWidget {
  const InfoPersonnel({super.key});

  @override
  State<InfoPersonnel> createState() => _InfoPersonnelState();
}

class _InfoPersonnelState extends State<InfoPersonnel> with SingleTickerProviderStateMixin {
  late TextEditingController _nomTextEditingController;
  late TextEditingController _prenomTextEditingController;
  late TextEditingController _telTextEditingController;
  late TextEditingController _emailTextEditingController;
  late TextEditingController _oldPasswordTextEditingController;
  late TextEditingController _newPasswordTextEditingController;
  late TabController _tabController;
  late String userId;
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  UserService userService = UserService();

  @override
  void initState() {
    super.initState();
    _nomTextEditingController = TextEditingController();
    _prenomTextEditingController = TextEditingController();
    _telTextEditingController = TextEditingController();
    _emailTextEditingController = TextEditingController();
    _oldPasswordTextEditingController = TextEditingController();
    _newPasswordTextEditingController = TextEditingController();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id') ?? '';
    setState(() {
      _nomTextEditingController.text = prefs.getString('user_nom') ?? '';
      _prenomTextEditingController.text = prefs.getString('user_prenom') ?? '';
      _telTextEditingController.text = prefs.getString('user_telephone') ?? '';

      if (_telTextEditingController.text.isNotEmpty) {
        _telTextEditingController.text = '0' + _telTextEditingController.text;
      }
    });
  }

  Future<void> updateUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    if (userId != null) {
      try {
        await userService.updateUser(
          nom: _nomTextEditingController.text,
          prenom: _prenomTextEditingController.text,
          telephone: _telTextEditingController.text,
        );
      } catch (error) {
        print('Error updating user data: $error');
      }
    } else {
      print('User ID not found');
    }
  }

  Future<void> updateUserPwd() async {
    try {
      await userService.updatePassword(
        oldPassword: _oldPasswordTextEditingController.text,
        newPassword: _newPasswordTextEditingController.text,
      );
    } catch (error) {
      print('Error updating password: $error');
    }
  }

  @override
  void dispose() {
    _nomTextEditingController.dispose();
    _prenomTextEditingController.dispose();
    _telTextEditingController.dispose();
    _emailTextEditingController.dispose();
    _oldPasswordTextEditingController.dispose();
    _newPasswordTextEditingController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
        bottom: TabBar(
          indicatorColor: const Color.fromRGBO(5, 12, 75, 1.0),
          labelColor: const Color.fromRGBO(5, 12, 75, 1.0),
          controller: _tabController,
          tabs: const [
            Tab(text: "Info Personnel"),
            Tab(text: "Change Password"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPersonalInfoTab(),
          _buildChangePasswordTab(),
        ],
      ),
    );
  }

  Widget _buildPersonalInfoTab() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Mettez à jour votre information personnelle",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _nomTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        filled: true,
                        fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                        labelText: 'Votre nom',
                        hintText: 'nom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.person,
                            color: Color.fromRGBO(5, 12, 79, 1.0),
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _prenomTextEditingController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        filled: true,
                        fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                        labelText: 'Votre prenom',
                        hintText: 'prenom',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _telTextEditingController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  filled: true,
                  fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                  labelText: 'Enter votre telephone',
                  hintText: '06xxxxxxxx',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.phone,
                      color: Color.fromRGBO(5, 12, 79, 1.0),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                updateUserData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(5, 12, 79, 1.0),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Enregistrer',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordTab() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Changez votre mot de passe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 20),
            // Old password field with visibility toggle
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _oldPasswordTextEditingController,
                obscureText: !_isOldPasswordVisible,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  filled: true,
                  fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                  labelText: 'Ancien mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.lock_outline,
                      color: Color.fromRGBO(5, 12, 79, 1.0),
                      size: 25,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isOldPasswordVisible = !_isOldPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // New password field with visibility toggle
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _newPasswordTextEditingController,
                obscureText: !_isNewPasswordVisible,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  filled: true,
                  fillColor: const Color.fromRGBO(180, 233, 230, 1.0),
                  labelText: 'Nouveau mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.vpn_key,
                      color: Color.fromRGBO(5, 12, 79, 1.0),
                      size: 25,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                updateUserPwd();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(5, 12, 79, 1.0),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Enregistrer',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
