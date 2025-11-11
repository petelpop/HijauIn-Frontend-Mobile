import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/air_quality_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/mode_selector.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/trash_location_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/trash_markers_builder.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/mapin/mapin_cubit.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/waste/waste_cubit.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

class MapinPage extends StatefulWidget {
  static const String routeName = "mapin-page";
  const MapinPage({super.key});

  @override
  State<MapinPage> createState() => _MapinPageState();
}

class _MapinPageState extends State<MapinPage> {
  final MapController _mapController = MapController();
  
  double _userLatitude = -7.048506770073256;
  double _userLongitude = 110.44122458341415;
  
  // TODO: Dummy data kualitas udara
  final List<AirQualityLocation> _airQualityLocations = [
    AirQualityLocation(
      id: '1',
      name: 'Tembalang',
      latitude: -6.2088,
      longitude: 106.8456,
      aqiValue: 50,
      quality: 'Baik',
      message: 'Udara bersih, nikmati harimu di luar ruangan!',
    ),
    AirQualityLocation(
      id: '2',
      name: 'Banyumanik',
      latitude: -6.2100,
      longitude: 106.8470,
      aqiValue: 110,
      quality: 'Tidak Sehat',
      message: 'Gunakan masker jika beraktivitas di luar',
    ),
    AirQualityLocation(
      id: '3',
      name: 'Semarang Tengah',
      latitude: -6.2070,
      longitude: 106.8440,
      aqiValue: 50,
      quality: 'Baik',
      message: 'Udara bersih',
    ),
  ];

  WasteLocationDataModel? _selectedTrashLocation;
  AirQualityLocation? _selectedAirLocation;

  @override
  void initState() {
    super.initState();
    context.read<MapinCubit>().setMode(MapMode.tempatSampah);
    _getUserLocationAndFetchWaste();
  }

  Future<void> _getUserLocationAndFetchWaste() async {
        // TODO: lokasi masih menggunakan lokasi FSM
    /*
    try {
      Position? position = await _locationService.getCurrentLocation();
      
      if (position != null) {
        setState(() {
          _userLatitude = position.latitude;
          _userLongitude = position.longitude;
        });
        
        _mapController.move(
          LatLng(position.latitude, position.longitude),
          14.0,
        );
        
        context.read<WasteCubit>().fetchWasteLocations(
          position.latitude,
          position.longitude,
        );
      } else {
        Position? lastPosition = await _locationService.getLastKnownPosition();
        
        if (lastPosition != null) {
          setState(() {
            _userLatitude = lastPosition.latitude;
            _userLongitude = lastPosition.longitude;
          });
          
          _mapController.move(
            LatLng(lastPosition.latitude, lastPosition.longitude),
            14.0,
          );
          
          context.read<WasteCubit>().fetchWasteLocations(
            lastPosition.latitude,
            lastPosition.longitude,
          );
        } else {
          context.read<WasteCubit>().fetchWasteLocations(
            _userLatitude,
            _userLongitude,
          );
        }
      }
    } catch (e) {
      context.read<WasteCubit>().fetchWasteLocations(
        _userLatitude,
        _userLongitude,
      );
    }
    */
    
    context.read<WasteCubit>().fetchWasteLocations(
      _userLatitude,
      _userLongitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapinCubit, MapinState>(
      builder: (context, state) {
        MapMode currentMode = MapMode.tempatSampah;
        if (state is MapModeChanged) {
          currentMode = state.mode;
        }

        return Scaffold(
          body: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(_userLatitude, _userLongitude),
                  initialZoom: 14.0,
                  minZoom: 10.0,
                  maxZoom: 18.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.hijauin.app',
                  ),
                  if (currentMode == MapMode.tempatSampah)
                    BlocBuilder<WasteCubit, WasteState>(
                      builder: (context, wasteState) {
                        if (wasteState is WasteLoaded) {
                          return MarkerLayer(
                            markers: TrashMarkersBuilder.buildMarkers(
                              locations: wasteState.wasteLocation.data,
                              onMarkerTap: (location) {
                                setState(() {
                                  _selectedTrashLocation = location;
                                  _selectedAirLocation = null;
                                });
                              },
                            ),
                          );
                        }
                        return MarkerLayer(markers: []);
                      },
                    )
                  else
                    MarkerLayer(markers: _buildAirQualityMarkers()),
                ],
              ),

              // Mode Selector
              Positioned(
                top: MediaQuery.of(context).padding.top + 16,
                left: 5.w,
                right: 5.w,
                child: ModeSelector(
                  currentMode: currentMode,
                  onModeChanged: () {
                    setState(() {
                      _selectedTrashLocation = null;
                      _selectedAirLocation = null;
                    });
                  },
                ),
              ),

              if (_selectedTrashLocation != null)
                TrashLocationBottomSheet(
                  location: _selectedTrashLocation!,
                  userLatitude: _userLatitude,
                  userLongitude: _userLongitude,
                  onClose: () {
                    setState(() {
                      _selectedTrashLocation = null;
                    });
                  },
                ),
              if (_selectedAirLocation != null)
                AirQualityBottomSheet(
                  location: _selectedAirLocation!,
                  onClose: () {
                    setState(() {
                      _selectedAirLocation = null;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  List<Marker> _buildAirQualityMarkers() {
    return _airQualityLocations.map((location) {
      Color markerColor = location.aqiValue <= 50
          ? Color(0xFF10B981) 
          : location.aqiValue <= 100
              ? Color(0xFFFBBF24) 
              : Color(0xFFEF4444); 

      return Marker(
        point: LatLng(location.latitude, location.longitude),
        width: 60,
        height: 40,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedAirLocation = location;
              _selectedTrashLocation = null;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: markerColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${location.aqiValue}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}