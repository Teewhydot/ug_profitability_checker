import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UgChecker(),
    );
  }
}



class UgChecker extends StatefulWidget {
  const UgChecker({Key? key}) : super(key: key);

  @override
  State<UgChecker> createState() => _UgCheckerState();
}

class _UgCheckerState extends State<UgChecker> {
  int capital = 0;
  double equivalentUgx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UGX Profitability Checker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 15,
            validator: ValidationBuilder()
                .minLength(5)
                .maxLength(15)
                .build(),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
            },
            decoration: const InputDecoration(
              hintText: 'Enter your capital',
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
            ),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: 15,
            validator: ValidationBuilder()
                .minLength(5)
                .maxLength(15)
                .build(),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (value) {
            },
            decoration: const InputDecoration(
              hintText: 'Enter equivalent UGX displayed on Chipper Cash',
              contentPadding: EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 20.0),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                  },
                  child: const Text('Check'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
