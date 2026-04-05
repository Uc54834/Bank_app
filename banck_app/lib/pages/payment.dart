import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../components/app_cards.dart';
import '../utils/responsive.dart';

class PaymentPage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      "icon": Icons.water_drop,
      "label": "Water",
      "color": Colors.lightBlue,
      "bg": AppColors.primaryContainer,
    },
    {
      "icon": Icons.lightbulb,
      "label": "Electricity",
      "color": Colors.amber,
      "bg": Color(0xFFFFF9C4),
    },
    {
      "icon": Icons.local_fire_department,
      "label": "Gas",
      "color": Colors.red,
      "bg": AppColors.accentContainer,
    },
    {
      "icon": Icons.shopping_bag,
      "label": "Shopping",
      "color": Colors.pink,
      "bg": Color(0xFFFCE4EC),
    },
    {
      "icon": Icons.phone_android,
      "label": "Phone",
      "color": Colors.blue,
      "bg": AppColors.secondaryContainer,
    },
    {
      "icon": Icons.credit_card,
      "label": "Credit Card",
      "color": Colors.green,
      "bg": Color(0xFFE8F5E9),
    },
    {
      "icon": Icons.security,
      "label": "Insurance",
      "color": Colors.teal,
      "bg": Color(0xFFE0F2F1),
    },
    {
      "icon": Icons.home,
      "label": "Mortgage",
      "color": Colors.deepPurple,
      "bg": Color(0xFFEDE7F6),
    },
    {
      "icon": Icons.receipt_long,
      "label": "Other Bills",
      "color": Colors.grey,
      "bg": AppColors.surfaceVariant,
    },
  ];

  PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payments',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BalanceCard(
                label: 'AVAILABLE BALANCE',
                amount: '4,180.20',
                gradientColors: AppColors.primaryGradient,
              ),
              const SizedBox(height: 24),
              const SectionHeader(
                title: 'Bill Categories',
                actionText: 'View All',
              ),
              const SizedBox(height: 16),
              _buildGrid(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final crossAxisCount = getCrossAxisCount(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildPaymentItem(item);
      },
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> item) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: item['bg'] as Color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: (item['color'] as Color).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item['icon'] as IconData,
                color: item['color'] as Color,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              item['label'] as String,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
