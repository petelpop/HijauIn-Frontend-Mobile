import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:hijauin_frontend_mobile/common/colors.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';
import 'package:hijauin_frontend_mobile/features/mapin/data/models/waste_location_model.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/components/waste_location_bottom_sheet.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/components/waste_markers_builder.dart';
import 'package:hijauin_frontend_mobile/features/sortir/presentation/cubit/waste_map/waste_map_cubit.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

class WasteMapPage extends StatefulWidget {
  static const String routeName = "waste-map-page";
  
  final String category;

  const WasteMapPage({
    super.key,
    required this.category,
  });

  @override
  State<WasteMapPage> createState() => _WasteMapPageState();
}

class _WasteMapPageState extends State<WasteMapPage> {
  final MapController _mapController = MapController();
  
  double _userLatitude = -7.048506770073256;
  double _userLongitude = 110.44122458341415;

  WasteLocationDataModel? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _fetchWasteLocations();
  }

  void _fetchWasteLocations() {
    // TODO: Get user's actual location
    // For now, using default FSM location
    context.read<WasteMapCubit>().fetchWasteLocationsByCategory(
      _userLatitude,
      _userLongitude,
      widget.category,
    );
  }

  String _getCategoryDisplayName() {
    switch (widget.category) {
      case 'ORGANIK':
        return 'Organik';
      case 'ANORGANIK':
        return 'Anorganik';
      case 'B3':
        return 'B3';
      default:
        return widget.category;
    }
  }

  Color _getCategoryColor() {
    switch (widget.category) {
      case 'ORGANIK':
        return Color(0xFF16A34A);
      case 'ANORGANIK':
        return Color(0xFFF59E0B);
      case 'B3':
        return Color(0xFFDC2626);
      default:
        return primaryColor600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PrimaryText(
          text: 'Tempat Sampah ${_getCategoryDisplayName()}',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorTextDarkPrimary,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorTextDarkPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<WasteMapCubit, WasteMapState>(
        builder: (context, state) {
          return Stack(
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
                  if (state is WasteMapLoaded)
                    MarkerLayer(
                      markers: WasteMarkersBuilder.buildMarkers(
                        locations: state.wasteLocation.data,
                        onMarkerTap: (location) {
                          setState(() {
                            _selectedLocation = location;
                          });
                        },
                      ),
                    )
                  else
                    MarkerLayer(markers: []),
                ],
              ),

              if (state is WasteMapLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: _getCategoryColor(),
                    ),
                  ),
                ),

              if (state is WasteMapError)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 5.w,
                  right: 5.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFDC2626),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.white),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: PrimaryText(
                            text: 'Gagal memuat lokasi: ${state.message}',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (state is WasteMapLoaded && state.wasteLocation.data.isEmpty)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  left: 5.w,
                  right: 5.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: primaryColor600),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: PrimaryText(
                            text: 'Tidak ada tempat sampah ${_getCategoryDisplayName()} di sekitar Anda',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: colorTextDarkSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              if (_selectedLocation != null)
                WasteLocationBottomSheet(
                  location: _selectedLocation!,
                  userLatitude: _userLatitude,
                  userLongitude: _userLongitude,
                  onClose: () {
                    setState(() {
                      _selectedLocation = null;
                    });
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
