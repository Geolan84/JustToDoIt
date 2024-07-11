import 'package:flutter/material.dart';

/// Default circular loading widget with centering.
class LoadingStateWidget extends StatelessWidget {
  /// @nodoc.
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(4),
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
