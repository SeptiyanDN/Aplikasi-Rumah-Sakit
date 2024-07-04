import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aplikasi_rumah_sakit/cubits/province/province_cubit.dart';
import 'package:aplikasi_rumah_sakit/cubits/city/city_cubit.dart';
import 'package:aplikasi_rumah_sakit/cubits/city/city_state.dart';
import 'package:aplikasi_rumah_sakit/cubits/hospital/hospital_cubit.dart';
import 'package:aplikasi_rumah_sakit/cubits/hospital/hospital_state.dart';
import 'package:aplikasi_rumah_sakit/models/hospital_model.dart'; // Adjust import based on your project structure

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  String selectedProvince = '';
  String selectedCity = '';

  @override
  void initState() {
    super.initState();
    context.read<ProvinceCubit>().fetchProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rumah Sakit'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ProvinceCubit, ProvinceState>(
              builder: (context, state) {
                if (state is ProvinceLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProvinceLoaded) {
                  final provinces = state.province.provinces!;
                  if (selectedProvince.isEmpty && provinces.isNotEmpty) {
                    selectedProvince = provinces.first.id!;
                    selectedCity = ''; // Reset city when province changes
                    context.read<CityCubit>().fetchCities(selectedProvince);
                  }
                  return Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedProvince,
                        items: provinces
                            .map((province) => DropdownMenuItem(
                                  child: Text(province.name!),
                                  value: province.id!,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProvince = value!;
                            selectedCity = ''; // Reset selected city
                          });
                          context
                              .read<CityCubit>()
                              .fetchCities(selectedProvince);
                        },
                      ),
                      SizedBox(height: 10),
                      BlocBuilder<CityCubit, CityState>(
                        builder: (context, state) {
                          if (state is CityLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is CityLoaded) {
                            final cities = state.city.cities!;
                            // Ensure selectedCity defaults to the first city
                            if (selectedCity.isEmpty && cities.isNotEmpty) {
                              selectedCity = cities.first.id!;
                              context.read<HospitalCubit>().fetchHospitals(
                                  selectedProvince,
                                  selectedCity); // Fetch hospitals when city is loaded
                            }
                            return DropdownButtonFormField<String>(
                              value:
                                  selectedCity.isNotEmpty ? selectedCity : null,
                              items: cities
                                  .map((city) => DropdownMenuItem(
                                        child: Text(city.name!),
                                        value: city.id!,
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCity = value!;
                                });
                                context.read<HospitalCubit>().fetchHospitals(
                                    selectedProvince,
                                    selectedCity); // Fetch hospitals when city changes
                              },
                            );
                          } else if (state is CityError) {
                            return Center(
                                child: Text('Error: ${state.message}'));
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ],
                  );
                } else if (state is ProvinceError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Container();
                }
              },
            ),
          ),
          BlocBuilder<HospitalCubit, HospitalState>(
            builder: (context, state) {
              print('State hospital: $state');
              if (state is HospitalLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is HospitalLoaded) {
                final hospitals = state.hospital.hospitals!;
                print('Hospitals: $hospitals');
                return HospitalBoxList(hospitals: hospitals);
              } else if (state is HospitalError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}

class HospitalBoxList extends StatelessWidget {
  const HospitalBoxList({
    Key? key,
    required this.hospitals,
  }) : super(key: key);

  final List<Hospitals> hospitals; // Adjusted type to List<Hospitals>

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5, // Adjust as needed
        ),
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(hospitals[index].name ??
                  ''), // Assuming 'name' is a property in Hospitals
              onTap: () {
                // Implement action when hospital is tapped
                // Navigate to hospital detail screen or show details in a dialog
                _showHospitalDetails(context, hospitals[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

void _showHospitalDetails(BuildContext context, Hospitals hospital) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Detail Rumah Sakit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hospital.name ?? '',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Alamat: ${hospital.address ?? ''}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          SizedBox(height: 4),
          Text(
            'Telepon: ${hospital.phone ?? ''}',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Tutup'),
        ),
      ],
    ),
  );
}
