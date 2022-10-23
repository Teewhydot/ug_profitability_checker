// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ug_profitability_checker/screens/result.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  double capital = 0;
  double equivalentUgx = 0;
  double btcToUgxPrice = 73023087;
  double profit = 0;
  double profitPercentage = 0;
  double p2pRate = 0;
  double btcPrice = 0;

  Future checkProfitability(double ugxExchangeRate) async {
    //   CALCULATE UGX TO BTC RATE
    double btcAmount = (equivalentUgx / btcToUgxPrice) - 0.0001;
    final http.Response response = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=USDTNGN'));
    final http.Response response2 = await http.get(Uri.parse(
        'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'));
    if (response.statusCode == 200 && response2.statusCode == 200) {
      // decode first request to get usdt price
      var decodedResponse1 = jsonDecode(response.body);
      // decode second request to get btc price
      var decodedResponse2 = jsonDecode(response2.body);
      // decode the second request and get the price of BTC in USDT
      btcPrice = double.parse(decodedResponse2['price']);
      // decode the first request to get the price of usdt in ngn
      var usdToNairaRate = double.parse(decodedResponse1['price']);
      //calculate btc price in naira
      var nairaBtcPrice = btcPrice * usdToNairaRate;
      // mock way to get the current usdt price in binance p2p market
      p2pRate = usdToNairaRate - 10;
      //after selling on binance
      double nairaEquivalent = btcAmount * nairaBtcPrice;
      profit = nairaEquivalent - capital;
      profitPercentage = (profit / capital) * 100;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UGX Profitability Checker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                validator:
                    ValidationBuilder().minLength(5).maxLength(15).build(),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    capital = double.parse(value);
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your capital',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 15,
                validator:
                    ValidationBuilder().minLength(5).maxLength(15).build(),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) {
                  setState(() {
                    equivalentUgx = double.parse(value);
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter equivalent UGX displayed on Chipper Cash',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final ugxToNgnRate = capital / equivalentUgx;
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _isLoading = true;
                          });
                          await checkProfitability(ugxToNgnRate);
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultsPage(
                                  btcPrice: btcPrice,
                                  p2pRate: p2pRate,
                                  profit: profit,
                                  profitPercentage: profitPercentage),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                        }
                      },
                      child: _isLoading
                          ? const SizedBox(
                              height: 25,
                              width: 50,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                strokeWidth: 2,
                                backgroundColor: Colors.transparent,
                                colors: [Colors.white],
                              ),
                            )
                          : const Text('Check'),
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
