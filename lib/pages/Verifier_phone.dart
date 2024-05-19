import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

void main() => runApp(const MaterialApp(home: VerifierPhone()));

class VerifierPhone extends StatelessWidget {
  const VerifierPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PinCodeVerificationScreen(
        phoneNumber: "+8801376221100", // a random number, please don't call xD
      ),
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  const PinCodeVerificationScreen({Key? key, this.phoneNumber}) : super(key: key);

  final String? phoneNumber;

  @override
  State<PinCodeVerificationScreen> createState() => _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(223, 245, 241, 1.0),
        title: Image.asset('assets/images/pogo.png', width: 120, height: 60),
      ),
      body: GestureDetector(
        onTap: () {},
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Phone Number Verification',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 8),
                child: RichText(
                  text: TextSpan(
                    text: "Enter the code sent to ",
                    children: [
                      TextSpan(
                        text: "${widget.phoneNumber}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 6) {
                        return "Please enter the full code";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      activeColor: Colors.green[900],  // color for the active border
                      selectedColor: const Color.fromRGBO(5, 12, 79, 1.0),  // color for the selected border
                      inactiveColor: Colors.grey,  // color for the inactive border
                      errorBorderColor: Colors.red,  // change this to the desired error color
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: const TextStyle(
                    color: Colors.red,  // You can change this to your desired error text color
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => snackBar("OTP resend!!"),
                    child: const Text(
                      "RESEND",
                      style: TextStyle(
                        color: Color.fromRGBO(44, 176, 145, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 14),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(44, 176, 145, 1.0),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(44, 176, 145, 1.0),
                      offset: const Offset(1, -2),
                      blurRadius: 5,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(44, 176, 145, 1.0),
                      offset: const Offset(-1, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ButtonTheme(
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      // conditions for validating
                      if (currentText.length != 6 || currentText != "123456") {
                        errorController!.add(ErrorAnimationType.shake); // Triggering error shake animation
                        setState(() => hasError = true);
                      } else {
                        setState(() {
                          hasError = false;
                          snackBar("OTP Verified!!");
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        "VERIFY".toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: TextButton(
                      child: const Text(
                        "Clear",
                        style: TextStyle(
                          color: Color.fromRGBO(5, 12, 79, 1.0),
                        ),
                      ),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      child: const Text("Set Text",
                        style: TextStyle(
                        color: Color.fromRGBO(5, 12, 79, 1.0),
                      ),),
                      onPressed: () {
                        setState(() {
                          textEditingController.text = "123456";
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
