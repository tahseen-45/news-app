import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/utils/utils.dart';

class DetailScreen extends StatefulWidget {
  String title;
  String description;
  String sourceName;
  String image;
  String publishDate;
  DetailScreen({required this.title,required this.description,required this.sourceName,required this.image,required this.publishDate});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    final HeightX=MediaQuery.of(context).size.height;
    final WidthY=MediaQuery.of(context).size.width;
    DateFormat dateFormat=DateFormat('MMM dd, yyyy');
    DateTime dateTime=DateTime.parse(widget.publishDate.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Container(
              height: HeightX*0.9,
              width: WidthY*0.95,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                color: Colors.white,
                boxShadow: [BoxShadow(
                  color: Colors.black38,
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  spreadRadius: 2,
                )]
              ),
              child: Column(
                children: [
                  Container(height: HeightX*0.4,
                      width: WidthY*0.95,
                      child: ClipRRect(borderRadius: BorderRadius.circular(35),
                        child: ExtendedImage.network(widget.image.toString(),fit: BoxFit.cover,
                        loadStateChanged: (state) {
                          if(state.extendedImageLoadState==LoadState.loading) {
                            return SpinKitCircle(color: Color.fromRGBO(0, 75, 255,
                                1),
                            );
                          }
                          else{
                            return null;
                          }
                          },
                        ),
                      )),
                  Spacer(),
                  Container(
                    height: HeightX*0.45,
                    width: WidthY*0.95,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(35),topLeft: Radius.circular(35)),
                        color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.black38,
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 2,
                      ),
                    BoxShadow(
                    color: Colors.black38,
                    offset: Offset(-2, -2),
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                      ]
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(widget.title,style: GoogleFonts.poppins(fontSize: 21,fontWeight: FontWeight.bold),
                          maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 35),
                            child: Text(widget.description,style: GoogleFonts.poppins(),
                            maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer(),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.sourceName,style: GoogleFonts.poppins(),),
                              Text(dateFormat.format(dateTime)),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(child: Text("+"),
        onPressed: () {
          Utils.flushBar("This is flash bar", context);
        },),
    );
  }
}
