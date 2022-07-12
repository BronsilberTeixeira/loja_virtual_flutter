import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    Widget _builderBodyback() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255,0,255,255),
            Color.fromARGB(255,0,128,128)
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft
        )
      ),
    );

    return Stack( 
      children: [
        _builderBodyback(),
        CustomScrollView(
          slivers: <Widget>[
             SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text("Novidades"),
                centerTitle: true
              ),
             ),
             FutureBuilder<QuerySnapshot> (
              future: Firestore.instance.collection("home").orderBy("pos").getDocuments(),
              builder: (context,  snapshot) {
                if(!snapshot.hasData) return SliverToBoxAdapter(
                  child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
                      ),
                    )
                  );
                  else {
                    print(snapshot.data.documents.length);
                    return SliverToBoxAdapter(
                  child: Container(
                      height: 200.0,
                      alignment: Alignment.center,
                      child: Container()
                    )
                  );
                  }
                },
             )
          ]
        ) 
      ],
    );
  }
}