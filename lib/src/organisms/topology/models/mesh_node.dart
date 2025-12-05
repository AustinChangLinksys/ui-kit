import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../foundation/theme/design_system/specs/topology_style.dart';

// Re-export enums from topology_style for convenience
export '../../../foundation/theme/design_system/specs/topology_style.dart'
    show MeshNodeType, MeshNodeStatus, SignalQuality;

/// A device in the mesh network topology.
///
/// Supports three node types:
/// - [MeshNodeType.gateway]: The primary router (breathing animation)
/// - [MeshNodeType.extender]: Range extenders (liquid level animation)
/// - [MeshNodeType.client]: Connected devices (orbit animation)
@immutable
class MeshNode extends Equatable {
  /// Unique identifier for this node.
  final String id;

  /// Display name for the device.
  final String name;

  /// The type of node determining visual representation.
  final MeshNodeType type;

  /// Current operational status affecting animation behavior.
  final MeshNodeStatus status;

  /// Parent node ID for hierarchy. Null for gateway.
  final String? parentId;

  /// Current load percentage (0.0 to 1.0).
  /// Used by extenders for liquid level visualization.
  final double load;

  /// Optional icon for the device.
  /// Used when [imageAsset] is not provided.
  final IconData? iconData;

  /// Optional image asset path for the device.
  /// Takes priority over [iconData] when provided.
  /// Example: 'assets/images/devices/router-mx6200.png'
  final String? imageAsset;

  /// Device category for clustering (e.g., "smartphone", "laptop", "iot").
  final String? deviceCategory;

  const MeshNode({
    required this.id,
    required this.name,
    required this.type,
    this.status = MeshNodeStatus.online,
    this.parentId,
    this.load = 0.0,
    this.iconData,
    this.imageAsset,
    this.deviceCategory,
  });

  /// Whether this node is the root gateway.
  bool get isGateway => type == MeshNodeType.gateway;

  /// Whether this node is an extender.
  bool get isExtender => type == MeshNodeType.extender;

  /// Whether this node is a client device.
  bool get isClient => type == MeshNodeType.client;

  /// Whether this node has high load (> 70%).
  bool get isHighLoad => load > 0.7;

  /// Whether this node is offline.
  bool get isOffline => status == MeshNodeStatus.offline;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        status,
        parentId,
        load,
        iconData,
        imageAsset,
        deviceCategory,
      ];

  /// Creates a copy of this node with the given fields replaced.
  MeshNode copyWith({
    String? id,
    String? name,
    MeshNodeType? type,
    MeshNodeStatus? status,
    String? parentId,
    double? load,
    IconData? iconData,
    String? imageAsset,
    String? deviceCategory,
  }) {
    return MeshNode(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      parentId: parentId ?? this.parentId,
      load: load ?? this.load,
      iconData: iconData ?? this.iconData,
      imageAsset: imageAsset ?? this.imageAsset,
      deviceCategory: deviceCategory ?? this.deviceCategory,
    );
  }
}
