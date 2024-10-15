import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart';
import 'package:easy_container/easy_container.dart';
import 'package:string_validator/string_validator.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({super.key});
  static const String routeName = 'quranPage';
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  TextEditingController textEditingController = TextEditingController();

  bool isLoading = true;

  var searchQuery = "";
  dynamic filteredData;
  dynamic ayatFiltered;
  dynamic suraJsonData;
  List pageNumbers = [];

  addFilteredData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      filteredData = suraJsonData;
      isLoading = false;
    });
  }

  Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonString);
    setState(() {
      suraJsonData = data;
    });
  }

  @override
  void initState() {
    loadJsonAsset().then((value) {
      addFilteredData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran Page"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  TextField(
                    textDirection: TextDirection.rtl,
                    controller: textEditingController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });

                      if (value == "") {
                        filteredData = suraJsonData;

                        pageNumbers = [];

                        setState(() {});
                      }

                      if (searchQuery.isNotEmpty &&
                          isInt(searchQuery) &&
                          toInt(searchQuery) < 605 &&
                          toInt(searchQuery) > 0) {
                        pageNumbers.add(toInt(searchQuery));
                      }

                      if (searchQuery.length > 3 ||
                          searchQuery.toString().contains(" ")) {
                        setState(() {
                          ayatFiltered = [];

                          ayatFiltered = searchWords(searchQuery);
                          filteredData = suraJsonData.where((sura) {
                            final suraName = sura['englishName'].toLowerCase();
                            // final suraNameTranslated =
                            //     sura['name']
                            //         .toString()
                            //         .toLowerCase();
                            final suraNameTranslated =
                                getSurahNameArabic(sura["number"]);

                            return suraName
                                    .contains(searchQuery.toLowerCase()) ||
                                suraNameTranslated
                                    .contains(searchQuery.toLowerCase());
                          }).toList();
                        });
                      }
                    },
                    style: const TextStyle(color: Color.fromARGB(190, 0, 0, 0)),
                    decoration: const InputDecoration(
                      hintText: 'searchQuran',
                      hintStyle: TextStyle(),
                      border: InputBorder.none,
                    ),
                  ),
                  if (pageNumbers.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("page"),
                    ),
                  ListView.separated(
                      reverse: true,
                      itemBuilder: (ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: EasyContainer(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(pageNumbers[index].toString()),
                                  Text(getSurahName(
                                      getPageData(pageNumbers[index])[0]
                                          ["surah"]))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Divider(
                              color: Colors.grey.withOpacity(.5),
                            ),
                          ),
                      itemCount: pageNumbers.length),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox.shrink(),
                    ),
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      //int suraNumber = index + 1;
                      //  int ayahCount = getVerseCount(suraNumber);
                      return const Text('Hey test');
                    },
                  ),
                  if (ayatFiltered != null)
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ayatFiltered["occurences"] > 10
                          ? 10
                          : ayatFiltered["occurences"],
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: EasyContainer(
                            color: Colors.white70,
                            borderRadius: 14,
                            onTap: () async {},
                            child: Text(
                              "سورة ${getSurahNameArabic(ayatFiltered["result"][index]["surah"])} - ${getVerse(ayatFiltered["result"][index]["surah"], ayatFiltered["result"][index]["verse"], verseEndSymbol: true)}",
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
