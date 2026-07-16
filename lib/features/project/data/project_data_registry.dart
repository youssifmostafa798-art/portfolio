import 'project_data.dart';
import 'vitaguard_data.dart';

abstract final class ProjectDataRegistry {
  static final Map<String, ProjectData> _projects = {};

  static void register(ProjectData data) {
    _projects[data.id] = data;
  }

  static ProjectData? get(String id) => _projects[id];

  static void init() {
    register(const VitaguardData());
  }
}
