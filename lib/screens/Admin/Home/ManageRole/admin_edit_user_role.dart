import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';

class AdminEditUserRole extends StatefulWidget {
  final int requestId;
  final String e_passport;
  final int roleId;

  const AdminEditUserRole({
    Key? key,
    required this.requestId,
    required this.e_passport,
    required this.roleId,
  }) : super(key: key);

  @override
  State<AdminEditUserRole> createState() => _AdminEditUserRoleState();
}

class _AdminEditUserRoleState extends State<AdminEditUserRole> {
  late TextEditingController _ePassportController;

  int selectedRoleId = 0;

    @override
  void initState() {
    super.initState();
    _ePassportController = TextEditingController(text: widget.e_passport);
    selectedRoleId = widget.roleId; 
  }

  @override
  void dispose() {
    _ePassportController.dispose();
    super.dispose();
  }

  final ApiService apiService = ApiService();

  Future<void> _submitRole() async {
  final e_passport = _ePassportController.text.trim();

  if (e_passport.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill out all fields.')),
    );
    return;
  }

  try {
      
    print("e_passport: ${_ePassportController.text.trim()}");
    print("selectedRoleId: $selectedRoleId");
    print("requestId: ${widget.requestId}");
    await apiService.editRole(
      userId: widget.requestId,
      username: e_passport,
      role_id: selectedRoleId,
    );

    // Show a success dialog
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("Role added successfully."),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error adding reward.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
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
          'แก้ไขสิทธิให้กับ\nเจ้าหน้าที่',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            height: 1,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffEAEAEA),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
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
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 6),
                                    child: TextField(
                                      controller: _ePassportController,
                                      enabled: false,
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 18,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'e-Passport',
                                        hintStyle: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ), 
                                  SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _buildRoleButton("เจ้าหน้าที่" , 2),
                                        SizedBox(width: 10),
                                        _buildRoleButton("อาจารย์", 3),
                                      ],
                                    ),
                                  SizedBox(height: 20),
                                  InkWell(
                                  onTap: _submitRole,
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
                    )),
              )
            ],
          ),
    );
  }


Widget _buildRoleButton(String role, int roleId) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRoleId = roleId;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: selectedRoleId == roleId ? Color(0xff00154B) : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              role,
              style: TextStyle(
                color: selectedRoleId == roleId ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.circle,
              size: 12,
              color: selectedRoleId == roleId ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
