import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class StaffEditReward extends StatefulWidget {

  final int rewardId;
  final String rewardName;
  final int rewardQuantity;
  final int pointsRequired;
  final String rewardImageUrl; // Full URL or filename, whichever you use
  final String rewardType; // For example: "stationery"

  const StaffEditReward({
    Key? key,
    required this.rewardId,
    required this.rewardName,
    required this.rewardQuantity,
    required this.pointsRequired,
    required this.rewardImageUrl,
    required this.rewardType,
  }) : super(key: key);

  @override
  _StaffEditRewardState createState() => _StaffEditRewardState();
}

class _StaffEditRewardState extends State<StaffEditReward> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _rewardNameController;
  late TextEditingController _quantityController;
  late TextEditingController _pointsController;
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _rewardNameController = TextEditingController(text: widget.rewardName);
    _quantityController = TextEditingController(text: widget.rewardQuantity.toString());
    _pointsController = TextEditingController(text: widget.pointsRequired.toString());
  }

  @override
  void dispose() {
    _rewardNameController.dispose();
    _quantityController.dispose();
    _pointsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateReward() async {
    if (!_formKey.currentState!.validate()) return;

    final rewardName = _rewardNameController.text.trim();
    final rewardQuantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    final pointsRequired = int.tryParse(_pointsController.text.trim()) ?? 0;

    try {
      await apiService.updateReward(
        rewardId: widget.rewardId,
        rewardName: rewardName,
        rewardQuantity: rewardQuantity,
        pointsRequired: pointsRequired,
        rewardType: widget.rewardType, // or allow editing if needed
        imageFile: _selectedImage, // if the user picked a new image
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reward updated successfully')),
      );
      Navigator.of(context).pop(); // Go back to previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update reward')),
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
          'แก้ไขของรางวัล',
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
          child: Form(
            key: _formKey,
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
                                    InkWell(
                                      onTap: _pickImage,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: Container(
                                          width: 200,
                                          height: 200,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: _selectedImage != null
                                              ? Image.file(_selectedImage!, fit: BoxFit.cover)
                                              : widget.rewardImageUrl.isNotEmpty
                                                  ? Image.network(widget.rewardImageUrl, fit: BoxFit.cover)
                                                  : Center(child: Text("Tap to select image")),
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 6),
                                    child: TextField(
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      controller: _rewardNameController,
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
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      controller: _pointsController,
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
                                      scrollPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      controller: _quantityController,
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
                                    onTap: () {
                                      _updateReward();
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 35,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ยืนยัน",
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                        ],
                                      )),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF9CA10),
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10),
                                              bottom: Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffEEC004),
                                              spreadRadius: 1,
                                              blurRadius: 0,
                                              offset: const Offset(0, 2),
                                            )
                                          ]),
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
      ),
    );
  }
}
