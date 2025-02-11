import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/AppController.dart';
import '../Model/Medicine.dart';
import 'AddMedicineScreen.dart';
import 'ReportScreen.dart';
import 'UserProfile.dart';

class HomeScreen extends StatelessWidget {
  final AppController _appController = Get.put(AppController());
  DateTime now = DateTime.now();


  @override
  Widget build(BuildContext context) {
    _appController.checkInternet();
    return Obx(
      ()=> Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi Harry!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '5 Medicines Left',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.camera_alt, color: Colors.blue),
                          onPressed: () {},
                        ),
                       IconButton(onPressed: (){
                         Get.to(UserProfile());
                       }, icon: Icon(Icons.account_circle_rounded))
                      ],
                    ),
                  ],
                ),
              ),
              _buildDateSelector(),
              Expanded(
                child: Obx(
                      () {
                        return ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      if (_appController.medicines.isNotEmpty) ...[
                        _buildTimeSection('Morning', '08:00 am',
                            _appController.medicines.where((m) => ((m.timesPerDay == 'One Time' && m.timing=='Before Food') || (m.timesPerDay == 'Three Time'))).toList()),
                        _buildTimeSection('Afternoon', '02:00 pm',
                            _appController.medicines.where((m) => (m.timesPerDay == 'Two Time' || m.timesPerDay == 'Three Time' || m.timing=='After Food')).toList()),
                        _buildTimeSection('Night', '09:00 pm',
                            _appController.medicines.where((m) => ((m.timesPerDay == 'One Time' && m.timing=='Before Sleep') || m.timesPerDay == 'Three Time' || m.timing=='After Food')).toList()),
                      ] else
                        Center(
                          child: Column(
                            children: [
                              Image(image: AssetImage('assets/images/empty_box.jpg')),
                              SizedBox(height: 10,),
                              Text("Nothing is Here. Add a Medicine",style: TextStyle(color: Colors.grey,fontSize: 20),)
                            ],
                          ),
                        ),
                    ],
                  );}
                ),
              ),
              // _buildBottomNav(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(onPressed: (){
                _appController.currScreen.value="home";
                Get.offUntil(MaterialPageRoute(builder: (context)=>HomeScreen()), (route)=>route.isFirst);
                // Get.to(HomeScreen());
              }, label: Text('Home'),icon: Icon(Icons.home,size: _appController.currScreen.value=="home"?35:25,color: _appController.currScreen.value=='home'?Colors.black:Colors.blueGrey,),),

              TextButton.icon(onPressed: (){
                _appController.currScreen.value="report";
                Get.to(ReportScreen());
              }, label: Text('report'),icon: Icon(Icons.bar_chart,size: _appController.currScreen.value=="report"?35:25,color: _appController.currScreen.value=='report'?Colors.black:Colors.blueGrey,),)

            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 35),
          child: FloatingActionButton(onPressed: (){
            Get.to(AddMedicineScreen());
          },backgroundColor: Colors.black, child: Icon(Icons.add,color: Colors.white,size: 30,)),
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    String monthName = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ][now.month - 1];

    List<String> dayName = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(dayName[(now.weekday+7-2)%7].substring(0,3)),
          Text(dayName[(now.weekday+7-1)%7].substring(0,3)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${dayName[now.weekday]}, $monthName ${now.day}",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(dayName[(now.weekday+1)%7].substring(0,3)),
          Text(dayName[(now.weekday+2)%7].substring(0,3)),
        ],
      ),
    );
  }

  Widget _buildTimeSection(String title, String time, List<Medicine> medicines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title $time',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        ...medicines.map((medicine) => _buildMedicineCard(medicine)),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMedicineCard(Medicine medicine) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: medicine.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.medication,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicine.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${medicine.beforeAfter}    Day ${medicine.day}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          _buildStatusIcon(medicine.status),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;
    switch (status) {
      case 'Taken':
        icon = Icons.check_circle_outline;
        color = Colors.green;
        break;
      case 'Missed':
        icon = Icons.error_outline;
        color = Colors.red;
        break;
      case 'Snoozed':
        icon = Icons.snooze;
        color = Colors.orange;
        break;
      default:
        icon = Icons.access_time;
        color = Colors.grey;
    }
    return Icon(icon, color: color);
  }

}