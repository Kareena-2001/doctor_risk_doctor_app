import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../constants/dimensions.dart';
import '../constants/values/app_text_style.dart';
import 'custom_checkbox.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String? label;
  final List<String> options;
  final List<String> selectedItems;
  final Function(List<String>) onSelectionChanged;
  final String hintText;
  final bool isRequired;
  final double? maxHeight;
  final Map<String, String?> optionAmounts;

  const MultiSelectDropdown({
    super.key,
    required this.label,
    required this.options,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.hintText = 'Select items',
    this.isRequired = false,
    this.maxHeight = 200,
    this.optionAmounts = const {},
  });

  @override
  State<MultiSelectDropdown> createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  final TextEditingController _searchController = TextEditingController();
  bool _isDropdownOpen = false;
  List<String> _filteredOptions = [];

  @override
  void initState() {
    super.initState();
    _filteredOptions = List.from(widget.options);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
      if (_isDropdownOpen) {
        _filteredOptions = List.from(widget.options);
        _searchController.clear();
      }
    });
  }

  void _filterOptions(String query) {
    setState(() {
      _filteredOptions = widget.options
          .where((option) => option.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectAll() {
    widget.onSelectionChanged(List.from(_filteredOptions));
  }

  void _clearAll() {
    widget.onSelectionChanged([]);
  }

  void _toggleSelection(String item) {
    List<String> updatedSelection = List.from(widget.selectedItems);
    if (updatedSelection.contains(item)) {
      updatedSelection.remove(item);
    } else {
      updatedSelection.add(item);
    }
    widget.onSelectionChanged(updatedSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: double.infinity),
              child: Text(
                widget.label ?? '',
                style: customTextStyle(
                  color: AppColors.labelColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                softWrap: true,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isDropdownOpen
                  ? const Color(0xFF345FB4)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildDropdownTrigger(),
              if (_isDropdownOpen) _buildDropdownContent(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownTrigger() {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.hintText,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Icon(
              _isDropdownOpen
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSearchField(),
          _buildActionButtons(),
          Divider(height: 1),
          _buildOptionsList(),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _searchController,
        onChanged: _filterOptions,
        decoration: InputDecoration(
          hintText: 'Search ${widget.label}...',
          hintStyle: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500]),
          prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFF345FB4)),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: _selectAll,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Select All',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF345FB4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextButton(
              onPressed: _clearAll,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Clear All',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList() {
    return Container(
      constraints: BoxConstraints(maxHeight: widget.maxHeight ?? 200),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _filteredOptions.length,
        itemBuilder: (context, index) {
          final option = _filteredOptions[index];
          final isSelected = widget.selectedItems.contains(option);
          final amount = widget.optionAmounts[option];

          return InkWell(
            onTap: () => _toggleSelection(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF345FB4).withValues(alpha: 0.1)
                    : Colors.transparent,
              ),
              child: Row(
                children: [
                  CustomCheckbox(
                    value: isSelected,
                    onChanged: (value) => _toggleSelection(option),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          option,
                          style: customTextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF345FB4)
                                : const Color(0xFF434343),
                          ),
                        ),
                        if (amount != null && amount.isNotEmpty)
                          Text(
                            '₹ $amount',
                            style: customTextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[700],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
