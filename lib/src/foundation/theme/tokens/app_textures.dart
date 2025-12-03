import 'dart:convert';
import 'package:flutter/material.dart';

class AppTextures {
  AppTextures._();

  // Pixel Grid - 4x4 dot pattern
  static const String _pixelGridBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAGUlEQVR4nGNgYGD4////fwYYzQjloAD8KgBVXRXtxHmoqwAAAABJRU5ErkJggg==';

  // Diagonal Lines - 4x4 diagonal pattern
  static const String _diagonalLinesBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAH0lEQVR4nGNgYGD4////fxDBAGIjGFAJJhAPHaBoAQBxQRfrUhsz3AAAAABJRU5ErkJggg==';

  // Noise - 8x8 random noise pattern
  static const String _noiseBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAAQElEQVR4nHWNUQ4AIAhC03X/K9NwsZHV+8GBaABARAwCoFTQZ1IuQxpSeXlUdsvnWugtZ/rpzvOFh+R60clfIBaoVCYJRUMVSAAAAABJRU5ErkJggg==';

  // Wood Texture - 8x8 natural wood grain
  static const String _woodBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAd0lEQVR4nF2NSQqDQBBFy7LbISq6yiaQw+QsOawXEYLggGP1WNm2/uV78H7Ufj8QbCbz22g8Na7KhgIAhkOTdaidD2mTyXf98AzYZDIU/a4m0mUi0POlsyjzLFKBETJczKvKmWFV9v4hY5zJ5DK+p7rlrFJB1v0BjY836ubIQ9cAAAAASUVORK5CYII=';

  // Metal Texture - 8x8 brushed metal with scratches
  static const String _metalBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAuklEQVR4nAXBwQpGMAAA4H/jpDlJa+Xm5CZqV57Tg3gCBy+wg+Yokha1MWPa/32gaZooir7v45xXVTVNk5QSIQQxxr7vn+eZZdlxHOu6JkkCIYQIIcYYIUQpxTkvikJrDQCAQoi6ro0xSqk8z51z4zj+fj8/DEMIoTEmTdPneYZhoJS+7wullF3XEULu+57nuSxL55wQAu77Tindto0xFgTBdV1931trQdu2xphlWTDGnudpra21cRz/AR+Lb/UBuxUWAAAAAElFTkSuQmCC';

  // Fabric Texture - 8x8 woven cloth pattern
  static const String _fabricBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAKklEQVR4nGPcsqCHgYFBRESEgYHhzZs3cDYTAw7AgqkWwsatA1Mt1e0AAAnGFzJZDhWHAAAAAElFTkSuQmCC';

  // Checkerboard Texture - 8x8 black and white squares
  static const String _checkerboardBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAAJklEQVR4nGNkAIP///8zMDAwMjLC2UwQCSzgPxhgsnHqABlKazsA1joj7RpUkn0AAAAASUVORK5CYII=';

  // Pixel Art 8-bit - 8x8 retro pixel pattern
  static const String _pixelArtBase64 =
      'iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAIAAABLbSncAAAARUlEQVR4nGP8fyKFgYHBOOscAxicnWYEYTAhiyKzGY2MQErgCiESZ6cZgXRAROFCEDZIAivAaRTj/xMpyJbDFSHsQHMuAE4FILndQyyEAAAAAElFTkSuQmCC';

  static ImageProvider get pixelGrid =>
      MemoryImage(base64Decode(_pixelGridBase64));
  static ImageProvider get diagonalLines =>
      MemoryImage(base64Decode(_diagonalLinesBase64));
  static ImageProvider get noise => MemoryImage(base64Decode(_noiseBase64));
  static ImageProvider get wood => MemoryImage(base64Decode(_woodBase64));
  static ImageProvider get metal => MemoryImage(base64Decode(_metalBase64));
  static ImageProvider get fabric => MemoryImage(base64Decode(_fabricBase64));
  static ImageProvider get checkerboard =>
      MemoryImage(base64Decode(_checkerboardBase64));
  static ImageProvider get pixelArt =>
      MemoryImage(base64Decode(_pixelArtBase64));
}
