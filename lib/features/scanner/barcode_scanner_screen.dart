import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

/// PreBite Barcode Scanner Screen
/// Implements the Stitch Barcode Scanner UI reference (`barcode_scanner/code.html` and `screen.png`).
class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key, this.animateLaser = true});

  final bool animateLaser;

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scanAnimationController;
  late final Animation<double> _scanAnimation;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    if (widget.animateLaser) {
      _scanAnimationController.repeat(reverse: true);
    }

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Mock Camera Preview Background
          _buildCameraPreviewBackground(),

          // 2. Translucent Ambient Overlay
          Container(color: Colors.black.withValues(alpha: 0.45)),

          // 3. Top and Bottom Vignette Gradients
          _buildGradientOverlays(),

          // 4. Foreground Content (Top Bar, Viewfinder HUD, Instructions, Controls)
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(context),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildScanningFrame(),
                      const SizedBox(height: PreBiteSpacing.lg),
                      _buildInstructions(),
                    ],
                  ),
                ),
                _buildBottomControls(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Mock camera background displaying realistic supermarket shelf preview
  Widget _buildCameraPreviewBackground() {
    return Image.asset(
      'assets/images/scanner_bg.jpg',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          Container(color: const Color(0xFF141A16)),
    );
  }

  /// Gradient vignettes for readability of text and controls
  Widget _buildGradientOverlays() {
    return Column(
      children: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.85),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const Spacer(),
        Container(
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withValues(alpha: 0.95),
                Colors.black.withValues(alpha: 0.6),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Top Bar with back navigation, screen title, and flash toggle
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PreBiteSpacing.md,
        vertical: PreBiteSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(
            icon: Icons.arrow_back_rounded,
            tooltip: 'Back',
            onTap: () {
              final canPop = ModalRoute.of(context)?.canPop ?? false;
              if (canPop) {
                Navigator.of(context).maybePop();
              } else {
                context.go(PreBiteRoutes.home);
              }
            },
          ),
          Text(
            'Scan Barcode',
            style: PreBiteTypography.headlineMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          _buildCircleButton(
            icon: _isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
            tooltip: 'Toggle Flash',
            isActive: _isFlashOn,
            onTap: _toggleFlash,
          ),
        ],
      ),
    );
  }

  /// Scanner Viewfinder Frame with 4 Green Corner Brackets and Laser Line
  Widget _buildScanningFrame() {
    const frameSize = 260.0;
    const cornerLength = 28.0;
    const cornerThickness = 4.0;
    const cornerRadius = 12.0;

    return Center(
      child: SizedBox(
        width: frameSize,
        height: frameSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Inner Clear Cutout with subtle white border
            Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(cornerRadius),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
            ),

            // Top-Left Corner
            Positioned(
              top: 0,
              left: 0,
              child: _buildCorner(
                width: cornerLength,
                height: cornerLength,
                thickness: cornerThickness,
                radius: cornerRadius,
                top: true,
                left: true,
              ),
            ),

            // Top-Right Corner
            Positioned(
              top: 0,
              right: 0,
              child: _buildCorner(
                width: cornerLength,
                height: cornerLength,
                thickness: cornerThickness,
                radius: cornerRadius,
                top: true,
                left: false,
              ),
            ),

            // Bottom-Left Corner
            Positioned(
              bottom: 0,
              left: 0,
              child: _buildCorner(
                width: cornerLength,
                height: cornerLength,
                thickness: cornerThickness,
                radius: cornerRadius,
                top: false,
                left: true,
              ),
            ),

            // Bottom-Right Corner
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildCorner(
                width: cornerLength,
                height: cornerLength,
                thickness: cornerThickness,
                radius: cornerRadius,
                top: false,
                left: false,
              ),
            ),

            // Animated Laser Scan Line
            AnimatedBuilder(
              animation: _scanAnimation,
              builder: (context, child) {
                const usableHeight = frameSize - 24.0;
                final topOffset = 12.0 + (_scanAnimation.value * usableHeight);
                return Positioned(
                  top: topOffset,
                  left: 12.0,
                  right: 12.0,
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: PreBiteColors.primaryFixedDim,
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: PreBiteColors.primary.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner({
    required double width,
    required double height,
    required double thickness,
    required double radius,
    required bool top,
    required bool left,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? BorderSide(color: PreBiteColors.primary, width: thickness)
              : BorderSide.none,
          bottom: !top
              ? BorderSide(color: PreBiteColors.primary, width: thickness)
              : BorderSide.none,
          left: left
              ? BorderSide(color: PreBiteColors.primary, width: thickness)
              : BorderSide.none,
          right: !left
              ? BorderSide(color: PreBiteColors.primary, width: thickness)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: top && left ? Radius.circular(radius) : Radius.zero,
          topRight: top && !left ? Radius.circular(radius) : Radius.zero,
          bottomLeft: !top && left ? Radius.circular(radius) : Radius.zero,
          bottomRight: !top && !left ? Radius.circular(radius) : Radius.zero,
        ),
      ),
    );
  }

  /// Scanning Instructions
  Widget _buildInstructions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
      child: Column(
        children: [
          Text(
            'Scan the barcode on the product',
            style: PreBiteTypography.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: PreBiteSpacing.xs),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              'Hold your phone steady and position the barcode inside the frame.',
              style: PreBiteTypography.bodyMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 13,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Controls Area (Gallery, Scan Trigger, Light, Helper Message)
  Widget _buildBottomControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PreBiteSpacing.lg,
        vertical: PreBiteSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Gallery Button
              _buildActionButton(
                icon: Icons.image_outlined,
                label: 'Gallery',
                onTap: () {},
              ),

              // Main Elevated Scan Trigger Button
              GestureDetector(
                onTap: () {
                  // Directs to Product Overview demo per Stitch interaction
                  context.go(
                    PreBiteRoutes.productOverviewPath('amul-masti-dahi'),
                  );
                },
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: PreBiteColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: PreBiteColors.primary.withValues(alpha: 0.5),
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 34,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Light Button
              _buildActionButton(
                icon: _isFlashOn
                    ? Icons.flashlight_on_rounded
                    : Icons.flashlight_off_rounded,
                label: 'Light',
                isActive: _isFlashOn,
                onTap: _toggleFlash,
              ),
            ],
          ),
          const SizedBox(height: PreBiteSpacing.md),
          Text(
            'Make sure the barcode is clearly visible',
            style: PreBiteTypography.labelMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: PreBiteSpacing.xs),
        ],
      ),
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: isActive
            ? PreBiteColors.primary.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 22),
        onPressed: onTap,
        tooltip: tooltip,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isActive
                  ? PreBiteColors.primary.withValues(alpha: 0.7)
                  : Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.0,
              ),
            ),
            child: Center(child: Icon(icon, size: 22, color: Colors.white)),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: PreBiteTypography.labelMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
