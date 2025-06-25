import 'dart:convert';

import 'package:flutter/material.dart';

/// Returns the appropriate icon for different activity types
IconData getActivityIcon(String description) {
  switch (description.toLowerCase()) {
    case 'product demonstration':
      return Icons.play_circle_outline;
    case 'technical consultation':
      return Icons.engineering_outlined;
    case 'contract negotiation':
      return Icons.handshake_outlined;
    case 'follow-up meeting':
      return Icons.follow_the_signs_outlined;
    case 'problem resolution':
      return Icons.build_circle_outlined;
    case 'training session':
      return Icons.school_outlined;
    case 'system installation':
      return Icons.settings_applications_outlined;
    case 'maintenance check':
      return Icons.tune_outlined;
    case 'sales presentation':
      return Icons.present_to_all_outlined;
    case 'customer feedback collection':
      return Icons.feedback_outlined;
    default:
      return Icons.work_outline;
  }
}

/// Returns the appropriate icon for different visit statuses
IconData getStatusIcon(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return Icons.check_circle;
    case 'pending':
      return Icons.schedule;
    case 'cancelled':
      return Icons.cancel;
    default:
      return Icons.help_outline;
  }
}

/// Returns the appropriate color for different visit statuses
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

/// Formats a DateTime to a readable date string (DD/MM/YYYY)
String formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

/// Formats a DateTime to a readable time string (HH:MM)
String formatTime(DateTime date) {
  return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}

/// Formats a DateTime to a more detailed date string
String formatDetailedDate(DateTime date) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]} ${date.year}';
}

/// Formats a DateTime to relative time (e.g., "2 hours ago")
String formatRelativeTime(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 0) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
  } else {
    return 'Just now';
  }
}

/// Returns a readable status display name
String getStatusDisplayName(String status) {
  switch (status.toLowerCase()) {
    case 'completed':
      return 'Completed';
    case 'pending':
      return 'Pending';
    case 'cancelled':
      return 'Cancelled';
    default:
      return status;
  }
}

/// Returns the priority of a status for sorting purposes
int getStatusPriority(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return 1; // Highest priority
    case 'completed':
      return 2;
    case 'cancelled':
      return 3; // Lowest priority
    default:
      return 4;
  }
}

/// Validates if an email address is valid
bool isValidEmail(String email) {
  return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}

/// Validates if a phone number is valid (basic validation)
bool isValidPhoneNumber(String phone) {
  return RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(phone);
}

/// Capitalizes the first letter of a string
String capitalize(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

/// Capitalizes the first letter of each word
String capitalizeWords(String text) {
  if (text.isEmpty) return text;
  return text.split(' ').map((word) => capitalize(word)).join(' ');
}

List<int> parseActivitiesDone(dynamic activitiesData) {
  if (activitiesData == null) return [];

  try {
    // If it's already a List
    if (activitiesData is List) {
      return activitiesData.map((item) {
        if (item is int) return item;
        if (item is String) return int.tryParse(item) ?? 0;
        return 0;
      }).toList();
    }

    // If it's a String that looks like JSON array
    if (activitiesData is String) {
      // Handle cases like "[9]", "[1,2,3]", etc.
      String cleanString = activitiesData.trim();

      // If it starts with [ and ends with ], try to parse as JSON
      if (cleanString.startsWith('[') && cleanString.endsWith(']')) {
        try {
          List<dynamic> parsed = json.decode(cleanString);
          return parsed.map((item) {
            if (item is int) return item;
            if (item is String) return int.tryParse(item) ?? 0;
            return 0;
          }).toList();
        } catch (e) {
          // If JSON parsing fails, try to extract numbers manually
          String numbersOnly = cleanString.replaceAll(RegExp(r'[^\d,]'), '');
          if (numbersOnly.isNotEmpty) {
            return numbersOnly
                .split(',')
                .where((s) => s.isNotEmpty)
                .map((s) => int.tryParse(s) ?? 0)
                .toList();
          }
        }
      }

      // Try to parse as single number
      int? singleNumber = int.tryParse(cleanString);
      if (singleNumber != null) {
        return [singleNumber];
      }
    }

    // If it's a single number
    if (activitiesData is int) {
      return [activitiesData];
    }
  } catch (e) {
    throw Exception('Failed to parse activities');
  }

  return [];
}
