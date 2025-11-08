import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import 'programs_screen.dart';
import 'courses_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;

  static const Color mainBlue = Color(0xFF003F89);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNavTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) => setState(() => _selectedIndex = index),
        children: const [
          _HomeDashboard(),
          ProgramsScreen(),
          CoursesScreen(),
          ChatScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: mainBlue,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: SalomonBottomBar(
            backgroundColor: mainBlue,
            currentIndex: _selectedIndex,
            onTap: _onNavTapped,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.school),
                title: const Text("Programs"),
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.book),
                title: const Text("Courses"),
                selectedColor: Colors.white,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.chat_bubble_rounded),
                title: const Text("Chat"),
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();

  static const Color mainBlue = Color(0xFF003F89);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final userName = auth.userName ?? "Student";

    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              decoration: const BoxDecoration(
                color: mainBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/logo.png',
                          height: 42,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'United Academy',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.logout, color: Colors.white),
                          onPressed: () async {
                            await auth.logout();
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
                            }
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "Welcome back, $userName 👋",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Let's make today productive!",
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Quick Access
            Text(
              "Quick Access",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: mainBlue,
              ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _HomeCard(icon: Icons.school, title: "Programs", color: mainBlue,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ProgramsScreen()))),
                _HomeCard(icon: Icons.book, title: "Courses", color: mainBlue,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CoursesScreen()))),
                _HomeCard(icon: Icons.chat, title: "Chat", color: mainBlue,
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ChatScreen()))),
                _HomeCard(icon: Icons.calendar_month, title: "Schedule", color: mainBlue, onTap: () {}),
                _HomeCard(icon: Icons.assessment, title: "Results", color: mainBlue, onTap: () {}),
                _HomeCard(icon: Icons.notifications, title: "Notices", color: mainBlue, onTap: () {}),
              ],
            ),

            const SizedBox(height: 24),

            // Announcements
            Text(
              "Announcements",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: mainBlue,
              ),
            ),
            const SizedBox(height: 10),
            _AnnouncementCard(
              title: "Midterm Exams start next week",
              date: "Nov 10, 2025",
            ),
            _AnnouncementCard(
              title: "Science Fair registrations open",
              date: "Nov 15, 2025",
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _HomeCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                )),
          ],
        ),
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final String title;
  final String date;

  const _AnnouncementCard({
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.campaign, color: _HomeDashboard.mainBlue, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 15)),
                const SizedBox(height: 4),
                Text(date,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
