import 'package:tdesign_flutter/tdesign_flutter.dart';
import '../localization/strings.dart';

const qchatOverlayRadius = 16.0;
const qchatOverlayBarrier = Color(0x66000000);
const qchatOverlayDuration = Duration(milliseconds: 200);

Color overlaySurface(BuildContext c) =>
    Theme.of(c).brightness == Brightness.dark
    ? const Color(0xff202020)
    : Colors.white;

Future<T?> showQChatSheet<T>(BuildContext context, WidgetBuilder builder) =>
    showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: overlaySurface(context),
      barrierColor: qchatOverlayBarrier,
      constraints: const BoxConstraints(maxWidth: 480),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(qchatOverlayRadius),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (c) => SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(c).bottom),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(c).height * .8,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(c).dividerColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  builder(c),
                  const Divider(height: 1),
                  QChatOverlayAction(
                    label: tr(c, 'cancel'),
                    onTap: () => Navigator.pop(c),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

class QChatOverlayAction extends StatelessWidget {
  const QChatOverlayAction({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.selected = false,
  });
  final String label;
  final VoidCallback onTap;
  final Widget? icon;
  final bool selected;

  @override
  Widget build(BuildContext c) => InkWell(
    onTap: onTap,
    child: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[icon!, const SizedBox(width: 12)],
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (selected) ...[
              const SizedBox(width: 12),
              const Icon(Icons.check, color: Color(0xff07c160)),
            ],
          ],
        ),
      ),
    ),
  );
}
