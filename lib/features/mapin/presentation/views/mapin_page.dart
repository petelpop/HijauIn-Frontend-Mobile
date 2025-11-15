import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/aqi_location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/air_quality_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/aqi_markers_builder.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/mode_selector.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/trash_location_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/trash_markers_builder.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/aqi_map/aqi_map_cubit.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/mapin/mapin_cubit.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/waste/waste_cubit.dart';
import 'package:hijauin_frontend_mobile/utils/location_service.dart';
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
  final LocationService _locationService = LocationService();
  
  // default location = FSM Undip
  double _userLatitude = -7.048506770073256;
  double _userLongitude = 110.44122458341415;

  WasteLocationDataModel? _selectedTrashLocation;
  AqiLokaDataModel? _selectedAirLocation;

  @override
  void initState() {
    super.initState();
    context.read<MapinCubit>().setMode(MapMode.tempatSampah);
    _getUserLocationAndFetchData();
  }

  Future<void> _getUserLocationAndFetchData() async {
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
        context.read<AqiMapCubit>().fetchAqiLocations(
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
          context.read<AqiMapCubit>().fetchAqiLocations(
            lastPosition.latitude,
            lastPosition.longitude,
          );
        } else {
          context.read<WasteCubit>().fetchWasteLocations(
            _userLatitude,
            _userLongitude,
          );
          context.read<AqiMapCubit>().fetchAqiLocations(
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
      context.read<AqiMapCubit>().fetchAqiLocations(
        _userLatitude,
        _userLongitude,
      );
    }    
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
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(_userLatitude, _userLongitude),
                        width: 20,
                        height: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                    BlocBuilder<AqiMapCubit, AqiMapState>(
                      builder: (context, aqiState) {
                        if (aqiState is AqiMapLoaded) {
                          return MarkerLayer(
                            markers: AqiMarkersBuilder.buildMarkers(
                              locations: aqiState.aqiLoka.data ?? [],
                              onMarkerTap: (location) {
                                setState(() {
                                  _selectedAirLocation = location;
                                  _selectedTrashLocation = null;
                                });
                              },
                            ),
                          );
                        }
                        return MarkerLayer(markers: []);
                      },
                    ),
                ],
              ),

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
                  aqi: _selectedAirLocation!.aqi,
                  city: _selectedAirLocation!.station?.name,
                ),
            ],
          ),
        );
      },
    );
  }
}