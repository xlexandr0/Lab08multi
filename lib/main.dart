import 'package:flutter/cupertino.dart';

void main() => runApp(const MyApp());

/// Colores usados en la app (constantes para evitar inconsistencias)
const Color kBackground = CupertinoColors.white;
const Color kText = CupertinoColors.black;
const Color kButtonBlue = CupertinoColors.activeBlue;
const Color kLogoutRed = CupertinoColors.destructiveRed;
const Color kFieldBackground = CupertinoColors.extraLightBackgroundGray;
const Color kCardBackground = CupertinoColors.extraLightBackgroundGray;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      // Tema global: blanco, texto negro, fuente 'SFPro' (si la añadiste en pubspec)
      theme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: kButtonBlue,
        scaffoldBackgroundColor: kBackground,
        textTheme: CupertinoTextThemeData(
          // Usa la familia definida en tu pubspec ("SFPro")
          textStyle: TextStyle(
            fontFamily: 'SFPro',
            color: kText,
            fontSize: 17,
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}

// ---------------- LOGIN PAGE ----------------
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget _buildField({
    required String placeholder,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kFieldBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CupertinoTextField(
        controller: controller,
        placeholder: placeholder,
        obscureText: obscure,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
        style: const TextStyle(color: kText, fontFamily: 'SFPro'),
        placeholderStyle: const TextStyle(color: CupertinoColors.systemGrey),
        decoration: null, // dejamos el Container como "fondo" del campo
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          "LOGIN",
          style: TextStyle(color: kText),
        ),
        backgroundColor: kBackground,
        border: null,
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Bienvenido",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: kText,
                    fontFamily: 'SFPro',
                  ),
                ),
                const SizedBox(height: 24),
                _buildField(
                    placeholder: "Email", controller: emailController),
                const SizedBox(height: 16),
                _buildField(
                  placeholder: "Password",
                  controller: passwordController,
                  obscure: true,
                ),
                const SizedBox(height: 24),
                // Botón azul (filled) con color explícito
                CupertinoButton.filled(
                  borderRadius: BorderRadius.circular(12),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (_) => const MenuPage()),
                    );
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontFamily: 'SFPro',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- MENU PAGE ----------------
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("MENU", style: TextStyle(color: kText)),
        backgroundColor: kBackground,
        border: null,
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Menú principal",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: kText,
                    fontFamily: 'SFPro',
                  ),
                ),
                const SizedBox(height: 24),
                // Home (no navega) - azul
                CupertinoButton(
                  borderRadius: BorderRadius.circular(12),
                  color: kButtonBlue,
                  onPressed: () {},
                  child: const Text(
                    "Home",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
                const SizedBox(height: 12),
                // Items -> lista (botón azul también)
                CupertinoButton(
                  borderRadius: BorderRadius.circular(12),
                  color: kButtonBlue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => const ListViewPage()),
                    );
                  },
                  child: const Text(
                    "Items",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
                const SizedBox(height: 12),
                // Logout -> rojo con texto blanco y vuelve al login
                CupertinoButton(
                  borderRadius: BorderRadius.circular(12),
                  color: kLogoutRed,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: CupertinoColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- LISTVIEW PAGE ----------------
class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ["Item 1", "Item 2", "Item 3", "Item 4"];

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Items", style: TextStyle(color: kText)),
        backgroundColor: kBackground,
        border: null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text(
                "Items",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: kText,
                  fontFamily: 'SFPro',
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: kCardBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          items[index],
                          style: const TextStyle(
                            fontSize: 18,
                            color: kText,
                            fontFamily: 'SFPro',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
