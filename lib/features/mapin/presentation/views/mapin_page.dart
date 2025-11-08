import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/location_model.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/air_quality_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/mode_selector.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/components/trash_location_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/mapin/presentation/cubit/mapin_cubit.dart';
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
  
  // Dummy data tempat sampah
  final List<TrashLocation> _trashLocations = [
    TrashLocation(
      id: '1',
      name: 'Tempat Sampah Taman Inspirasi',
      latitude: -6.2088,
      longitude: 106.8456,
      description: 'Di depan gazebo hutan budaya',
      imageUrl: Constants.imgBgAuth,
      types: ['Organik', 'Anorganik', 'B3'],
      distance: 1210,
    ),
    TrashLocation(
      id: '2',
      name: 'Bank Sampah Kampung',
      latitude: -6.2100,
      longitude: 106.8470,
      description: 'Dekat masjid',
      imageUrl: Constants.imgBgAuth,
      types: ['Organik', 'Anorganik'],
      distance: 850,
    ),
  ];

  // Dummy data kualitas udara
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

  TrashLocation? _selectedTrashLocation;
  AirQualityLocation? _selectedAirLocation;

  @override
  void initState() {
    super.initState();
    context.read<MapinCubit>().setMode(MapMode.tempatSampah);
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
              // Map
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: LatLng(-6.2088, 106.8456),
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
                    markers: currentMode == MapMode.tempatSampah
                        ? _buildTrashMarkers()
                        : _buildAirQualityMarkers(),
                  ),
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

              // Bottom Sheet for selected location
              if (_selectedTrashLocation != null)
                TrashLocationBottomSheet(
                  location: _selectedTrashLocation!,
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

  List<Marker> _buildTrashMarkers() {
    return _trashLocations.map((location) {
      return Marker(
        point: LatLng(location.latitude, location.longitude),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedTrashLocation = location;
              _selectedAirLocation = null;
            });
          },
          child: Icon(
            Icons.location_on,
            size: 40,
            color: primaryColor600,
          ),
        ),
      );
    }).toList();
  }

  List<Marker> _buildAirQualityMarkers() {
    return _airQualityLocations.map((location) {
      Color markerColor = location.aqiValue <= 50
          ? Color(0xFF10B981) // Green - Baik
          : location.aqiValue <= 100
              ? Color(0xFFFBBF24) // Yellow - Sedang
              : Color(0xFFEF4444); // Red - Tidak Sehat

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