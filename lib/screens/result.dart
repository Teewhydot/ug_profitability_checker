import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final double profit;
  final double profitPercentage;
  final double p2pRate;
  final double btcPrice;
  final double btcAmount;
  final double ugxToBtcPrice;
  final double equivalentUsdtReceived;

  const ResultsPage(
      {super.key,
      required this.profit,
      required this.profitPercentage,
      required this.btcPrice,
      required this.equivalentUsdtReceived,
      required this.p2pRate, required this.btcAmount, required this.ugxToBtcPrice});

  @override
  Widget build(BuildContext context) {
    const boldTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );

    const normalTextStyle = TextStyle(
      fontSize: 20,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profit > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 90,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'This trade is profitable',
                      style: boldTextStyle,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.dangerous,
                      color: Colors.redAccent,
                      size: 90,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'This trade is not profitable',
                      style: boldTextStyle,
                    ),
                  ],
                ),
          const Center(
            child: Text('Results', style: boldTextStyle),
          ),
          const SizedBox(
            height: 20,
          ),
          profit > 0
              ? Text('Profit:  ${profit.toStringAsFixed(1)}', style: normalTextStyle)
              : Text('Loss:  ${profit.toStringAsFixed(1)}', style: normalTextStyle),
          const SizedBox(
            height: 20,
          ),
          profitPercentage > 0
              ? Text('Profit Percentage:  ${profitPercentage.toStringAsFixed(1)}',
                  style: normalTextStyle)
              : Text('Loss Percentage:  ${profitPercentage.toStringAsFixed(1)}',
                  style: normalTextStyle),
          const SizedBox(
            height: 20,
          ),
          Text('P2P Rate:  $p2pRate', style: normalTextStyle),
          const SizedBox(
            height: 20,
          ),
          Text('BTC Price:  $btcPrice', style: normalTextStyle),
          const SizedBox(
            height: 20,
          ),
          Text('Btc amount:   $btcAmount',style: normalTextStyle,),
          const SizedBox(
            height: 20,
          ),
          Text('Ugx to btc rate:   $ugxToBtcPrice',style:  normalTextStyle,),
          const SizedBox(
            height: 20,
          ),
          Text('Equivalent usdt received:   $equivalentUsdtReceived',style:  normalTextStyle,),
        ],
      ),
    );
  }
}
