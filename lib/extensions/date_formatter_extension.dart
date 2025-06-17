
extension DateFormatting on String {
  String formatToDate() {
    try {
      final date = DateTime.parse(this);
      return "${date.day.toString().padLeft(2, '0')} ${_monthAbbr(date.month)} ${date.year.toString().substring(2)}";
    } catch (e) {
      return '';
    }
  }

  String _monthAbbr(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}