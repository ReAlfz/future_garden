import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_garden/cart.dart';
import 'package:future_garden/config/model.dart';
import 'package:future_garden/config/services.dart';
import 'package:future_garden/detail_furniture.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late Future<HeadList> fetchAndSetFuture;
  late TextEditingController textController;
  late TabController tabController;

  @override
  initState() {
    tabController = TabController(length: 3, vsync: this);
    textController = TextEditingController();
    fetchAndSetFuture = LoadJson().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(top: media.viewPadding.top),
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/background.png'),
            ),
          ),
          child: FutureBuilder<HeadList>(
            future: fetchAndSetFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    List<DataItem> listFurniture = snapshot.data!.list_item;
                    List<DataItem> listRoom = snapshot.data!.list_room;
                    return Consumer<Services>(
                      builder: (context, services, child) {
                        List<DataItem> customList = listRoom + listFurniture;
                        customList.shuffle();
                        return NestedScrollView(
                          controller: ScrollController(),
                          floatHeaderSlivers: true,
                          headerSliverBuilder: (context, scrolled) {
                            return [
                              SliverAppBar(
                                pinned: true,
                                elevation: 2,
                                backgroundColor: const Color.fromRGBO(22, 199, 154, 1),
                                flexibleSpace: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 8,
                                          fit: FlexFit.tight,
                                          child: TextField(
                                            controller: textController,
                                            style: const TextStyle(
                                              color: Color.fromRGBO(25, 69, 107, 1),
                                            ),
                                            onChanged: (String text) {
                                              setState(
                                                () => (textController
                                                        .text.isEmpty)
                                                    ? FocusScope.of(context)
                                                        .unfocus()
                                                    : null,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Search',
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  (textController.text.isEmpty)
                                                      ? Icons.search
                                                      : Icons.clear,
                                                  size: 25,
                                                  color: const Color.fromRGBO(25, 69, 107, 1),
                                                ),

                                                onPressed: (textController.text.isNotEmpty)
                                                    ? () => setState(() {
                                                          FocusScope.of(context)
                                                              .unfocus();
                                                          textController.clear();
                                                        })
                                                    : null,
                                              ),
                                              fillColor: const Color.fromRGBO(248, 241, 241, 1.0),
                                              filled: true,
                                              contentPadding: const EdgeInsets.symmetric(
                                                horizontal: 20,
                                                vertical: 10,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 0.85),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(width: 0.85),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          flex: 1,
                                          fit: FlexFit.tight,
                                          child: GestureDetector(
                                            onTap: () => Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) => const Cart(),
                                                ),
                                            ),
                                            child: const Icon(
                                              CupertinoIcons.shopping_cart,
                                              color: Color.fromRGBO(25, 69, 107, 1),
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SliverToBoxAdapter(
                                child: CarouselSlider.builder(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    autoPlayAnimationDuration: const Duration(seconds: 1),
                                    enlargeCenterPage: true,
                                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                                    height: media.size.height * 0.285,
                                  ),
                                  itemCount: 3,
                                  itemBuilder: (context, index, realIndex) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                              builder: (context) => Details(dataItem: customList[index]),
                                        ),
                                      ),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Image(
                                                height: media.size.height * 0.2,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(customList[index].images),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 12.5,
                                            left: 12.5,
                                            right: 12.5,
                                            child: Stack(
                                              alignment: AlignmentDirectional.bottomStart,
                                              children: <Widget>[
                                                Text(
                                                  customList[index].title,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    foreground: Paint()
                                                      ..style = PaintingStyle.stroke
                                                      ..strokeWidth = 2
                                                      ..color = const Color.fromRGBO(25, 69, 107, 1),
                                                  ),
                                                ),

                                                Text(
                                                  customList[index].title,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Color.fromRGBO(248, 241, 241, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SliverToBoxAdapter(
                                child: TabBar(
                                  controller: tabController,
                                  labelColor: const Color.fromRGBO(25, 69, 107, 1),
                                  isScrollable: false,
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color.fromRGBO(22, 199, 154, 1),
                                  ),
                                  tabs: const [
                                    Tab(text: 'All'),
                                    Tab(text: 'Furniture'),
                                    Tab(text: 'Room Design'),
                                  ],
                                ),
                              )
                            ];
                          },

                          body: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                all(listFurniture + listRoom),
                                furniture(listFurniture),
                                roomDesign(listRoom),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Something wrong, try again later'),
                    );
                  }

                default:
                  return const Center(
                    child: Text('Loading...'),
                  );
              }
            },
          ),
        ));
  }

  Widget all(List<DataItem> list) {
    list = (textController.text.isEmpty)
        ? list
        : list.where(
            (element) => element.title.toLowerCase().contains(textController.text.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      child: GridView.builder(
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 225,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Details(
                      dataItem: list[index],
                    ),
                ),
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(list[index].images),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 5,
                    width: 120,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomStart,
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          list[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 17,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = const Color.fromRGBO(25, 69, 107, 1),
                          ),
                        ),
                        // Solid text as fill.
                        Text(
                          list[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(248, 241, 241, 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget furniture(List<DataItem> list) {
    list = (textController.text.isEmpty)
        ? list
        : list.where(
            (element) => element.title.toLowerCase().contains(textController.text.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      child: GridView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 225,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Details(
                        dataItem: list[index],
                      ),
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: const Color.fromRGBO(248, 241, 241, 1),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(list[index].images),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget roomDesign(List<DataItem> list) {
    list = (textController.text.isEmpty)
        ? list
        : list.where(
            (element) => element.title.toLowerCase().contains(textController.text.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      child: GridView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 225,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Details(
                        dataItem: list[index],
                  ),
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: const Color.fromRGBO(248, 241, 241, 1),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(list[index].images),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
