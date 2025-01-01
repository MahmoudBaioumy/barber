import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/AppColor.dart';
import 'package:flutter_application_barber/core/utils/text_styles.dart';
import 'package:flutter_application_barber/feature/client/search/presentaion/widgets/search_list.dart';
import 'package:flutter_svg/svg.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key,});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _textController = TextEditingController();
  String search = '';
  int _length = 0;
  @override
   void initState() {
    super.initState();
    search = _textController.text;
    _length = search.length;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أبحث عن حلاقك',
          style: getTitelstyle(fontSize: 20, color: AppColor.white1color),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  )
                ],
              ),
              child: TextField(
                onChanged: (searchKey) {
                  setState(
                    () {
                      search = searchKey;
                      _length = search.length;
                    },
                  );
                },
                decoration: InputDecoration(
                  hintText: "البحث",
                  hintStyle: getBodystyle(),
                  suffixIcon: SizedBox(
                      width: 50,
                      child: Icon(Icons.search, color: AppColor.bluecolor)),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: _length == 0
                    ? Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _length = 1;
                                  });
                                },
                                child: Text(
                                  'عرض كل الحلافين',
                                  style: getTitelstyle(),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/no-search.svg',
                                width: 250,
                              ),
                            ],
                          ),
                        ),
                      )
                    : SearchList(
                        searchKey: search,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
