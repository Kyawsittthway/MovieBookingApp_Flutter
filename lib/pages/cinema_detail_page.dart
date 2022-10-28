
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/common_widgets_view/cinema_time_slot_view_widget.dart';
import 'package:movie_booking_app/common_widgets_view/custom_chip_view.dart';
import 'package:movie_booking_app/common_widgets_view/interfont_text_widget.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/fonts.dart';
import 'package:video_player/video_player.dart';

import '../currentAppState.dart';
import '../data.vos/vos/cinema_vo.dart';

class CinemaDetailPage extends StatefulWidget{

  final CinemaVO cinemaDetails;
  CinemaDetailPage({
    required this.cinemaDetails
});


  @override
  State<CinemaDetailPage> createState() => _CinemaDetailPageState();
}



class _CinemaDetailPageState extends State<CinemaDetailPage> {
  var videoPlayerController;
  var chewieController;
  List<String> genreList = [
    "Thermanal Scannig",
    "Contactless Security Check",
    "Santization Before Every Show",
    "Disposable 3D glass",
    "Contactless Food Service",
    "Package Food",
    "Deep Cleaning of rest room"
  ];
  @override
  void initState()  {
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.cinemaDetails.promoVideoURL ?? "https://storage.googleapis.com/mmds-padc/PADC/tmba/cinema.promo.vdos/black.adam.promo.mp4");
    setChewieController();
  }
  void setChewieController() async{
   await videoPlayerController.initialize();
  }
  @override
  void dispose(){
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
    );
    return Scaffold(
      backgroundColor: PRIMARY_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_BACKGROUND_COLOR,
        leading: IconButton(icon: Icon(Icons.chevron_left,size:NORMAL_ICON_SIZE),onPressed: (){
          Navigator.pop(context);
        },),
        title: InterFontTextWidget("Cinema Details"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.star_border_purple500_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(
                  children: [
                    Positioned.fill(child: Chewie(controller: chewieController,)),
                  ],
                ),
              ),
              SizedBox(
                height: MEDIUM_PADDING,
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InterFontTextWidget("${widget.cinemaDetails.name}",fontSize: LARGE_FONT_SIZE,),
                    SizedBox(
                      height: SMALL_PADDING,
                    ),
                    Container(
                      child: Row(

                        children: [
                          Container(
                            width:MediaQuery.of(context).size.width * 0.8,
                            child: InterFontTextWidget("${widget.cinemaDetails.address} ",fontSize: LARGE_FONT_SIZE,),),
                          Icon(CupertinoIcons.location_fill,size: 50,color: GREEN_BUTTON_COLOR,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MEDIUM_PADDING,
                    ),
                    InterFontTextWidget("Facilities",fontSize: LARGE_FONT_SIZE,),
                    Container(
                      child: Wrap(
                        children: [
                          Container(
                            height: 100,

                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                                itemCount: widget.cinemaDetails.facilities?.length ?? 0,
                                itemBuilder: (BuildContext context, int index){
                              return Padding(padding:EdgeInsets.symmetric(horizontal: SMALL_PADDING),child: CinemaFeatureView(inputName: widget.cinemaDetails.facilities![index].title! , imagePath: widget.cinemaDetails.facilities![index].imagePath!));
                            }),
                          )
                        ],
                      ),
                    ),
                    InterFontTextWidget("Safety",fontSize: LARGE_FONT_SIZE,),
                    SizedBox(
                      height: MEDIUM_PADDING,
                    ),
                    CustomChipView(genreList: widget.cinemaDetails.safety!,chipHeight: 35,chipWidth: 200, isCenter: false,),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}