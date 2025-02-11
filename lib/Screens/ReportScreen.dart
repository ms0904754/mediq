import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/AppController.dart';
import 'AddMedicineScreen.dart';
import 'HomeScreen.dart';

class ReportScreen extends StatelessWidget {
  AppController appController  = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Report',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTodayReport(),
                  const SizedBox(height: 24),
                  _buildDashboardSection(),
                  const SizedBox(height: 24),
                  _buildHistorySection(),
                  const SizedBox(height: 24),
                  _buildMedicationList(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Obx(
            ()=> Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(onPressed: (){
                  appController.currScreen.value="home";
                  Get.to(HomeScreen());
                }, label: Text('Home'),icon: Icon(Icons.home,size: appController.currScreen.value=="home"?35:25,color: appController.currScreen.value=='home'?Colors.black:Colors.blueGrey,),),

                TextButton.icon(onPressed: (){
                  appController.currScreen.value="report";
                  Get.to(ReportScreen());
                }, label: Text('report'),icon: Icon(Icons.bar_chart,size: appController.currScreen.value=="report"?35:25,color: appController.currScreen.value=='report'?Colors.black:Colors.blueGrey,),)

              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 35),
          child: FloatingActionButton(onPressed: (){
            Get.to(AddMedicineScreen());
          },backgroundColor: Colors.black, child: Icon(Icons.add,color: Colors.white,size: 30,)),
        ),
    );
  }

  Widget _buildTodayReport() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildReportItem('5', 'Total'),
          _buildReportItem('3', 'Taken'),
          _buildReportItem('1', 'Missed'),
          _buildReportItem('1', 'Snoozed'),
        ],
      ),
    );
  }

  Widget _buildReportItem(String value, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue[400],
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Check Dashboard',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Here you will find everything related to your active and past medicines.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: CustomPaint(
                  painter: CircularProgressPainter(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Check History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              30,
                  (index) => _buildDateCircle(index + 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateCircle(int day) {
    final isSelected = day == 1;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue[400] : Colors.grey[200],
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Morning 08:00 am',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildMedicationItem(
          'Calpol 500mg Tablet',
          'Before Breakfast',
          'Day 01',
          Icons.check_circle_outline,
          Colors.green,
        ),
        _buildMedicationItem(
          'Calpol 500mg Tablet',
          'Before Breakfast',
          'Day 27',
          Icons.cancel_outlined,
          Colors.red,
        ),
        const SizedBox(height: 24),
        const Text(
          'Afternoon 02:00 pm',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildMedicationItem(
          'Calpol 500mg Tablet',
          'After Food',
          'Day 01',
          Icons.snooze,
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildMedicationItem(String name, String timing, String day, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.purple[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.water_drop, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      timing,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      day,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(icon, color: color),
        ],
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Background circle
    paint.color = Colors.grey[200]!;
    canvas.drawCircle(center, radius, paint);

    // Progress arcs
    final rect = Rect.fromCircle(center: center, radius: radius);
    paint.strokeCap = StrokeCap.round;

    // Green progress
    paint.color = Colors.green;
    canvas.drawArc(rect, -0.5, 2, false, paint);

    // Orange progress
    paint.color = Colors.orange;
    canvas.drawArc(rect, 1.5, 1, false, paint);

    // Blue progress
    paint.color = Colors.blue;
    canvas.drawArc(rect, 2.5, 1, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}