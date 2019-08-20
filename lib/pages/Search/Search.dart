import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:thepublictransport_app/backend/models/main/SuggestedLocation.dart';
import 'package:thepublictransport_app/backend/service/core/CoreService.dart';
import 'package:thepublictransport_app/ui/components/Maps/MapsOverlay.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: Stack(
        children: <Widget>[
          MapsOverlay(),
          Container(
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.10, 20, 0),
            child: Card(
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: new BorderSide(width: 0, color: Colors.transparent)
              ),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: TextStyle(
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                        labelText: 'Suche ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)
                        )
                    )
                ),
                suggestionsCallback: (pattern) async {
                  return await getResults(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(suggestion.location.name + (suggestion.location.place != null ? ", " + suggestion.location.place : "")),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  Navigator.of(context).pop(suggestion);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<SuggestedLocation>> getResults(String query) async {
    var result = await CoreService.getLocationQuery(query, "STATION", 5.toString(), "DB");

    return result.suggestedLocations;
  }
}