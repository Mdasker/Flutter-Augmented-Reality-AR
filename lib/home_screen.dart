import 'package:alphabet_ar/items_upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'item_ui_design_widget.dart';
import 'items.dart';


class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}




class _HomeScreenState extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Alphabet",
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: ()
            {
               Navigator.push(context, MaterialPageRoute(builder: (c)=> ItemsUploadScreen()));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("items")
            .orderBy("publishedDate", descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot dataSnapshot)
        {
          if(dataSnapshot.hasData)
          {
            return ListView.builder(
              itemCount: dataSnapshot.data!.docs.length,
              itemBuilder: (context, index)
              {
                Items eachItemInfo = Items.fromJson(
                  dataSnapshot.data!.docs[index].data() as Map<String, dynamic>
                );

                return ItemUIDesignWidget(
                  itemsInfo: eachItemInfo,
                  context: context,
                );
              },
            );
          }
          else
          {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    "Data is not available.",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
