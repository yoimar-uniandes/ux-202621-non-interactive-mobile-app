import 'package:fakto_mobile/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaktoBottomNavigationBar extends StatelessWidget {
  const FaktoBottomNavigationBar({required this.onAddPressed, super.key});

  final VoidCallback onAddPressed;

  static const _items = <_NavigationItemData>[
    _NavigationItemData(
      label: 'Inicio',
      assetName: 'assets/icons/home-selected.svg',
      iconWidth: 20,
      isSelected: true,
    ),
    _NavigationItemData(
      label: 'Grupo',
      assetName: 'assets/icons/group.svg',
      iconWidth: 24,
    ),
    _NavigationItemData(
      label: 'Perfil',
      assetName: 'assets/icons/profile.svg',
      iconWidth: 16,
    ),
    _NavigationItemData(
      label: 'Ajustes',
      assetName: 'assets/icons/settings.svg',
      iconWidth: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
    key: const Key('bottom-navigation'),
    height: 80,
    child: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.neutral300),
            ),
          ),
        ),
        Positioned.fill(
          child: Row(
            children: <Widget>[
              Expanded(child: _NavigationItem(data: _items[0])),
              Expanded(child: _NavigationItem(data: _items[1])),
              const SizedBox(width: 88),
              Expanded(child: _NavigationItem(data: _items[2])),
              Expanded(child: _NavigationItem(data: _items[3])),
            ],
          ),
        ),
        Positioned(
          top: -16,
          left: 0,
          right: 0,
          child: Center(
            child: Semantics(
              button: true,
              label: 'Añadir',
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 0.8),
                      blurRadius: 1.5,
                    ),
                    BoxShadow(
                      color: Color(0x33000000),
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Material(
                  color: AppColors.primary500,
                  shape: const CircleBorder(),
                  child: InkWell(
                    key: const Key('add-reminder-button'),
                    onTap: onAddPressed,
                    customBorder: const CircleBorder(),
                    child: SizedBox.square(
                      dimension: 56,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/add.svg',
                          width: 14,
                          height: 14,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 48,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Text(
              'Añadir',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall
                  ?.copyWith(color: AppColors.textPrimary),
            ),
          ),
        ),
      ],
    ),
  );
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({required this.data});

  final _NavigationItemData data;

  @override
  Widget build(BuildContext context) {
    final itemColor = data.isSelected
        ? AppColors.primary500
        : AppColors.textSecondary;

    return Semantics(
      button: true,
      selected: data.isSelected,
      label: data.label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                top: 12,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Center(
                    child: SvgPicture.asset(
                      data.assetName,
                      width: data.iconWidth,
                      excludeFromSemantics: true,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 44,
                left: 0,
                right: 0,
                child: Text(
                  data.label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style:
                      (data.isSelected
                              ? Theme.of(context).textTheme.labelSmall
                              : Theme.of(context).textTheme.bodySmall)
                          ?.copyWith(color: itemColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationItemData {
  const _NavigationItemData({
    required this.label,
    required this.assetName,
    required this.iconWidth,
    this.isSelected = false,
  });

  final String label;
  final String assetName;
  final double iconWidth;
  final bool isSelected;
}
