import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StepProgress extends StatelessWidget {
  const StepProgress({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= totalSteps; i++) ...[
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: i <= currentStep
                    ? AppColors.accent
                    : AppColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          if (i != totalSteps) const SizedBox(width: 6),
        ],
      ],
    );
  }
}
