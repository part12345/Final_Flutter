import 'package:flutter/material.dart';

import '../main.dart';
import '../theme/app_theme.dart';
import '../widgets/application_tile.dart';
import 'application_details_page.dart';
import 'application_form_page.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  String search = '';
  String statusFilter = 'All Status';

  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = JobTrackScope.of(context);

    final applications = controller.applications.where((application) {
      final matchesSearch = application.companyName.toLowerCase().contains(
                search.toLowerCase(),
              ) ||
          application.jobPosition.toLowerCase().contains(
                search.toLowerCase(),
              ) ||
          application.location.toLowerCase().contains(
                search.toLowerCase(),
              );

      final matchesStatus =
          statusFilter == 'All Status' || application.status == statusFilter;

      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Applications',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ApplicationFormPage(),
                ),
              );
            },
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 19,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 8),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search by company, position or location...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    label: statusFilter,
                    onTap: () => _showStatusFilter(context),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FilterButton(
                    label: 'All Types',
                    onTap: () {},
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      search = '';
                      searchController.clear();
                      statusFilter = 'All Status';
                    });
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: applications.isEmpty
                ? _EmptyState(
                    onAdd: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ApplicationFormPage(),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      5,
                      16,
                      30,
                    ),
                    itemCount: applications.length,
                    itemBuilder: (_, index) {
                      final application = applications[index];

                      return ApplicationTile(
                        application: application,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ApplicationDetailsPage(
                                application: application,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ApplicationFormPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showStatusFilter(BuildContext context) {
    final statuses = [
      'All Status',
      'Applied',
      'In Review',
      'Interview',
      'Offer',
      'Rejected',
    ];

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          children: statuses.map((status) {
            return ListTile(
              title: Text(status),
              trailing: status == statusFilter
                  ? const Icon(
                      Icons.check,
                      color: AppColors.primary,
                    )
                  : null,
              onTap: () {
                setState(() {
                  statusFilter = status;
                });

                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMedium,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 17,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyState({
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.description_outlined,
                size: 65,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No job applications yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start tracking your job search by\nadding your first application.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textMedium,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: const Text('Add Application'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
