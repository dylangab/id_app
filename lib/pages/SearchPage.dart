import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController search = TextEditingController();
  String query = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 236, 239),
      body: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 233, 236, 239),
            title: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide.none),
              elevation: 5,
              color: Colors.white,
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search....",
                    hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none)),
                onChanged: (val) {
                  setState(() {
                    // query = val;
                  });
                },
              ),
            ),
          ),

          /*    Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Business Accounts Requests")
                      .snapshots(),
                  builder: (context, snapshots) {
                    return (snapshots.connectionState ==
                            ConnectionState.waiting)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : SizedBox(
                            height: MediaQuery.sizeOf(context).height,
                            child: query.isEmpty
                                ? Container(
                                    child: const Center(
                                        child: Text("Search any business")),
                                  )
                                : ListView.builder(
                                    itemCount: snapshots.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var data = snapshots.data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      if (data["Business Name"]
                                          .toString()
                                          .toLowerCase()
                                          .startsWith(query.toLowerCase())) {
                                        return Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Material(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await Get.to(() => buzpage(),
                                                      arguments: data["bid"]);
                                                },
                                                child: ListTile(
                                                    shape:
                                                        BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            side:
                                                                const BorderSide(
                                                              width: 1,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      238,
                                                                      240,
                                                                      235),
                                                            )),
                                                    title: Text(
                                                      data["Business Name"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    }));
                  })) */
        ],
      ),
    );
  }
}
