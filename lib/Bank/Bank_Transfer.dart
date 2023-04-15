import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Bank_Transfer extends StatelessWidget {
  const Bank_Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffF89F5B),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(1.0, 2.0))
                  ]),
              height: 30,
              width: MediaQuery.of(context).size.width / 2.2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            "assets/Back Arrow.svg",
                            fit: BoxFit.scaleDown,
                          )),
                    ),
                    Text(
                      "Bank Transfer",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          SvgPicture.asset("assets/AtmCard.svg"),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Card Holder",
                style: TextStyle(fontSize: 12, color: Color(0xff8F92A1)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      "assets/P-Bank.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "Oguz Bulbul",
                    hintStyle:
                        TextStyle(fontSize: 15, color: Color(0xff233245)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff8F92A1))))),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Card Number",
                style: TextStyle(fontSize: 12, color: Color(0xff8F92A1)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
                decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      "assets/C-num.svg",
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: "888532112155",
                    hintStyle:
                        TextStyle(fontSize: 15, color: Color(0xff233245)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff8F92A1))))),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Expiry Date",
                      style: TextStyle(fontSize: 12, color: Color(0xff8F92A1)),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 140),
                child: Text(
                  "CCV",
                  style: TextStyle(fontSize: 12, color: Color(0xff8F92A1)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width / 2.25,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: SvgPicture.asset(
                              "assets/calender.svg",
                              fit: BoxFit.scaleDown,
                            ),
                            hintText: "01/03/2023",
                            hintStyle: TextStyle(
                                fontSize: 15, color: Color(0xff233245)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xff8F92A1))))),
                  ),
                ),
              ),
              SizedBox(width: 25),
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width / 2.6,
                  child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/lock.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: "0 0 0",
                          hintStyle:
                              TextStyle(fontSize: 15, color: Color(0xff233245)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0xff8F92A1))))),
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
          SizedBox(
            width: 140,
            height: 32,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Color(0xff9C3587),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32))),
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 11, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
