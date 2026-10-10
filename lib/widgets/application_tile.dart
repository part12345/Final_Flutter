import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/job_application.dart';
import '../theme/app_theme.dart';
import 'company_logo.dart';

class ApplicationTile extends StatelessWidget {
  final JobApplication application;
  final VoidCallback onTap;

  const ApplicationTile({
    super.key,
    required this.application,
    required this.onTap,
  });

  Color _statusColor() {
    switch (application.status) {
      case 'Applied':
        return AppColors.blue;
      case 'In Review':
        return AppColors.orange;
      case 'Interview':
        return AppColors.purple;
      case 'Offer':
        return AppColors.green;
      case 'Rejected':
        return AppColors.red;
      default:
        return AppColors.textMedium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _statusColor();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(13),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Row(
          children: [
            CompanyLogo(
              company: application.companyName,
              size: 45,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    application.companyName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    application.jobPosition,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMedium,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    application.location,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    application.status,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormat('MMM d, yyyy').format(application.dateApplied),
                  style: const TextStyle(
                    fontSize: 9,
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.chevron_right,
              size: 19,
              color: AppColors.textMedium,
            ),
          ],
        ),
      ),
    );
  }
}
