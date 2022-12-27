import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:future_garden/config/model.dart';
import 'package:future_garden/config/services.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Details extends StatefulWidget {
  final DataItem dataItem;
  const Details({super.key, required this.dataItem});

  @override
  _Detail createState() => _Detail();
}

class _Detail extends State<Details> {
  double containerHeight = 0;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Consumer<Services>(
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

                Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: Text(
                    widget.dataItem.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
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
            child: Stack(
              children: [
                Container(
                  color: Colors.red,
                  height: media.size.height * 0.6,
                  child: Image(
                    fit: BoxFit.cover,
                    width: media.size.width,
                    image: NetworkImage(widget.dataItem.images),
                  ),
                ),

                SlidingUpPanel(
                  color:Colors.transparent,
                  minHeight: media.size.height * 0.3,
                  maxHeight: media.size.height * 0.6125,
                  panel: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(
                              10, 25, 10, 5
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.dataItem.title,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                              left: 7.5,
                              right: 7.5
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              RatingBarIndicator(
                                rating: double.parse(widget.dataItem.rating),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemSize: 30,
                                itemCount: 5,
                              ),

                              IconButton(
                                icon: const Icon(
                                  CupertinoIcons.cart_badge_plus,
                                  size: 35,
                                ),
                                onPressed: () {
                                  services.addListServices(widget.dataItem);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Product added'),
                                    )
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 7.5,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Currency.convertToIDR(widget.dataItem.price),
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                            top: 30,
                            left: 7.5,
                            right: 7.5
                          ),
                          child: const Text(
                            'Description',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        Container(
                          height: media.size.height * 0.1,
                          padding: const EdgeInsets.only(
                              top: 15,
                              left: 7.5,
                              right: 7.5
                          ),
                          child: Text(
                            widget.dataItem.description,
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),

                        if (widget.dataItem.material.isNotEmpty && widget.dataItem.color.isNotEmpty && widget.dataItem.size.isNotEmpty)
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 7.5,
                                    right: 7.5
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Bahan : ${widget.dataItem.material}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 7.5,
                                    right: 7.5
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Dimensi : ${widget.dataItem.size}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),

                              Container(
                                padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 7.5,
                                    right: 7.5
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Warna : ${widget.dataItem.color}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
                          )
                        else
                          Container(
                            padding: const EdgeInsets.only(
                                top: 0,
                                left: 7.5,
                                right: 7.5
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Perlengkapan : ${widget.dataItem.item}',
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
        );
      },
    );
  }
}