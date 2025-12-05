import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../foundation/theme/design_system/specs/topology_style.dart';

// Re-export SignalQuality for convenience
export '../../../foundation/theme/design_system/specs/topology_style.dart'
    show SignalQuality;

/// Physical connection type between nodes.
enum ConnectionType {
  /// Wired connection - solid line, no signal quality.
  ethernet,

  /// Wireless connection - dashed line with flow animation.
  wifi,
}

/// A connection between two mesh nodes.
@immutable
class MeshLink extends Equatable {
  /// ID of the source node (typically parent).
  final String sourceId;

  /// ID of the target node (typically child).
  final String targetId;

  /// Physical connection type.
  final ConnectionType connectionType;

  /// Signal strength in dBm (WiFi only). Null if unavailable.
  /// - > -50: Strong (green)
  /// - -50 to -70: Medium (yellow)
  /// - < -70: Weak (red)
  final int? rssi;

  /// Current throughput in Mbps. Null if unavailable.
  /// Affects flow animation speed for WiFi links.
  final double? throughput;

  const MeshLink({
    required this.sourceId,
    required this.targetId,
    required this.connectionType,
    this.rssi,
    this.throughput,
  });

  /// Signal quality classification based on RSSI.
  SignalQuality get signalQuality {
    if (connectionType == ConnectionType.ethernet) {
      return SignalQuality.wired;
    }
    if (rssi == null) return SignalQuality.unknown;
    if (rssi! > -50) return SignalQuality.strong;
    if (rssi! >= -70) return SignalQuality.medium;
    return SignalQuality.weak;
  }

  /// Whether this is an Ethernet connection.
  bool get isEthernet => connectionType == ConnectionType.ethernet;

  /// Whether this is a WiFi connection.
  bool get isWifi => connectionType == ConnectionType.wifi;

  @override
  List<Object?> get props => [
        sourceId,
        targetId,
        connectionType,
        rssi,
        throughput,
      ];

  /// Creates a copy of this link with the given fields replaced.
  MeshLink copyWith({
    String? sourceId,
    String? targetId,
    ConnectionType? connectionType,
    int? rssi,
    double? throughput,
  }) {
    return MeshLink(
      sourceId: sourceId ?? this.sourceId,
      targetId: targetId ?? this.targetId,
      connectionType: connectionType ?? this.connectionType,
      rssi: rssi ?? this.rssi,
      throughput: throughput ?? this.throughput,
    );
  }
}
