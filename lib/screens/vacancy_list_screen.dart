import 'package:flutter/material.dart';
import '../api/json_file.dart';
import '../api/api_connection.dart';
import 'vacancy_detail_screen.dart';

class VacancyListScreen extends StatefulWidget {
  @override
  _VacancyListScreenState createState() => _VacancyListScreenState();
}

class _VacancyListScreenState extends State<VacancyListScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Vacancy>> vacancies;
  String? selectedFilter = 'Newest First';

  @override
  void initState() {
    super.initState();
    vacancies = apiService.fetchVacancies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacancies'),
        backgroundColor: Color(0xFF00A1D9),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              dropdownColor: Colors.white,
              underline: Container(),
              icon: Icon(Icons.filter_list, color: Colors.black),
              items: <String>['Newest First', 'Oldest First']
                  .map((String filter) {
                return DropdownMenuItem<String>(
                  value: filter,
                  child: Text(filter, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFilter = newValue;
                });
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Vacancy>>(
        future: vacancies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No vacancies available'));
          } else {
            List<Vacancy> filteredVacancies = snapshot.data!;


            if (selectedFilter != null) {
              filteredVacancies.sort((a, b) {
                DateTime dateA =
                    DateTime.tryParse(a.datePosted ?? '1900-01-01') ??
                        DateTime(1900);
                DateTime dateB =
                    DateTime.tryParse(b.datePosted ?? '1900-01-01') ??
                        DateTime(1900);

                return selectedFilter == 'Newest First'
                    ? dateB.compareTo(dateA)
                    : dateA.compareTo(dateB);
              });
            }

            return ListView.builder(
              itemCount: filteredVacancies.length,
              itemBuilder: (context, index) {
                final vacancy = filteredVacancies[index];


                print('Image URL: ${vacancy.imageUrl}');

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VacancyDetailScreen(vacancy: vacancy),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        vacancy.imageUrl != null &&
                            vacancy.imageUrl!.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12.0)),
                          child: Image.network(
                            vacancy.imageUrl!,
                            width: double.infinity,
                            height: 200, // Larger image size
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image, size: 50),
                                ),
                          ),
                        )
                            : Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.0)),
                          ),
                          child: Icon(Icons.image, size: 50),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vacancy.title ?? 'No Title',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                              SizedBox(height: 8),
                              Text(
                                vacancy.company ?? 'No Company',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                vacancy.description ?? 'No Description',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Posted on: ${vacancy.datePosted ?? 'Unknown'}',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
