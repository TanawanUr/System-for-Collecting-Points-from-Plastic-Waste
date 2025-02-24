import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class StaffAddReward extends StatefulWidget {
  const StaffAddReward({super.key});

  @override
  State<StaffAddReward> createState() => _StaffAddRewardState();
}

class _StaffAddRewardState extends State<StaffAddReward> {
   // Controllers for the text fields.
  final TextEditingController _rewardNameController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final ApiService apiService = ApiService();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitReward() async {
  final rewardName = _rewardNameController.text.trim();
  final pointsText = _pointsController.text.trim();
  final quantityText = _quantityController.text.trim();

  if (rewardName.isEmpty || pointsText.isEmpty || quantityText.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill out all fields.')),
    );
    return;
  }

  final pointsRequired = int.tryParse(pointsText);
  final rewardQuantity = int.tryParse(quantityText);

  if (pointsRequired == null || rewardQuantity == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please enter valid numbers for points and quantity.')),
    );
    return;
  }

  try {
    // Call your API to add the reward
    await apiService.addReward(
      rewardName: rewardName,
      rewardQuantity: rewardQuantity,
      pointsRequired: pointsRequired,
      rewardType: "stationery", // or adjust based on your UI
      imageFile: _selectedImage,
    );

    // Show a success dialog
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Reward added successfully."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Pop the current screen to go back home
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  } catch (error) {
    // If the API call fails, show an error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding reward.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height ;

    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: AppBar(
        backgroundColor: Color(0xff00154B),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'เพิ่มของรางวัล',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: availableHeight),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffEAEAEA),
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                                bottom: Radius.circular(25),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
 // Image display container
                              InkWell(
                                onTap: _pickImage,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: _selectedImage == null
                                          ? Color.fromARGB(255, 214, 214, 214)
                                          : null,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25),
                                        bottom: Radius.circular(25),
                                      ),
                                      image: _selectedImage != null
                                          ? DecorationImage(
                                              image: FileImage(_selectedImage!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: _selectedImage == null
                                        ? Center(
                                            child: Text(
                                              "เพิ่มรูป",
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: TextField(
                                    controller: _rewardNameController,
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'ชื่อของรางวัล',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: TextField(
                                    controller: _pointsController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'จำนวนแต้ม',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      suffixText:
                                          'แต้ม', // This text appears at the end
                                      suffixStyle: TextStyle(
                                        color: Color.fromARGB(255, 80, 80, 80),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 6),
                                  child: TextField(
                                    controller: _quantityController,
                                    keyboardType: TextInputType.number,
                                    scrollPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 18,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'จำนวนของรางวัล',
                                      hintStyle: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      suffixText:
                                          'ชิ้น', // This text appears at the end
                                      suffixStyle: TextStyle(
                                        color: Color.fromARGB(255, 80, 80, 80),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                onTap: _submitReward,
                                child: Container(
                                  width: 90,
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      "ยืนยัน",
                                      style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF9CA10),
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10),
                                      bottom: Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xffEEC004),
                                        spreadRadius: 1,
                                        blurRadius: 0,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
