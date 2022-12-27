import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  _Payment createState() => _Payment();
}

class _Payment extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, services, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromRGBO(22, 199, 154, 1),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 27.5,
                      color: Color.fromRGBO(25, 69, 107, 1),
                    ),
                  ),
                ),

                const SizedBox(width: 30),

                const Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: Text(
                    'Payment',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(25, 69, 107, 1),
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: true,
          ),

          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.png'),
              ),
            ),

            child: const Center(
              child: SizedBox(
                width: 250,
                height: 250,
                child: Image(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/code.jpg'),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}