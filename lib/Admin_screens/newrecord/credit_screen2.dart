import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneal_admin_panel/Admin_screens/Models/admindata.dart';
import 'package:oneal_admin_panel/Admin_screens/Models/cateogryModel.dart';
import 'package:oneal_admin_panel/Admin_screens/Models/members.dart';
import 'package:oneal_admin_panel/Widgets/large_btn.dart';
import 'package:oneal_admin_panel/Widgets/small_btn.dart';

import '../welcome_back_screen.dart';
import 'package:http/http.dart' as http;

class CreditScreen2 extends StatefulWidget {
  CreditScreen2({this.paynowdone, this.paynowname, required this.category, required this.memID});
  final double? paynowdone;
  final String? paynowname;
  final String category;
  final String memID;

  @override
  State<CreditScreen2> createState() => _CreditScreen2State();
}

class _CreditScreen2State extends State<CreditScreen2> {
  final user = FirebaseAuth.instance.currentUser;
  String catID = '';
  String Date1 = '';
  int? amount;
  bool secVisible = true;
  String paymentType = '';
  TextEditingController admintext = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController transtype = TextEditingController();
  TextEditingController ammount = TextEditingController();
  TextEditingController searchC = TextEditingController();
  TextEditingController reason = TextEditingController();
  bool isdebit = false;

  //final item = ['Single Payment'];
  String dropdownValue = 'Single Payment';
  AdminData? adminData;
  List<CategoryModel> catmodel = [];
  double Currentbalance = 0;
  final _formKey = GlobalKey<FormState>();
  List<MemberData> dummy = [];
  List<MemberData> memData = [];
  Future getmember() async {
    QuerySnapshot snap = await FirebaseFirestore.instance.collection('Admin').get();
    setState(() {
      adminData = AdminData.fromMap(snap.docs.first.data() as Map<String, dynamic>);
    });
    // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Members').get();
    // memData = snapshot.docs.map((e) => MemberData.fromMap(e.data() as Map<String, dynamic>)).toList();
    // dummy = memData;
    // QuerySnapshot snapshotcat = await FirebaseFirestore.instance.collection('Categories').get();
    // catmodel =
    //     snapshotcat.docs.map((e) => CategoryModel.fromMap(e.data() as Map<String, dynamic>)).toList();
    setState(() {});
  }

  @override
  void initState() {
    getmember();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screesize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Padding(
          padding: const EdgeInsets.only(top: 4.5),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xff83050C),
              statusBarIconBrightness: Brightness.light, // For Android (dark icons)
            ),
            leading: IconButton(
              onPressed: () {
                setState(() {
                  ammount.clear();
                  transtype.clear();
                  admintext.clear();
                });
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => WelcomeBack()));
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Color(0xff83050C),
            title: Text(
              'Credit',
              style:
                  const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23.0, right: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ENTER AMOUNT',
                      style: const TextStyle(
                          color: Color(0xff83050C), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                      height: screesize.height / 16,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffDDDCDC),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        // validator: (_) {
                        //   if (_ == null || _ == '') {
                        //     return ("Enter Amount");
                        //   } else
                        //     return null;
                        // },
                        controller: ammount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Color(0xffC4C4C4), fontSize: 15, fontWeight: FontWeight.w400),
                            hintText: '${widget.paynowdone}',
                            contentPadding: const EdgeInsets.fromLTRB(22, 15, 0, 15),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 23.0, right: 23, top: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PAYMENT TYPE',
                      style: const TextStyle(
                          color: const Color(0xff83050C), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Container(
                        height: screesize.height / 16,
                        width: screesize.width / 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: const Color(0xffDDDCDC),
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 22),
                            child: DropdownButton<String>(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: const Color(0xff83050C),
                                size: 20,
                              ),
                              value: dropdownValue,
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: const Color(0xffC4C4C4), fontSize: 15),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  if (dropdownValue == 'Catagory Payment') {
                                    secVisible = false;
                                    paymentType = 'Catagory Payment';
                                  } else {
                                    secVisible = true;
                                    paymentType = 'Single Payment';
                                  }
                                });
                              },
                              items: <String>[
                                'Single Payment',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Visibility(
                  visible: secVisible,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23.0, right: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'STUDENT NAME',
                              style: TextStyle(
                                  color: Color(0xff83050C), fontSize: 12, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            InkWell(
                              onTap: () {
                                // bottomshet(context);
                              },
                              child: Container(
                                height: screesize.height / 16,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffDDDCDC),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(22, 12, 0, 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          widget.paynowname!,
                                          style: TextStyle(
                                              color: Color(0xffC4C4C4),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 23.0, right: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SELECT TRANSACTION CATEGORY',
                      style: const TextStyle(
                          color: const Color(0xff83050C), fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    InkWell(
                      onTap: () {
                        //Categoryshet(context);
                      },
                      child: Container(
                        //height: screesize.height / 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffDDDCDC),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(22, 12, 0, 10),
                            child: Row(
                              children: [
                                Text(
                                  widget.category,
                                  style: const TextStyle(
                                      color: const Color(0xffC4C4C4),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 135,
                                ),
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 120,
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Admin').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final mydata = snapshot.data!.docs;
                      return Center(
                        child: Largebtn(
                            txt: 'PREVIEW',
                            ontap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Please Confirm Transaction'),
                                  content: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Amount: ${widget.paynowdone}'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Payment Type: ${dropdownValue}'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Student Name: ${widget.paynowname}'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text('Transaction Category:'),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text('${widget.category}'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    MaterialButton(
                                      color: Color(0xff83050C),
                                      height: screesize.height / 15,
                                      minWidth: 300,
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(13)),
                                      onPressed: () async {
                                        createUserDatabase(adminData!.addedBy!);
                                        updatebalance(widget.memID).whenComplete(() => //issue found
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => WelcomeBack())));
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    MaterialButton(
                                      color: Colors.black,
                                      height: screesize.height / 15,
                                      minWidth: 300,
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(13)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            clr: Color(0xff83050C)),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff83050C),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  //getting allmember

  //saving new record
  Future createUserDatabase(String compID) async {
    Map<String, dynamic> data = {
      "Ammount": widget.paynowdone,
      "Payment Type": dropdownValue,
      "typetrans": "Credit",
      "parentName": widget.paynowname,
      "Parentid": widget.memID,
      "Transaction Category": widget.category,
      "date": DateTime.now(),
      'CompId': compID,
    };
    await FirebaseFirestore.instance.collection("NewRecord").doc().set(data);
  }

  //updating balance

  Future updatebalance(String memID) async {
    try {
      FirebaseFirestore.instance.collection('Members').doc(memID).update({
        "earning_balance": FieldValue.increment(widget.paynowdone!),
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  //updating balance in category payments
  Future updatebalanceCategory(String memID) async {
    await FirebaseFirestore.instance.collection('Members').doc(memID).update({
      "earning_balance": FieldValue.increment(double.parse(ammount.text.trim())),
    });
  }
}
