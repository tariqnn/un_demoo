class Vacancy {
  final String? jobId;
  final String? title;
  final String? company;
  final String? location;
  final String? description;
  final String? longDescription;
  final String? salary;
  final String? datePosted;
  final String? imageUrl;
  final String? jobType;

  Vacancy({
    this.jobId,
    this.title,
    this.company,
    this.location,
    this.description,
    this.longDescription,
    this.salary,
    this.datePosted,
    this.imageUrl,
    this.jobType,
  });

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      jobId: json['job_id'] as String?,
      title: json['title'] as String?,
      company: json['company'] as String?,
      location: json['location'] as String?,
      description: json['description'] as String?,
      longDescription: json['long_description'] as String?,
      salary: json['salary'] as String?,
      datePosted: json['date_posted'] as String?,
      imageUrl: json['image_url'] as String?,
      jobType: json['jobType'] as String?,
    );
  }
}
