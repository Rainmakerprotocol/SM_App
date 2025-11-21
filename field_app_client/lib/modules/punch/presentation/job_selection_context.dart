import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobSelectionContextProvider = Provider<JobSelectionContext>((ref) {
  return JobSelectionContext(
    hasSelection: true,
    jobLabel: 'SM-2401 · Storm Inspection',
    serviceLabel: 'Roof Tear-off',
    crewMembers: const [
      CrewMemberSummary(name: 'You', role: 'Installer'),
      CrewMemberSummary(name: 'Sam P.', role: 'Helper'),
    ],
  );
});

class JobSelectionContext {
  const JobSelectionContext({
    required this.hasSelection,
    this.jobLabel,
    this.serviceLabel,
    this.crewMembers = const [],
  });

  const JobSelectionContext.none()
    : hasSelection = false,
      jobLabel = null,
      serviceLabel = null,
      crewMembers = const [];

  final bool hasSelection;
  final String? jobLabel;
  final String? serviceLabel;
  final List<CrewMemberSummary> crewMembers;
}

class CrewMemberSummary {
  const CrewMemberSummary({required this.name, required this.role});

  final String name;
  final String role;
}
