/// Topology data models.
///
/// Contains the core data structures for mesh network topology:
/// - [MeshNode]: Network device (gateway, extender, client)
/// - [MeshLink]: Connection between devices
/// - [MeshTopology]: Container for nodes and links
library topology_models;

export 'mesh_node.dart';
export 'mesh_link.dart';
export 'mesh_topology.dart';
