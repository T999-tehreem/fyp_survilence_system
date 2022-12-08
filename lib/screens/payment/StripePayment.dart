import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_sms/flutter_sms.dart';


class StripePayment extends StatefulWidget {

  String? mobileNumber;
  StripePayment({Key? key,required this.mobileNumber}) : super(key: key);

  @override
  State<StripePayment> createState() => _StripePaymentState();
}

class _StripePaymentState extends State<StripePayment> {
  TextEditingController ID = TextEditingController();
  Map<String, dynamic>? paymentIntent;
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents,)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
  Widget textwidget(TextEditingController ctr,hinttext){
    return  SizedBox(
      height:40,
      child: TextFormField(
        keyboardType: hinttext=='Phoneno'||hinttext=='CNIC'? TextInputType.number:TextInputType.name,
        style: TextStyle(color: Colors.black),
        controller: ctr,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          hintText: '$hinttext',  hintStyle: TextStyle(fontSize: 15, color: Colors.white54),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors. white),
            borderRadius: BorderRadius.all(Radius.circular(10),
            ),
          ),
        ),
      ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xb00d4d79),
        title: const Text('Payment'),
      ),

      body: Center(

        child: Column(
          children: [
            textwidget(ID,'Driver ID'),
            const SizedBox(
              height: 20,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(40),
              color: Color(0xb00b679b),
              child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(52, 15, 52, 15),
                minWidth: MediaQuery.of(context).size.width * 0.3,
                onPressed: () async{
                  print("pressed");
                  makePayment();
                },
                child: const Text(
                  "Make Payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),),
            ),
          ],
        )
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(ID.text, 'USD');
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Bareera Iqbal')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
      ).then((value){
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green,),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
        String message = "This is a test message!";
        List<String> recipents = [widget.mobileNumber.toString()];

        _sendSMS(message, recipents);
        paymentIntent = null;

      }).onError((error, stackTrace){
        print('Error is:--->$error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51LkMxXLNRgnILJXExi2DPmZTDOuMtaVZawYoxK9kdkyfPDNMavWdap7srzlkvuvjCgxdN92HF4HwtuRPr6UDiSMM00vlMOS7zu',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100 ;
    return calculatedAmout.toString();
  }

}