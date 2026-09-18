import 'package:flutter/material.dart';

import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';
import '../../theme/app_colors.dart';

class CustomMultiSelectDropdownField<T> extends StatefulWidget {
  final String label;
  final String hint;
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemLabel;
  final bool Function(T, T) isEqual;
  final ValueChanged<List<T>> onChanged;
  final bool isRequired;
  final bool isLoading;
  final String? errorText;
  final VoidCallback? onRetry;
  final bool enableSearch;
  final String emptyMessage;
  final bool allowCustomEntry;
  final String customEntryLabel;
  final T Function(String value)? onCreateCustomItem;

  const CustomMultiSelectDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.selectedItems,
    required this.itemLabel,
    required this.onChanged,
    this.isEqual = _defaultEquals,
    this.hint = 'Select options',
    this.isRequired = false,
    this.isLoading = false,
    this.errorText,
    this.onRetry,
    this.enableSearch = true,
    this.emptyMessage = 'No options available',
    this.allowCustomEntry = false,
    this.customEntryLabel = 'Other',
    this.onCreateCustomItem,
  });

  static bool _defaultEquals(dynamic a, dynamic b) => a == b;

  @override
  State<CustomMultiSelectDropdownField<T>> createState() =>
      _CustomMultiSelectDropdownFieldState<T>();
}

