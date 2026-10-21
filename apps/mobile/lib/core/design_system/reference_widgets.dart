import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:go_router/go_router.dart';
import 'components.dart';
import '../localization/strings.dart';

const sectionGap = SizedBox(height: 9);
const menuBlue = Color(0xff168fe5);
void openFeature(BuildContext c, String key) => c.push('/feature/$key');

class MenuRow extends StatelessWidget {
  const MenuRow(
    this.label, {
    super.key,
    this.icon,
    this.color = menuBlue,
    this.value,
    this.subtitle,
    this.onTap,
    this.boxed = false,
    this.trailing,
  });
  final String label;
  final String? icon, value, subtitle;
  final Color color;
  final VoidCallback? onTap;
  final bool boxed;
  final Widget? trailing;
  @override
  Widget build(BuildContext c) => QChatListTile(
    title: tr(c, label),
    titleLines: label == 'invoice' ? 2 : 1,
    subtitle: subtitle == null ? null : tr(c, subtitle!),
    leading: icon == null
        ? null
        : boxed
        ? Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: QChatIcon(icon!, color: Colors.white, size: 27),
            ),
          )
        : SizedBox(width: 26, child: QChatIcon(icon!, color: color, size: 23)),
    trailing:
        trailing ??
        (value == null
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 190),
                    child: Text(
                      value!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: QChatColors.muted,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const QChatIcon(
                    'chevron',
                    size: 18,
                    color: Color(0xffb8b8b8),
                  ),
                ],
              )),
    onTap: onTap ?? () => openFeature(c, label),
  );
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.label, {super.key});
  final String label;
  @override
  Widget build(BuildContext c) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 18, 16, 7),
    child: Text(
      tr(c, label),
      style: const TextStyle(fontSize: 14, color: Color(0xff888888)),
    ),
  );
}

Future<void> qchatTopMenu(
  BuildContext context,
  List<(String, String, VoidCallback)> actions,
) => showGeneralDialog<void>(
  context: context,
  barrierDismissible: true,
  barrierLabel: tr(context, 'cancel'),
  barrierColor: qchatOverlayBarrier,
  transitionDuration: qchatOverlayDuration,
  pageBuilder: (c, _, _) => SafeArea(
    child: Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 49,
          right: 12,
          left: 12,
          bottom: 12,
        ),
        child: Material(
          color: overlaySurface(c),
          borderRadius: BorderRadius.circular(qchatOverlayRadius),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 260,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final a in actions)
                    QChatOverlayAction(
                      label: tr(c, a.$2),
                      icon: QChatIcon(a.$1, color: ink(c), size: 24),
                      onTap: () {
                        Navigator.pop(c);
                        a.$3();
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  ),
);

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key, required this.kind});
  final String kind;
  @override
  Widget build(BuildContext c) => QChatPage(
    title: tr(c, kind),
    leading: QChatIconButton(
      'back',
      label: tr(c, 'back'),
      onTap: () => c.pop(),
    ),
    child: QChatEmptyState(tr(c, 'serviceLater'), icon: 'settings'),
  );
}
