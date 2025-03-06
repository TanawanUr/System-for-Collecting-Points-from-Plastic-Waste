import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Admin/Home/ManageRole/admin_add_user_role.dart';
import 'package:system_for_collecting_points_from_plastic_waste/screens/Admin/Home/ManageRole/admin_edit_user_role.dart';
import 'package:system_for_collecting_points_from_plastic_waste/services/api-service.dart';
import 'package:system_for_collecting_points_from_plastic_waste/widget/getStaff.dart';

class AdminManageRolePage extends StatefulWidget {
  const AdminManageRolePage({super.key});

  @override
  State<AdminManageRolePage> createState() => _AdminManageRolePageState();
}

class _AdminManageRolePageState extends State<AdminManageRolePage> {
  List<getStaff> getStaffItem = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    getStaffProfessor();
  }

  Future<void> getStaffProfessor() async {
    try {
      List<Map<String, dynamic>> data = await apiService.getStaff();
      setState(() {
        getStaffItem = data.map((item) {
          return getStaff(
            requestId: item['user_id'],
            ePassport: item['e_passport'],
            fullname: "${item['firstname']} ${item['lastname']}",
            roleId: item['role_id']
          );
        }).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching history: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _confirmAndDelete(BuildContext context, int requestId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Reward"),
          content: Text("Are you sure you want to delete this reward?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // cancel
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // confirm
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await apiService.deleteRole(requestId);
        // Show a success message (optional)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reward deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete reward')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00154B),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              toolbarHeight: 70,
              backgroundColor: Color(0xff00154B),
              leading: IconButton(
                icon: FaIcon(FontAwesomeIcons.angleLeft, color: Colors.white),
                // icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                'จัดการสิทธิ์เจ้าหน้าที่',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  height: 1.1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEAEAEA),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text("ชื่อ - นามสกุล",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5)),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text("บทบาท",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.5)),
                                ),
                              ),
                              Expanded(
                              flex: 1,
                                child: SizedBox(width: 10)),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(0xffEAEAEA),
                        thickness: 1,
                        height: 1.5,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: getStaffItem.length,
                          itemBuilder: (context, index) {
                            final item = getStaffItem[index];
                            return Column(
                              children: [
                                Container(
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, top: 10, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(item.fullname,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: -0.5)),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Text(item.roleId == 2 ? 'เจ้าหน้าที่' 
                                                : item.roleId == 3 ? 'อาจารย์' : '',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w700,
                                                      letterSpacing: -0.5)
                                                      ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                  AdminEditUserRole(
                                                                    requestId: item.requestId,
                                                                    e_passport: item.ePassport,
                                                                    roleId: item.roleId,
                                                                  )),
                                                          ).then((_){
                                                                  PaintingBinding.instance.imageCache.clear();
                                                                  getStaffProfessor();
                                                                });
                                                              },
                                                        child: Container(
                                                          width: 30,
                                                          height: 24,
                                                          child: Center(
                                                              child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons.userEdit,
                                                                size: 17,
                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                              ),
                                                            ],
                                                          )),
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffFCCA00),
                                                              shape: BoxShape.rectangle,
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(10),
                                                                      bottom: Radius
                                                                          .circular(
                                                                              10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      Color(0xffEEC004),
                                                                  spreadRadius: 1,
                                                                  blurRadius: 0,
                                                                  offset: const Offset(
                                                                      0, 2),
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                  InkWell(
                                                    onTap: () {
                                                    _confirmAndDelete(context, item.requestId).then((_){
                                                        PaintingBinding.instance.imageCache.clear();
                                                        getStaffProfessor();
                                                      });
                                                            },
                                                        child: Container(
                                                          width: 30,
                                                          height: 24,
                                                          child: Center(
                                                              child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              FaIcon(
                                                                FontAwesomeIcons.userAltSlash,
                                                                size: 16,
                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                              ),
                                                            ],
                                                          )),
                                                          decoration: BoxDecoration(
                                                              color: Color(0xffDE412F),
                                                              shape: BoxShape.rectangle,
                                                              borderRadius:
                                                                  BorderRadius.vertical(
                                                                      top: Radius
                                                                          .circular(10),
                                                                      bottom: Radius
                                                                          .circular(
                                                                              10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color:
                                                                      Color(0xffBB3525),
                                                                  spreadRadius: 1,
                                                                  blurRadius: 0,
                                                                  offset: const Offset(
                                                                      0, 2),
                                                                )
                                                              ]),
                                                        ),
                                                      ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ),
                                Divider(
                                  color: Color(0xffEAEAEA),
                                  thickness: 1,
                                  height: 1.5,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
           Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                  const AdminAddUserRole()),
          ).then((_){
                  PaintingBinding.instance.imageCache.clear();
                  getStaffProfessor();
                });
              },
        backgroundColor: Color(0xffFCCA00),
        shape: CircleBorder(),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

    );
  }
}