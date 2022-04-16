import 'package:flutter/material.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marker_icon/marker_icon.dart';
import 'package:mechanic_admin/helpers/constants.dart';
import 'package:mechanic_admin/models/request_model.dart';
import 'package:mechanic_admin/providers/location_provider.dart';
import 'package:provider/provider.dart';

class TrailMapScreen extends StatefulWidget {
  final RequestModel request;
  const TrailMapScreen(this.request, {Key? key}) : super(key: key);
  @override
  _TrailMapScreenState createState() => _TrailMapScreenState();
}

class _TrailMapScreenState extends State<TrailMapScreen> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  // ignore: prefer_final_fields
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
//Polyline patterns
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  _addPolyline(List<LatLng> _coordinates) {
    PolylineId id = const PolylineId("1");
    Polyline polyline = Polyline(
        polylineId: id,
        patterns: patterns[0],
        color: Colors.blueAccent,
        points: _coordinates,
        width: 10,
        onTap: () {});

    setState(() {
      _polylines[id] = polyline;
    });
  }

  GoogleMapPolyline googleMapPolyline =
      GoogleMapPolyline(apiKey: "AIzaSyDxbfpRGmq3Wjex1SfTXwySuxQaCiQZxUM");

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController.setMapStyle(value);
    final loc =
        Provider.of<LocationProvider>(context, listen: false).locationData;
    _markers.addAll([
      Marker(
        markerId: MarkerId(widget.request.id!),
        onTap: () {},
        icon: await MarkerIcon.downloadResizePictureCircle(
            widget.request.user!.imageUrl!,
            borderSize: 10,
            size: 130,
            addBorder: true,
            borderColor: kPrimaryColor),
        position: LatLng(widget.request.userLocation!.latitude,
            widget.request.userLocation!.longitude),
        infoWindow: InfoWindow(title: widget.request.user!.fullName!),
      ),
      Marker(
        markerId: MarkerId(widget.request.id!),
        onTap: () {},
        icon: await MarkerIcon.downloadResizePictureCircle(
            widget.request.user!.imageUrl!,
            borderSize: 10,
            size: 100,
            addBorder: true,
            borderColor: kPrimaryColor),
        position: LatLng(loc!.latitude!, loc.longitude!),
        infoWindow: InfoWindow(title: 'You'),
      ),
    ]);

    var _coordinates = await googleMapPolyline.getCoordinatesWithLocation(
        origin: LatLng(loc.latitude!, loc.longitude!),
        destination: LatLng(widget.request.userLocation!.latitude,
            widget.request.userLocation!.longitude),
        mode: RouteMode.driving);
    _addPolyline(_coordinates!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final loc =
        Provider.of<LocationProvider>(context, listen: false).locationData;

    return GoogleMap(
      // myLocationEnabled: true,
      onMapCreated: _onMapCreated,
      markers: _markers,
      polylines: _polylines.values.toSet(),
      initialCameraPosition: CameraPosition(
          target: LatLng(loc!.latitude!, loc.longitude!), zoom: 16),
    );
  }
}
