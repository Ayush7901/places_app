import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import './add_place_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlaceList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, dataSnapshot) =>
            dataSnapshot.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text(
                        'No Places added yet!',
                      ),
                    ),
                    builder: (ctx, placeData, ch) => placeData.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: placeData.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(placeData.items[i].image),
                              ),
                              title: Text(placeData.items[i].title),
                            ),
                          ),
                  ),
      ),
    );
  }
}