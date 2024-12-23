import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/category_news_model.dart';
import 'package:newsapp/repository/news_repository.dart';
import 'package:newsapp/utils/utils.dart';
import 'package:newsapp/view/detail_screen.dart';
import 'package:newsapp/view/home_screen.dart';
import 'package:newsapp/viewmodel/news_api_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  NewsRepository _newsRepository=NewsRepository();
  String initialCategory='general';
  String selectedCategory='general';
  List<String> categories=[
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology'
  ];
  DateFormat dateFormat=DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final HeightX=MediaQuery.of(context).size.height;
    final WidthY=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(height: HeightX*0.09,
            child: ListView.builder(itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Consumer<NewsApiViewModel>(builder: (context, vm, child) {
                  return InkWell(onTap: () {
                  selectedCategory=categories[index];
                  vm.colorChange();
                },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: selectedCategory==categories[index]? Color.fromRGBO(0, 155, 255, 1) : Color.fromRGBO(0, 55, 255, 1),
                      ),
                      child: Center(child: Text(categories[index],style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white))),
                    ),
                  ),
                );
                },);
              },),
          ),
          Consumer<NewsApiViewModel>(builder: (context, value, child) {
            return FutureBuilder<CategoryNewsModel>(future: _newsRepository.fetchCategoryNews(selectedCategory).onError((error, stackTrace) {
              return Utils.flushBar(error.toString(), context);
            },),
              builder: (context, AsyncSnapshot<CategoryNewsModel> snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
              return spinkit;
            if(snapshot.hasError)
              Text("Error");
            if(snapshot.hasData)
              return Expanded(flex: 2,
                child: ListView.builder(
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    return Padding(
                      padding: EdgeInsets.all(HeightX * 0.015),
                      child: InkWell(onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => DetailScreen(
                              title: snapshot.data!.articles![index].title
                                  .toString(),
                              description: snapshot.data!.articles![index]
                                  .description.toString(),
                              sourceName: snapshot.data!.articles![index]
                                  .source!.name.toString(),
                              image: snapshot.data!.articles![index]
                                  .urlToImage.toString(),
                              publishDate: snapshot.data!.articles![index]
                                  .publishedAt.toString()),));
                      },
                        child: Stack(children: [
                          Container(height: HeightX * 0.4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: snapshot.data!.articles![index]
                                  .urlToImage != null ? ExtendedImage.network(
                                snapshot.data!.articles![index].urlToImage
                                    .toString(), fit: BoxFit.cover,
                                loadStateChanged: (state) {
                                  if (state.extendedImageLoadState ==
                                      LoadState.loading) {
                                    return spinkit;
                                  }
                                  else {
                                    return null;
                                  }
                                },
                                cache: true,

                              ) : Icon(Icons.error, size: HeightX * 0.4,),
                            ),
                          ),
                          Positioned(child: Padding(
                            padding: EdgeInsets.all(WidthY * 0.045),
                            child: Container(
                              height: HeightX * 0.175,
                              width: WidthY * 0.86,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.articles![index].title
                                        .toString()
                                      , style: GoogleFonts.poppins(fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,),
                                    Spacer(),
                                    Row(mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                      children: [
                                        Text(snapshot.data!.articles![index]
                                            .source!.name.toString(),
                                          style: TextStyle(color: Colors
                                              .black),),
                                        Text(dateFormat.format(dateTime)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                            top: HeightX * 0.18,
                          )
                        ],
                        ),
                      ),
                    );
                  },),
              );
              return Text("No Data");


              },);
          },)

        ],
      ),
    );
  }
}
