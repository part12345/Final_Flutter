import 'package:flutter/material.dart';

import '../main.dart';
import '../theme/app_theme.dart';
import '../widgets/app_card.dart';
import '../widgets/application_tile.dart';
import '../widgets/stat_card.dart';
import 'application_details_page.dart';

class DashboardPage extends StatelessWidget {
  final Function(int) onNavigate;

  const DashboardPage({
    super.key,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = JobTrackScope.of(context);
    final applications = controller.applications;

    final total = applications.length;
    final review = applications.where((e) => e.status == 'In Review').length;
    final interviews =
        applications.where((e) => e.status == 'Interview').length;
    final offers = applications.where((e) => e.status == 'Offer').length;
    final rejected = applications.where((e) => e.status == 'Rejected').length;

    return RefreshIndicator(
      onRefresh: () async {
        await controller.load();
      },
      child: ListView(
        padding: const EdgeInsets.only(bottom: 30),
        children: [
          _Header(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
              children: [
                StatCard(
                  title: 'Total Applications',
                  value: '$total',
                  icon: Icons.description_outlined,
                  color: AppColors.blue,
                  background: AppColors.blueLight,
                ),
                StatCard(
                  title: 'In Review',
                  value: '$review',
                  icon: Icons.hourglass_empty,
                  color: AppColors.orange,
                  background: AppColors.orangeLight,
                ),
                StatCard(
                  title: 'Interviews',
                  value: '$interviews',
                  icon: Icons.event_available,
                  color: AppColors.purple,
                  background: AppColors.purpleLight,
                ),
                StatCard(
                  title: 'Offers',
                  value: '$offers',
                  icon: Icons.check_circle_outline,
                  color: AppColors.green,
                  background: AppColors.greenLight,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Application Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ProgressRow(
                    label: 'Applied',
                    count:
                        applications.where((e) => e.status == 'Applied').length,
                    color: AppColors.blue,
                    total: total,
                  ),
                  _ProgressRow(
                    label: 'In Review',
                    count: review,
                    color: AppColors.orange,
                    total: total,
                  ),
                  _ProgressRow(
                    label: 'Interview',
                    count: interviews,
                    color: AppColors.purple,
                    total: total,
                  ),
                  _ProgressRow(
                    label: 'Offer',
                    count: offers,
                    color: AppColors.green,
                    total: total,
                  ),
                  _ProgressRow(
                    label: 'Rejected',
                    count: rejected,
                    color: AppColors.red,
                    total: total,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 22, 16, 8),
            child: Row(
              children: [
                const Text(
                  'Recent Applications',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.textDark,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => onNavigate(1),
                  child: const Text('View All'),
                ),
              ],
            ),
          ),
          if (applications.isEmpty)
            _EmptyDashboard(
              onAdd: () => onNavigate(1),
            )
          else
            ...applications.take(3).map(
                  (application) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ApplicationTile(
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
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF4338CA),
            Color(0xFF6366F1),
            Color(0xFF7C3AED),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.16),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.business_center,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JobTrack',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'Your Job Application Tracker',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 19,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Good morning,',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'John Patrick Gallego!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Keep going! Your next opportunity\nis closer than you think.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressRow extends StatelessWidget {
  final String label;
  final int count;
  final int total;
  final Color color;

  const _ProgressRow({
    required this.label,
    required this.count,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0.0 : count / total;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
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
              Text(
                '$count (${(percent * 100).round()}%)',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 5,
              backgroundColor: const Color(0xFFEFF2F7),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyDashboard extends StatelessWidget {
  final VoidCallback onAdd;

  const _EmptyDashboard({
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AppCard(
        child: Column(
          children: [
            const Icon(
              Icons.description_outlined,
              size: 50,
              color: AppColors.primary,
            ),
            const SizedBox(height: 8),
            const Text(
              'No applications yet',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Start tracking your job applications.',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Add Application'),
            ),
          ],
        ),
      ),
    );
  }
}
