import 'package:flutter/material.dart';

import '../../common_view/list/src/sliver_expandable_list.dart';
import 'mock_data.dart';

class ExampleSliver extends StatefulWidget {
  @override
  _ExampleSliverState createState() => _ExampleSliverState();
}

class _ExampleSliverState extends State<ExampleSliver> {
  var sectionList = MockData.getExampleSections();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Sliver Example",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            SliverExpandableList(
              builder: SliverExpandableChildDelegate<String, ExampleSection>(
                sectionList: sectionList,
                headerBuilder: _buildHeader,
                itemBuilder: (context, sectionIndex, itemIndex, index) {
                  String item = sectionList[sectionIndex].items[itemIndex];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("a-$index"),
                    ),
                    title: Text("hehe-$item"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int sectionIndex, int index) {
    ExampleSection section = sectionList[sectionIndex];
    return InkWell(
        child: Container(
            color: Colors.lightBlue,
            height: 48,
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              section.header,
              style: TextStyle(color: section.expanded ? Colors.white:  Colors.pink),
            )),
        onTap: () {
          //toggle section expand state
          setState(() {
            section.setSectionExpanded(!section.isSectionExpanded());
          });
        });
  }
}
