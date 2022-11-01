import 'package:flutter/material.dart';
import 'package:oneal_admin_panel/Admin_screens/Models/newRecord.dart';
import 'package:oneal_admin_panel/models/depositadd.dart';
import 'package:oneal_admin_panel/models/records.dart';
import 'package:intl/intl.dart';

class PopUp extends StatefulWidget {
  const PopUp({Key? key, required this.data});

  final NewRecordData data;

  @override
  State<PopUp> createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return widget.data != null
        ? Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              width: 276,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.5),
                    child: Row(
                      children: [
                        if (widget.data.typetrance == 'Credit')
                          Image.asset(
                            'assets/icons/Tfee.png',
                            scale: 5,
                            color: Color(0xff18D193),
                          ),
                        if (widget.data.typetrance == 'Debit')
                          Image.asset(
                            'assets/icons/debit.png',
                            scale: 5,
                          ),
                        SizedBox(width: 15.85),
                        if (widget.data.typetrance == 'Credit')
                          Text(
                            'Credit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff18D193),
                            ),
                          ),
                        if (widget.data.typetrance == 'Debit')
                          Text(
                            'Debit',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF83050C),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        if (widget.data.typetrance == 'Credit')
                          Text(
                            '\$${widget.data.amount}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff18D193),
                            ),
                          ),
                        if (widget.data.typetrance == 'Debit')
                          Text(
                            '\$${widget.data.amount}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFE83632),
                            ),
                          ),
                        Text(
                          '${DateFormat('dd MMM yyyy').format(widget.data.date!.toDate())}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF959595),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
