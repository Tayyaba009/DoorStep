import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardWidget extends StatelessWidget {
  Future<int> fetchCount(String collectionName) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collectionName).get();
    return snapshot.size;
  }

  Stream<Map<String, dynamic>> fetchUserDistributionData() {
    return FirebaseFirestore.instance.collection('users').snapshots().map((snapshot) {
      Map<String, dynamic> data = {
        'Users A': 0,
        'Users B': 0,
        'Users C': 0,
        'Users D': 0,
      };

      snapshot.docs.forEach((doc) {
        final Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;
        final userCategory = docData['user_category'] as String?;
        if (userCategory == 'A') {
          data['Users A']++;
        } else if (userCategory == 'B') {
          data['Users B']++;
        } else if (userCategory == 'C') {
          data['Users C']++;
        } else if (userCategory == 'D') {
          data['Users D']++;
        }
      });

      return data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white, // Set the background color to white
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCountBox(
                title: 'Users Count',
                future: fetchCount('users'),
              ),
              _buildCountBox(
                title: 'Delivery Boys Count',
                future: fetchCount('delivery_boys'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCountBox(
                title: 'Vendors Count',
                future: fetchCount('vendors'),
              ),
              _buildCountBox(
                title: 'Total Orders',
                future: fetchCount('orders'),
              ),
            ],
          ),
          SizedBox(height: 24),
          Text(
            'Users Distribution',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          _buildUsersDistributionChart(),
        ],
      ),
    );
  }

  Widget _buildCountBox({required String title, required Future<int> future}) {
    return FutureBuilder<int>(
      future: future,
      builder: (context, snapshot) {
        final count = snapshot.data ?? -1;

        return Container(
          width: 160,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                count >= 0 ? count.toString() : 'N/A',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUsersDistributionChart() {
    return StreamBuilder<Map<String, dynamic>>(
      stream: fetchUserDistributionData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final data = snapshot.data ?? {};

        final List<PieChartSectionData> pieChartSections = data.entries.map((entry) {
          return PieChartSectionData(
            color: _getColorForUserCategory(entry.key),
            value: entry.value.toDouble(),
            title: entry.key,
            radius: 50,
            titleStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          );
        }).toList();

        return AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: pieChartSections,
            ),
          ),
        );
      },
    );
  }

  Color _getColorForUserCategory(String userCategory) {
    switch (userCategory) {
      case 'Users A':
        return Colors.blue;
      case 'Users B':
        return Colors.green;
      case 'Users C':
        return Colors.orange;
      case 'Users D':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
