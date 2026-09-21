import 'package:Doctors_App/core/constants/responsive.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Reusable time (7/30/90 day) + search filter row.
/// Toggling search hides the time chips and shows a text field instead.
class PeerForumFilterBar extends StatefulWidget {
  final int selectedTime;
  final String searchQuery;
  final ValueChanged<int> onTimeChanged;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onSearchCleared;

  const PeerForumFilterBar({
    super.key,
    required this.selectedTime,
    required this.searchQuery,
    required this.onTimeChanged,
    required this.onSearchChanged,
    required this.onSearchCleared,
  });

  @override
  State<PeerForumFilterBar> createState() => _PeerForumFilterBarState();
}

class _PeerForumFilterBarState extends State<PeerForumFilterBar> {
  static const List<_TimeOption> _timeOptions = [
    _TimeOption(label: '7D', value: 7),
    _TimeOption(label: '30D', value: 30),
    _TimeOption(label: '90D', value: 90),
  ];

  late bool _searchExpanded = widget.searchQuery.isNotEmpty;
  late final TextEditingController _searchController =
  TextEditingController(text: widget.searchQuery);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    if (_searchExpanded && _searchController.text.isNotEmpty) {
      _searchController.clear();
      widget.onSearchCleared();
    }
    setState(() => _searchExpanded = !_searchExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      child: Row(
        children: [
          Expanded(
            child: _searchExpanded ? _buildSearchField() : _buildTimeChips(),
          ),
          SizedBox(width: Responsive.w(8)),
          _buildSearchToggle(),
        ],
      ),
    );
  }

  Widget _buildTimeChips() {
    return SizedBox(
      height: Responsive.h(32),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _timeOptions.length,
        separatorBuilder: (_, __) => SizedBox(width: Responsive.w(8)),
        itemBuilder: (_, index) {
          final option = _timeOptions[index];
          final selected = option.value == widget.selectedTime;
          return GestureDetector(
            onTap: () => widget.onTimeChanged(option.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(14),
                vertical: Responsive.h(6),
              ),
              decoration: BoxDecoration(
                color: selected ? AppColors.newPri : Colors.white,
                borderRadius: BorderRadius.circular(Responsive.w(30)),
                border: Border.all(
                  color: selected ? Colors.transparent : Colors.grey.shade300,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                option.label,
                style: customTextStyle(
                  fontSize: Responsive.sp(11.5),
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.grey.shade700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      height: Responsive.h(36),
      child: TextField(
        controller: _searchController,
        autofocus: true,
        onChanged: (value) {
          widget.onSearchChanged(value);
          setState(() {}); // refresh clear icon visibility
        },
        style: customTextStyle(fontSize: Responsive.sp(12.5)),
        decoration: InputDecoration(
          hintText: 'Search posts...',
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Responsive.w(14),
            vertical: Responsive.h(8),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Responsive.w(30)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? GestureDetector(
            onTap: () {
              _searchController.clear();
              widget.onSearchCleared();
              setState(() {});
            },
            child: const Icon(Icons.close, size: 16),
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildSearchToggle() {
    return GestureDetector(
      onTap: _toggleSearch,
      child: Container(
        height: Responsive.h(32),
        width: Responsive.h(32),
        decoration: BoxDecoration(
          color: _searchExpanded ? AppColors.newPri : Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: _searchExpanded ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          _searchExpanded ? Icons.close : Icons.search,
          size: Responsive.sp(16),
          color: _searchExpanded ? Colors.white : Colors.grey.shade700,
        ),
      ),
    );
  }
}

class _TimeOption {
  final String label;
  final int value;
  const _TimeOption({required this.label, required this.value});
}