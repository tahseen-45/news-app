import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/data/response/status.dart';
import 'package:newsapp/models/all_news_model.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/repository/news_repository.dart';
import 'package:newsapp/res/colors.dart';
import 'package:newsapp/res/components/round_button.dart';
import 'package:newsapp/utils/routes/routes_name.dart';
import 'package:newsapp/view/category_screen.dart';
import 'package:newsapp/view/detail_screen.dart';
import 'package:newsapp/view/splash_screen.dart';
import 'package:newsapp/viewmodel/home_view_view_model.dart';
import 'package:newsapp/viewmodel/news_api_view_model.dart';
import 'package:provider/provider.dart';
import 'package:newsapp/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  NewsApiViewModel newsApiViewModel=NewsApiViewModel();
  NewsRepository _newsRepository=NewsRepository();
  HomeViewViewModel _homeViewViewModel=HomeViewViewModel();
  String selectedValue='All';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _homeViewViewModel.fetchNewsApi(selectedValue).then((value) {
    //   print("HomeViewViewModel=${_homeViewViewModel.responseStatus.data!.articles![0].title.toString()}");
    // },);
    _newsRepository.fetchSourceList();

  }
  final dateFormat=DateFormat('MMM dd, yyyy');



  @override
  Widget build(BuildContext context) {

    final HeightX=MediaQuery.of(context).size.height;
    final WidthY=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
        Navigator.pushNamed(context, RoutesName.category);
        },
            icon: Image.asset("images/category_icon.png",height: 32,width: 32,)),
        title: Center(child: Text("News App",style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.bold),)),
        actions: [
          Consumer<NewsApiViewModel>(builder: (context, vm, child) {
            return PopupMenuButton<String>(onSelected: (value) {
                  var selectedId=_newsRepository.sourceList.where((map) => map['name']==value).toList();
                  selectedValue=selectedId[0]['id'];
                  print(_newsRepository.sourceList);
                  vm.functionfetch();
                  },
            itemBuilder: (context) {
            return _newsRepository.sourceList.map<PopupMenuEntry<String>>((map) {
              return PopupMenuItem(value: map['name'],child: Text(map['name']) );
            },).toList();
          },
          icon: Icon(Icons.more_vert,color: Colors.black,),
          );
          },),

        ],
      ),
      body: Column(
        children: [
          // ChangeNotifierProvider<HomeViewViewModel>(create: (context) => HomeViewViewModel(),
          // child: Expanded(flex: 3,
          //   child: Column(
          //     children: [
          //       Consumer<HomeViewViewModel>(builder: (context, value, child) {
          //         return RoundButton(text: "Click", height: 75, width: 75,color: AppColor.blue,
          //         onPress: () {
          //           value.fetchNewsApi(selectedValue);
          //         },
          //         );
          //       },),
          //       Consumer<HomeViewViewModel>(builder: (context, value, child) {
          //           switch(value.responseStatus.status){
          //           case Status.LOADING:
          //             return SpinKitFadingCircle(size: 50,color: AppColor.blue,);
          //           case Status.ERROR:
          //             return Center(child: Text(value.responseStatus.message.toString()));
          //             case Status.COMPLETED:
          //               return Expanded(flex: 3,
          //                 child: ListView.builder(itemCount: value.responseStatus.data!.articles!.length,
          //                   scrollDirection: Axis.horizontal,
          //                   itemBuilder: (context, index) {
          //                   print("ListViewBuilder executed");
          //                     DateTime dateTime=DateTime.parse(value.responseStatus.data!.articles![index].publishedAt.toString());
          //                     return Padding(
          //                       padding: EdgeInsets.all(HeightX*0.015),
          //                       child: InkWell(onTap: () {
          //                         Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(title: value.responseStatus.data!.articles![index].title.toString(), description: value.responseStatus.data!.articles![index].description.toString(), sourceName: value.responseStatus.data!.articles![index].source!.name.toString(), image: value.responseStatus.data!.articles![index].urlToImage.toString(), publishDate: value.responseStatus.data!.articles![index].publishedAt.toString(),)));
          //                       },
          //                         child: Stack(
          //                             children: [ Container(height: HeightX*0.5,
          //                               width: WidthY*0.95,
          //                               child: ClipRRect(borderRadius: BorderRadius.circular(15),
          //                                 child: value.responseStatus.data!.articles![index].urlToImage!=null? ExtendedImage.network(
          //                                   value.responseStatus.data!.articles![index].urlToImage.toString(),
          //                                   fit: BoxFit.cover,
          //                                   cache: true,
          //                                 )
          //                                     : Icon(Icons.error,size: HeightX*0.4,),
          //
          //                               ),
          //                             ),
          //                               Positioned(child: Padding(
          //                                 padding: EdgeInsets.all(WidthY*0.045),
          //                                 child: Container(
          //                                   height: HeightX*0.2,
          //                                   width: WidthY*0.86,
          //                                   decoration: BoxDecoration(
          //                                       borderRadius: BorderRadius.circular(15),
          //                                       color: Colors.white
          //                                   ),
          //                                   child: Padding(
          //                                     padding: EdgeInsets.all(HeightX*0.02),
          //                                     child: Column(
          //                                       children: [
          //                                         Text(value.responseStatus.data!.articles![index].title.toString(),style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.bold),
          //                                           overflow: TextOverflow.ellipsis,
          //                                           maxLines: 2,
          //                                         ),
          //                                         Spacer(),
          //                                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                                           children: [
          //                                             Text(value.responseStatus.data!.articles![index].source!.name.toString()),
          //                                             Text(dateFormat.format(dateTime).toString()),
          //                                           ],
          //                                         )
          //                                       ],
          //                                     ),
          //                                   ),
          //
          //                                 ),
          //                               ),
          //                                 top: HeightX*0.255,
          //
          //                               )
          //                             ]
          //                         ),
          //                       ),
          //                     );
          //                   },),
          //               );
          //               default:
          //                 return Container();
          //           }
          //
          //           },),
          //     ],
          //   ),
          // ),
          // ),
          Consumer<NewsApiViewModel>(builder: (context, vm, child) {
            return FutureBuilder<NewsApiModel>(future: _newsRepository.fetchNewsApi(selectedValue).onError((error, stackTrace) {
              return Utils.flushBar(error.toString(), context);
            },),
              builder: (context, AsyncSnapshot<NewsApiModel> snapshot) {
              print("FutureBuilder executed");
              if(snapshot.connectionState==ConnectionState.waiting)
                return SpinKitFadingCircle(size: HeightX*0.07,color: Color.fromRGBO(0, 75, 255, 1),);
              if(snapshot.hasError)
                return Text("Error");
              return Expanded(flex: 3,
                child: ListView.builder(itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return Padding(
                        padding: EdgeInsets.all(HeightX*0.015),
                        child: InkWell(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(title: snapshot.data!.articles![index].title.toString(), description: snapshot.data!.articles![index].description.toString(), sourceName: snapshot.data!.articles![index].source!.name.toString(), image: snapshot.data!.articles![index].urlToImage.toString(), publishDate: snapshot.data!.articles![index].publishedAt.toString()),));
                          },
                          child: Stack(
                            children: [ Container(height: HeightX*0.5,
                              width: WidthY*0.95,
                              child: ClipRRect(borderRadius: BorderRadius.circular(15),
                              child: snapshot.data!.articles![index].urlToImage!=null? ExtendedImage.network(
                                snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                cache: true,
                              )
                                  : Icon(Icons.error,size: HeightX*0.4,),

                              ),
                            ),
                              Positioned(child: Padding(
                                padding: EdgeInsets.all(WidthY*0.045),
                                child: Container(
                                  height: HeightX*0.2,
                                  width: WidthY*0.86,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(HeightX*0.02),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString(),style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                        Spacer(),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshot.data!.articles![index].source!.name.toString()),
                                            Text(dateFormat.format(dateTime).toString()),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),

                                ),
                              ),
                              top: HeightX*0.255,

                              )
                            ]
                          ),
                        ),
                      );
                    },),
              );


              },);
          },),
          Expanded(flex: 2,
            child: FutureBuilder<AllNewsModel>(future: _newsRepository.fetchEveryThing().onError((error, stackTrace) {
              return Utils.flushBar(error.toString(), context);
            },),
                builder: (context, AsyncSnapshot<AllNewsModel> snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting)
                    return SpinKitCubeGrid(color: Color.fromRGBO(0, 55, 255, 1),);
                  if(snapshot.hasError)
                    return Text("Error");
                  return ListView.builder(itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                      DateTime dateTimeEverything=DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return Padding(
                          padding: EdgeInsets.all(15),
                          child: InkWell(onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(title: snapshot.data!.articles![index].title.toString(), description: snapshot.data!.articles![index].description.toString(), sourceName: snapshot.data!.articles![index].source!.name.toString(), image: snapshot.data!.articles![index].urlToImage.toString(), publishDate: snapshot.data!.articles![index].publishedAt.toString()),));
                            },
                            child: Container(height: HeightX*0.255,
                              width: WidthY*0.95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [BoxShadow(
                                  color: Colors.black38,
                                  offset: Offset(2, 2),
                                  blurRadius: 2,
                                  spreadRadius: 2
                                )]
                              ),
                              child: Row(
                                children: [
                                  Container(height: HeightX*0.255,
                                    width: WidthY*0.4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: ExtendedImage.network(snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                        loadStateChanged: (state) {
                                          if(state.extendedImageLoadState==LoadState.loading){
                                           return SpinKitCircle(size: 50,color: Color.fromRGBO(0, 55, 255, 1),);
                                          }
                                          else{
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(height: HeightX*0.255,
                                    width: WidthY*0.53,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: [
                                          Text(snapshot.data!.articles![index].title.toString(),style: GoogleFonts.poppins(fontSize: 19,fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),overflow: TextOverflow.ellipsis,),
                                              Text(dateFormat.format(dateTimeEverything),softWrap: true,
                                              maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },);

                },),
          )

        ],
      ),

      floatingActionButton: FloatingActionButton(child: Text("+"),
        onPressed: () {

        },),
    );
  }
}

const spinkit=SpinKitFadingCircle(
  size: 55,
  color: Color.fromRGBO(0, 75, 255, 1),
);
