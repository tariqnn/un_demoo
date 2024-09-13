import 'package:flutter/material.dart';
import '../api/json_file.dart';

class VacancyDetailScreen extends StatelessWidget {
  final Vacancy vacancy;

  VacancyDetailScreen({required this.vacancy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(vacancy.title ?? 'Vacancy Details'),
        backgroundColor: Color(0xFF00A1D9),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            vacancy.imageUrl != null && vacancy.imageUrl!.isNotEmpty
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                vacancy.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            )
                : Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(Icons.image, size: 100),
            ),
            SizedBox(height: 20.0),
            Text(
              vacancy.title ?? 'Vacancy Details',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.0), // Adjust spacing
            Text(
              'Job ID: ${vacancy.jobId ?? 'Unknown'}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              vacancy.company ?? 'No Company',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              vacancy.location ?? 'No Location',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(color: Colors.grey),
            SizedBox(height: 16.0),
            Text(
              'Job Description:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00A1D9),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              vacancy.description ?? 'No Description',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              vacancy.longDescription ?? 'No Long Description',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.0),
            Divider(color: Colors.grey),
            SizedBox(height: 16.0),
            Text(
              'Salary: ${vacancy.salary ?? 'Not Disclosed'}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Posted on: ${vacancy.datePosted ?? 'Unknown'}',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
