import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _index = 0;
  int _dataLength = 1;
  @override
  void initState() {
    getSliderImageFromDb();
    super.initState();
  }

  Future getSliderImageFromDb() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _fireStore.collection('slider').get();
    setState(() {
      _dataLength = snapshot.docs.length;
    });
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(_dataLength!=0)
        FutureBuilder(
          future: getSliderImageFromDb(),
          builder: (_, snapShot) {
            return snapShot.data == null
                ? Center(child: CircularProgressIndicator(),)
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider.builder(
                        itemCount: snapShot.data.length,
                        itemBuilder: (context, int index) {
                          DocumentSnapshot sliderImage = snapShot.data[index];
                          Map getImage = sliderImage.data();
                          return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.network(
                                getImage['Image'],
                                fit: BoxFit.fill,
                              ));
                        },
                        options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                          height: 150,
                          onPageChanged: (int i,carouselPageChangedReason){
                            setState((){
                              _index=i;
                            })
                          }
                        )),
                  );
          },
        ),
        if(_dataLength!=0)
        DotsIndicator(
            dotsCount: _dataLength,
            position: _index.toDouble(),
            decorator: DotsDecorator(
                size: const Size.square(5.0),
                activeSize: const Size(18.0, 5.0),
                activeShape: RoundedRectangleBorder(
                    borderradius: BorderRadius.circular(5.0)),
                activeColor: Theme.of(context).primaryColor))
      ],
    );
  }
}
