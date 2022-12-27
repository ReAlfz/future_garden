import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_garden/config/payment.dart';
import 'package:future_garden/config/services.dart';
import 'package:future_garden/detail_furniture.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  _Card createState() => _Card();
}

class _Card extends State<Cart> {
  var totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Consumer<Services>(
      builder: (context, services, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 2,
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromRGBO(22, 199, 154, 1),
            centerTitle: true,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                const Flexible(
                  flex: 3,
                  fit: FlexFit.tight,
                  child: Text(
                    'Your Cart',
                    style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 1,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(25, 69, 107, 1),
                    ),
                  ),
                ),

                const Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: SizedBox(),
                ),
              ],
            ),
          ),

          body: Container(
            height: media.size.height,
            width: media.size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background.png'),
              ),
            ),

            child: Column(
              children: [
                Flexible(
                  flex: 9,
                  fit: FlexFit.tight,
                  child: ListView.builder(
                      itemCount: services.list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Details(
                                dataItem: services.list[index],
                              ),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: const Color.fromRGBO(248, 241, 241, 1.0),
                            ),
                            height: 125,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 2.5,
                              vertical: 7.5,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.loose,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(services.list[index].images),
                                      ),
                                      borderRadius: const BorderRadius.horizontal(
                                        left: Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                    flex: 3,
                                    fit: FlexFit.loose,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 7.5,
                                          vertical: 5
                                      ),

                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            flex: 5,
                                            fit: FlexFit.tight,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                services.list[index].title,
                                                maxLines: 3,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(25, 69, 107, 1),
                                                ),
                                              ),
                                            ),
                                          ),

                                          Flexible(
                                            flex: 5,
                                            fit: FlexFit.tight,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                Currency.convertToIDR(services.list[index].price),
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color.fromRGBO(25, 69, 107, 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ),

                                Flexible(
                                    flex: 1,
                                    fit: FlexFit.loose,
                                    child: GestureDetector(
                                      onTap: () => services.removeListServices(index),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(15),
                                            )
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'Remove',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(248, 241, 241, 1.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),

                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Container(
                    color: const Color.fromRGBO(22, 199, 154, 1),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 7,
                          fit: FlexFit.tight,
                          child: Row(
                            children: [
                              const Flexible(
                                flex: 6,
                                fit: FlexFit.tight,
                                child: Text(
                                  'Total Price',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),

                              Flexible(
                                flex: 4,
                                fit: FlexFit.tight,
                                child: Text(
                                  Currency.convertToIDR(
                                      services.list.isNotEmpty
                                          ? services.list.map((e) => e.price).reduce((value, element) => value + element)
                                          : 0
                                  ),
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: ElevatedButton(
                            onPressed: services.list.isNotEmpty
                                ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const Payment())
                              );
                            } : null,
                            child: const Text('Checkout'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}