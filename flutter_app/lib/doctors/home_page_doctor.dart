// File: lib/pages/home_page_doctor.dart
import 'dart:async';

import 'package:bsdoc_flutter/components/appbar.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart';
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 24,
            // TODO: Use NetworkImage for patient's profile picture
            backgroundImage: AssetImage('assets/images/test.png'),
          ),
          const SizedBox(height: 8),
          const Text(
            "Theo Gwapo", // TODO: Use patient's name
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            "Online", // TODO: Use appointment type
            style: TextStyle(fontSize: 10, color: Colors.black54),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2C3E50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "11:00 AM", // TODO: Use appointment time
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeBasedGreeting extends StatefulWidget {
  const TimeBasedGreeting({super.key});

  @override
  State<TimeBasedGreeting> createState() => _TimeBasedGreetingState();
}

class _TimeBasedGreetingState extends State<TimeBasedGreeting> {
  late Timer _timer;
  String greeting = '';

  @override
  void initState() {
    super.initState();
    updateGreeting();
    _timer = Timer.periodic(Duration(minutes: 1), (_) => updateGreeting());
  }

  void updateGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour < 12) {
        greeting = "Good morning!";
      } else if (hour == 12) {
        greeting = "Good noon!";
      } else if (hour >= 13 && hour < 17) {
        greeting = "Good afternoon!";
      } else if (hour > 17) {
        greeting = "Good evening!";
      } else {
        greeting = "Good night!";
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      greeting,
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class HomePageDoctor extends StatefulWidget {
  final List<Color> gradientColors;
  const HomePageDoctor({super.key, required this.gradientColors});

  @override
  State<HomePageDoctor> createState() => _HomePageDoctorState();
}

class _HomePageDoctorState extends State<HomePageDoctor> {
  final List<DateTime> _weekDays = [];
  DateTime _selectedDate = DateTime.now();

  bool _isLoadingAppointments = true;
  // TODO: List<Appointment> _appointments = [];
  // TODO: final AppointmentService _appointmentService = AppointmentService();

  @override
  void initState() {
    super.initState();
    _generateWeekDays();
    _fetchAppointmentsForDate();
  }

  void _generateWeekDays() {
    _weekDays.clear();
    final today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      _weekDays.add(today.add(Duration(days: i)));
    }
  }

  void _fetchAppointmentsForDate() {
    setState(() {
      _isLoadingAppointments = true;
    });

    // TODO: Call appoinment service
    // For now, simulate delay and empty list
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          // _appointments = fetchedData;
          _isLoadingAppointments = false;
        });
      }
    });
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _fetchAppointmentsForDate();
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _weekDays.length,
        itemBuilder: (context, index) {
          final day = _weekDays[index];
          final bool isSelected = DateUtils.isSameDay(_selectedDate, day);

          return GestureDetector(
            onTap: () => _onDateSelected(day),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(
                left: index == 0 ? 0 : 8,
                right: index == _weekDays.length - 1 ? 24 : 8,
                top: 12,
                bottom: 12,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF004aad) : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((255 * 0.1).round()),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                DateFormat('MMMM d').format(day),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleList() {
    return Container(
      height: 150,
      child: _isLoadingAppointments
          ? const Center(child: CircularProgressIndicator())
          : false //change to `_appointments.isEmpty` when data is available
          ? const Center(
              child: Text(
                '-- Nothing follows --',
                style: TextStyle(color: Colors.black54),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5 + 1,
              itemBuilder: (context, index) {
                final double leftPadding = (index == 0) ? 12 : 0;

                if (index == 5) {
                  return Container(
                    margin: const EdgeInsets.only(left: 16, right: 24),
                    alignment: Alignment.center,
                    child: const Text(
                      "-- Nothing follows --",
                      style: TextStyle(color: Colors.black54),
                    ),
                  );
                }

                //TODO: get actual appointment from list
                // final appointment = _appointment[index];

                //placeholder for appointment card
                return Padding(
                  padding: EdgeInsets.only(left: leftPadding),
                  child: const AppointmentCard(),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userLastName = Provider.of<AuthProvider>(
      context,
      listen: false,
    ).userLastName;

    Color appBarTextColor = widget.gradientColors.first.computeLuminance() < 0.5
        ? Colors.white
        : Colors.black;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: MainAppBar(
          title: SvgPicture.asset('assets/images/logonew.svg', height: 40),
          appBarTextColor: appBarTextColor,
        ),
      ),
      body: Stack(
        children: [
          // This container provides the gradient background for the whole screen
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.gradientColors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // This Column will structure the content on top of the gradient
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- 1. HEADER CONTENT (On the gradient) ---
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Hi, Dr. $userLastName',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color:
                                Colors.white, // Assuming white text is desired
                            height: 1,
                          ),
                        ),
                      ),
                      TimeBasedGreeting(),
                    ],
                  ),
                ),
                // Spacing between header and the white container
                // --- 2. THE NEW WHITE CONTAINER ---
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    // Child of the container is scrollable
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 3),
                          // --- CONTENT INSIDE THE WHITE CONTAINER GOES HERE ---
                          _buildDateSelector(),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 12,
                            ),
                            child: Text(
                              'Schedule',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          _buildScheduleList(),

                          // TODO: Add your Schedule widgets (e.g., Row with date buttons, appointment cards)
                          const SizedBox(height: 24),

                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 16,
                            ),
                            child: Text(
                              'Manage',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),
                          // TODO: Add your Manage widgets (e.g., ListTile for Appointments)

                          // This is just a placeholder to ensure scrolling
                          const SizedBox(height: 500),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Your Bottom Navigation Bar remains at the bottom of the Stack
          Positioned(
            left: 12,
            right: 12,
            bottom: 15 + MediaQuery.of(context).padding.bottom,
            child: const GlobalBottomNav(currentIndex: 0),
          ),
        ],
      ),
    );
  }
}
