import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/AppController.dart';
import '../Model/Medicine.dart';

class AddMedicineScreen extends StatefulWidget {
  const AddMedicineScreen({super.key});

  @override
  _AddMedicineScreenState createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
    final AppController appController = Get.put(AppController());
  int selectedCompartment = 1;
  Color selectedColor = Colors.pink[100]!;
  String selectedType = 'Tablet';
  double quantity = 0.5;
  int totalCount = 1;
  String frequency = 'Everyday';
  String timesPerDay = 'One Time';
  String timing = 'Before Food';
  List<String> freq = ["Everyday", "Weekly", "Monthly", "Yearly"];
  List<String> timesInaDay = ["One Time", "Two Time", "Three Time", "Four Time"];
    final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: SearchBar(
                  hintText: 'Search Medicine Name',
                  leading: Icon(Icons.search),
                  onChanged: (value) {
                    _searchController.text=value;
                  },
                  trailing: [Icon(Icons.mic)],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Compartment'),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(6, (index) =>
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: Text('${index + 1}'),
                                  selected: selectedCompartment == index + 1,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selectedCompartment = index + 1;
                                    });
                                  },
                                ),
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Colour'),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Colors.pink[100]!,
                            Colors.purple[100]!,
                            Colors.red[100]!,
                            Colors.green[100]!,
                            Colors.orange[100]!,
                            Colors.blue[100]!,
                            Colors.yellow[100]!,
                          ].map((color) =>
                              GestureDetector(
                                onTap: () => setState(() => selectedColor = color),
                                child: Container(
                                  margin: EdgeInsets.only(right: 8),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selectedColor == color ? Colors.blue : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              )
                          ).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Type'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTypeOption('Tablet', Icons.circle),
                          _buildTypeOption('Capsule', Icons.medication),
                          _buildTypeOption('Cream', Icons.sanitizer),
                          _buildTypeOption('Liquid', Icons.local_drink),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Quantity'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Take ${quantity.toString()} Pill'),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => setState(() {
                              if (quantity > 0.5) quantity -= 0.5;
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => setState(() => quantity += 0.5),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Total Count'),
                      Slider(
                        value: totalCount.toDouble(),
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: totalCount.toString(),
                        onChanged: (value) => setState(() => totalCount = value.round()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('01'),
                          Text('100'),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Set Date'),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDateField('Today'),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildDateField('End Date'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Frequency of Days'),
                      SizedBox(height: 10),
                      _buildfreqDropdownField('Frequency of Days', frequency,freq),
                      SizedBox(height: 10),
                      _buildtimesinaDayDropdownField('How many times a Day', timesPerDay,timesInaDay),
                      SizedBox(height: 20),
                      Obx(
                        ()=> ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: appController.count.value,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(Icons.access_time),
                                title: Text('Dose ${index + 1}'),
                                trailing: Icon(Icons.chevron_right),
                              );
                            }
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildTimingChip('Before Food', timing == 'Before Food'),
                          _buildTimingChip('After Food', timing == 'After Food'),
                          _buildTimingChip('Before Sleep', timing == 'Before Sleep'),
                        ],
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.indigoAccent)),
                          onPressed: () {
                            if (_searchController.text.isNotEmpty) {
                              final medicine = Medicine(
                                name: _searchController.text,
                                timing: timing,
                                beforeAfter: timing,
                                day: 1,
                                status: 'Left',
                                time: DateTime.now(),
                                color: selectedColor,
                                type: selectedType,
                                quantity: quantity,
                                totalCount: totalCount,
                                frequency: frequency,
                                timesPerDay: appController.tpd.value,
                                compartment: selectedCompartment,
                              );
      
                              appController.addMedicine(medicine);
                              appController.currScreen.value="home";
                              Get.back(); // Use Get.back() instead of Navigator
                            }
                          }, child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 25),),
                        ),
                      )
                    ],
      
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildTypeOption(String type, IconData icon) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedType = type;
        });
      },
      child: Column(
        children: [
          Icon(icon, color: selectedType == type ? Colors.blue : Colors.grey),
          Text(type, style: TextStyle(
              color: selectedType == type ? Colors.blue : Colors.grey
          )),
        ],
      ),
    );
  }

  Widget _buildDateField(String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildfreqDropdownField(String label, String value,List<String> freq) {
    return DropdownButtonFormField<String>(
      value: value, // Initial value
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: freq.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          value=newValue!;
        });
      },
    );
  }

  Widget _buildtimesinaDayDropdownField(String label, String value,List<String> timesInaDay,) {
    return DropdownButtonFormField<String>(
      value: appController.tpd.value, // Initial value
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      items: timesInaDay.map((String item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (newValue) {

        if(newValue==timesInaDay[0])
          {
            appController.count.value=1;
          }else if(newValue==timesInaDay[1]) {
          appController.count.value = 2;
        }else if(newValue==timesInaDay[2]){
          appController.count.value=3;
        }else {
          appController.count.value = 4;
        }
        setState(() {
          appController.tpd.value=newValue!;
        });
      },
    );
  }

  Widget _buildTimingChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (bool selected) {
        setState(() => timing = selected ? label : timing);
      },
    );
  }
}