class _CustomMultiSelectDropdownFieldState<T>
    extends State<CustomMultiSelectDropdownField<T>>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _scaleAnim = Tween<double>(begin: 0.96, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    _animController.dispose();
    super.dispose();
  }

  bool get _hasError => widget.errorText != null;

  bool get _blocked => widget.isLoading || _hasError || widget.items.isEmpty;

  void _toggleDropdown() {
    if (_hasError) {
      widget.onRetry?.call();
      return;
    }
    if (widget.isLoading || widget.items.isEmpty) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _buildOverlay();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
    _animController.forward();
  }

  Future<void> _closeDropdown() async {
    await _animController.reverse();
    _removeOverlay();
    if (mounted) setState(() => _isOpen = false);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _buildOverlay() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;
    final offset = renderBox.localToGlobal(Offset.zero);
    final spaceBelow = screenHeight - offset.dy - size.height;
    final maxPanelHeight = (spaceBelow > 320 ? 320.0 : spaceBelow - 24).clamp(
      180.0,
      320.0,
    );

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Scrim to catch outside taps
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeDropdown,
              child: Container(color: Colors.transparent),
            ),
          ),
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 6),
            child: FadeTransition(
              opacity: _fadeAnim,
              child: ScaleTransition(
                scale: _scaleAnim,
                alignment: Alignment.topCenter,
                child: Material(
                  color: Colors.transparent,
                  child: _DropdownPanel<T>(
                    width: size.width,
                    maxHeight: maxPanelHeight,
                    items: widget.items,
                    initialSelected: widget.selectedItems,
                    itemLabel: widget.itemLabel,
                    isEqual: widget.isEqual,
                    enableSearch: widget.enableSearch,
                    allowCustomEntry: widget.allowCustomEntry,
                    customEntryLabel: widget.customEntryLabel,
                    onCreateCustomItem: widget.onCreateCustomItem,
                    onApply: (selected) {
                      widget.onChanged(selected);
                      _closeDropdown();
                    },
                    onCancel: _closeDropdown,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selectedItems;

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        behavior: HitTestBehavior.opaque,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.label,
                  style: customTextStyle(
                    color: AppColors.labelColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                if (widget.isRequired)
                  Text(
                    ' *',
                    style: customTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
            height(8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              constraints: const BoxConstraints(minHeight: 52),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: _blocked && !_hasError
                    ? const Color(0xFFF8F9FA)
                    : AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _hasError
                      ? Colors.red.shade300
                      : _isOpen
                      ? AppColors.primary
                      : AppColors.fieldBorder,
                  width: _isOpen ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(child: _buildContent(selected)),
                  const SizedBox(width: 8),
                  if (widget.isLoading)
                    const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else if (_hasError)
                    Icon(Icons.refresh, size: 20, color: Colors.red.shade400)
                  else
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 180),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.brown,
                        size: 22,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(List<T> selected) {
    if (widget.isLoading) {
      return Text(
        'Loading...',
        style: customTextStyle(fontSize: 12.5, color: const Color(0xFF94A3B8)),
      );
    }
    if (_hasError) {
      return Text(
        widget.errorText ?? 'Failed to load — tap to retry',
        style: customTextStyle(fontSize: 12, color: Colors.red.shade400),
      );
    }
    if (widget.items.isEmpty) {
      return Text(
        widget.emptyMessage,
        style: customTextStyle(fontSize: 12.5, color: const Color(0xFF94A3B8)),
      );
    }
    if (selected.isEmpty) {
      return Text(
        widget.hint,
        style: customTextStyle(fontSize: 12.5, color: const Color(0xFF94A3B8)),
      );
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: selected.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.itemLabel(item),
                style: customTextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  final updated = selected
                      .where((e) => !widget.isEqual(e, item))
                      .toList();
                  widget.onChanged(updated);
                },
                child: Icon(
                  Icons.close_rounded,
                  size: 13,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _DropdownPanel<T> extends StatefulWidget {
  final double width;
  final double maxHeight;
  final List<T> items;
  final List<T> initialSelected;
  final String Function(T) itemLabel;
  final bool Function(T, T) isEqual;
  final bool enableSearch;
  final bool allowCustomEntry;
  final String customEntryLabel;
  final T Function(String value)? onCreateCustomItem;
  final ValueChanged<List<T>> onApply;
  final VoidCallback onCancel;

  const _DropdownPanel({
    required this.width,
    required this.maxHeight,
    required this.items,
    required this.initialSelected,
    required this.itemLabel,
    required this.isEqual,
    required this.enableSearch,
    required this.allowCustomEntry,
    required this.customEntryLabel,
    required this.onCreateCustomItem,
    required this.onApply,
    required this.onCancel,
  });

  @override
  State<_DropdownPanel<T>> createState() => _DropdownPanelState<T>();
}

class _DropdownPanelState<T> extends State<_DropdownPanel<T>> {
  late List<T> _selected;
  String _query = '';
  bool _showCustomInput = false;
  final _customController = TextEditingController();
  final _customFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _selected = [...widget.initialSelected];
  }

  @override
  void dispose() {
    _customController.dispose();
    _customFocusNode.dispose();
    super.dispose();
  }

  bool _isSelected(T item) => _selected.any((e) => widget.isEqual(e, item));

  /// True if this row should render as checked. For a clean single-value
  /// item this is just _isSelected. For a dirty combined entry like
  /// "C, D" it's checked only when every comma-separated piece is
  /// already present in the current selection.
  bool _isRowSelected(T item) {
    final parts = widget
        .itemLabel(item)
        .split(',')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();

    if (parts.length <= 1) return _isSelected(item);

    return parts.every(
      (token) => _selected.any(
        (e) => widget.itemLabel(e).toLowerCase() == token.toLowerCase(),
      ),
    );
  }

  void _toggle(T item) {
    final parts = widget
        .itemLabel(item)
        .split(',')
        .map((p) => p.trim())
        .where((p) => p.isNotEmpty)
        .toList();

    // Clean single-value item — original behavior.
    if (parts.length <= 1) {
      setState(() {
        if (_isSelected(item)) {
          _selected.removeWhere((e) => widget.isEqual(e, item));
        } else {
          _selected.add(item);
        }
      });
      return;
    }

    // Dirty combined master-data entry (e.g. "C, D") — expand into
    // real degrees where they exist in the list, else synthesize custom
    // ones, and select/deselect each piece independently.
    final expanded = parts.map((token) {
      return widget.items.firstWhere(
        (e) => widget.itemLabel(e).toLowerCase() == token.toLowerCase(),
        orElse: () => widget.onCreateCustomItem?.call(token) ?? item,
      );
    }).toList();

    final allSelected = expanded.every(_isSelected);

    setState(() {
      if (allSelected) {
        for (final p in expanded) {
          _selected.removeWhere((e) => widget.isEqual(e, p));
        }
      } else {
        for (final p in expanded) {
          if (!_isSelected(p)) _selected.add(p);
        }
      }
    });
  }

  // void _submitCustom() {
  //   final text = _customController.text.trim();
  //   if (text.isEmpty || widget.onCreateCustomItem == null) return;
  //
  //   final item = widget.onCreateCustomItem!(text);
  //   setState(() {
  //     _selected.add(item);
  //     _customController.clear();
  //     _showCustomInput = false;
  //   });
  // }
  void _submitCustom() {
    final raw = _customController.text.trim();
    if (raw.isEmpty || widget.onCreateCustomItem == null) return;

    final tokens = raw
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    if (tokens.isEmpty) return;

    setState(() {
      for (final token in tokens) {
        final exists =
            _selected.any(
              (e) => widget.itemLabel(e).toLowerCase() == token.toLowerCase(),
            ) ||
            widget.items.any(
              (e) => widget.itemLabel(e).toLowerCase() == token.toLowerCase(),
            );
        if (!exists) {
          _selected.add(widget.onCreateCustomItem!(token));
        }
      }
      _customController.clear();
      _showCustomInput = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? widget.items
        : widget.items
              .where(
                (e) => widget
                    .itemLabel(e)
                    .toLowerCase()
                    .contains(_query.toLowerCase()),
              )
              .toList();

    final showOtherRow = widget.allowCustomEntry && _query.isEmpty;
    final totalRows = filtered.length + (showOtherRow ? 1 : 0);

    return Container(
      width: widget.width,
      constraints: BoxConstraints(maxHeight: widget.maxHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.enableSearch)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 18, color: Colors.grey.shade500),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        style: customTextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: customTextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        onChanged: (v) => setState(() => _query = v),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Flexible(
            child: totalRows == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Center(
                      child: Text(
                        'No matches',
                        style: customTextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: totalRows,
                    itemBuilder: (context, index) {
                      if (showOtherRow && index == filtered.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          child: _showCustomInput
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _customController,
                                        focusNode: _customFocusNode,
                                        autofocus: true,
                                        style: customTextStyle(fontSize: 13),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'Type and press enter',
                                          hintStyle: customTextStyle(
                                            fontSize: 12.5,
                                            color: Colors.grey.shade500,
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 10,
                                              ),
                                          filled: true,
                                          fillColor: const Color(0xFFF3F4F6),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        textInputAction: TextInputAction.done,
                                        onSubmitted: (_) => _submitCustom(),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.check_circle,
                                        color: AppColors.primary,
                                        size: 22,
                                      ),
                                      onPressed: _submitCustom,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.grey.shade400,
                                        size: 20,
                                      ),
                                      onPressed: () => setState(() {
                                        _showCustomInput = false;
                                        _customController.clear();
                                      }),
                                    ),
                                  ],
                                )
                              : InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () =>
                                      setState(() => _showCustomInput = true),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle_outline,
                                          size: 18,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.customEntryLabel,
                                          style: customTextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        );
                      }
                      final item = filtered[index];
                      final selected = _isRowSelected(item);
                      return InkWell(
                        onTap: () => _toggle(item),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 11,
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                height: 19,
                                width: 19,
                                decoration: BoxDecoration(
                                  color: selected
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: selected
                                        ? AppColors.primary
                                        : Colors.grey.shade400,
                                    width: 1.4,
                                  ),
                                ),
                                child: selected
                                    ? const Icon(
                                        Icons.check,
                                        size: 13,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  widget.itemLabel(item),
                                  style: customTextStyle(
                                    fontSize: 13,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    color: selected
                                        ? AppColors.primary
                                        : AppColors.textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Text(
                  '${_selected.length} selected',
                  style: customTextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => setState(() => _selected.clear()),
                  child: Text(
                    'Clear',
                    style: customTextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () => widget.onApply(_selected),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Apply',
                    style: customTextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
