import 'package:flutter/material.dart';
 
class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});
 
  static const Color _teal = Color(0xFF26C6BE);
  static const Color _orange = Color(0xFFF5B22E);
  static const Color _lightGreen = Color(0xFFF1FBD3);
  static const Color _headerGrey = Color(0xFFE4E4E4);
 
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0,
          centerTitle: true,
          // في RTL: leading يظهر على اليمين (القائمة)
          leading: IconButton(
            icon: const Icon(Icons.menu, size: 36, color: Colors.black),
            onPressed: () {},
          ),
          title: const Text(
            'المبيعات',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  size: 24, color: Color(0xFF1F4E79)),
              onPressed: () => Navigator.maybePop(context),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            _buildTableHeader(),
            const Expanded(child: SizedBox()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          mini: false,
          backgroundColor: const Color(0xFFEDEDED),
          elevation: 3,
          shape: const CircleBorder(),
          onPressed: () {},
          child: const Icon(Icons.dialpad, color: Colors.black, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }
 
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          // أيقونة الباركود
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.qr_code_scanner,
                  size: 36, color: Colors.black),
            ),
          ),
          const SizedBox(width: 10),
          // أيقونة جهات الاتصال
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _orange,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.contacts, size: 34, color: Colors.white),
            ),
          ),
          const SizedBox(width: 8),
          // حقل البحث
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن منتج أو استخدم الكامير',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                isDense: true,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _teal, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _teal, width: 2),
                ),
              ),
              cursorColor: _teal,
            ),
          ),
          const SizedBox(width: 8),
          // مربع الأرقام 1 2 3 4
          _buildNumberGrid(),
          const SizedBox(width: 8),
          // زر حاسب
          InkWell(
            onTap: () {},
            child: Container(
              width: 56,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 2,
                    child: Icon(Icons.monetization_on,
                        color: Color(0xFFF5B22E), size: 26),
                  ),
                  const Positioned(
                    bottom: 2,
                    child: Icon(Icons.pan_tool_alt,
                        color: Color(0xFF1F4E79), size: 22),
                  ),
                  const Text(
                    'حاسب',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildNumberGrid() {
    Widget cell(String text, {bool selected = false}) {
      return Container(
        width: 22,
        height: 22,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF00E000) : Colors.white,
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      );
    }
 
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisSize: MainAxisSize.min,
              children: [cell('1', selected: true), cell('2')]),
          Row(mainAxisSize: MainAxisSize.min, children: [cell('3'), cell('4')]),
        ],
      ),
    );
  }
 
  Widget _buildTableHeader() {
    const style = TextStyle(fontSize: 17, color: Colors.black87);
    return Container(
      color: _headerGrey,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: const Row(
        children: [
          Expanded(flex: 4, child: Text('المنتج', style: style)),
          Expanded(flex: 2, child: Text('السعر', style: style)),
          Expanded(flex: 2, child: Text('الكمية', style: style)),
          Expanded(flex: 2, child: Text('الإجمالي', style: style)),
        ],
      ),
    );
  }
 
  Widget _buildBottomBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade400)),
        ),
        child: Row(
          children: [
            const Text(
              'الإجمالي+TAX',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 6),
            Expanded(
              flex: 3,
              child: Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _lightGreen,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '0.00',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            const Text('ريال', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            const Text('ع.ق', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Expanded(
              flex: 2,
              child: Container(
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  '0.0',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}