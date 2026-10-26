import 'package:flutter/material.dart';

class PurchaseItem {
  final String name;
  double cost;
  double qty;

  PurchaseItem({required this.name, required this.cost, required this.qty});

  double get total => cost * qty;
}

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({super.key});

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<PurchaseItem> _items = [];
  DateTime _invoiceDate = DateTime.now();

  static const Color _greyBg = Color(0xFFE6E6E6);
  static const Color _pageBg = Color(0xFFFAFAFA);

  double get _grandTotal => _items.fold(0.0, (sum, e) => sum + e.total);

  String get _dateText =>
      '${_invoiceDate.year}-${_invoiceDate.month.toString().padLeft(2, '0')}-${_invoiceDate.day.toString().padLeft(2, '0')}';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _invoiceDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _invoiceDate = picked);
  }

  void _addItem(String name) {
    if (name.trim().isEmpty) return;
    setState(() {
      _items.add(PurchaseItem(name: name.trim(), cost: 0, qty: 1));
      _searchController.clear();
    });
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم الحفظ')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _pageBg,
        appBar: AppBar(
          backgroundColor: _pageBg,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.black, size: 34),
            onPressed: () {},
          ),
          title: const Text(
            'المشتريات',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFF1F4E79), size: 24),
              onPressed: () => Navigator.maybePop(context),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildDateRow(),
            const SizedBox(height: 4),
            _buildSearchRow(),
            _buildTableHeader(),
            Expanded(child: _buildList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFE6E6E6),
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.apps, color: Colors.black87, size: 32),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: _buildFooter(),
      ),
    );
  }

  Widget _buildDateRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 110,
            child: Center(
              child: Text('تاريخ الفاتورة', style: TextStyle(fontSize: 16)),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: _pickDate,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9DBDB),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _dateText,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
        children: [
          // Barcode (يمين في RTL)
          InkWell(
            onTap: () {},
            child: Container(
              width: 84,
              height: 52,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black87, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.qr_code_scanner,
                  size: 38, color: Colors.black87),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              onSubmitted: _addItem,
              decoration: const InputDecoration(
                hintText: 'ابحث عن منتج أو استخدم الكاميرا',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                isDense: true,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic_none, size: 40, color: Colors.black),
            onPressed: () {},
          ),
          // زر الحفظ
          InkWell(
            onTap: _save,
            child: Container(
              width: 56,
              height: 56,
              color: const Color(0xFFE0E0E0),
              child: const Icon(Icons.save, size: 44, color: Color(0xFF2F6FD0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    const style = TextStyle(fontSize: 16, color: Colors.black87);
    return Container(
      color: _greyBg,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
      child: const Row(
        children: [
          Expanded(flex: 4, child: Text('المنتج', style: style)),
          Expanded(flex: 2, child: Text('التكلفه', style: style)),
          Expanded(flex: 2, child: Text('الكمية', style: style)),
          Expanded(
            flex: 2,
            child: Text('الإجمالي', style: style, textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    if (_items.isEmpty) return const SizedBox.expand();
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 90),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final item = _items[i];
        return Dismissible(
          key: ObjectKey(item),
          direction: DismissDirection.horizontal,
          background: Container(color: Colors.red.shade100),
          onDismissed: (_) => setState(() => _items.removeAt(i)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Row(
              children: [
                Expanded(flex: 4, child: Text(item.name)),
                Expanded(flex: 2, child: Text(item.cost.toStringAsFixed(2))),
                Expanded(flex: 2, child: Text(item.qty.toStringAsFixed(0))),
                Expanded(
                  flex: 2,
                  child: Text(item.total.toStringAsFixed(2),
                      textAlign: TextAlign.end),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    const red = TextStyle(
        color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold);
    return SafeArea(
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Row(
          children: [
            const Text('الإجمالي',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEFBC8),
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(_grandTotal.toStringAsFixed(2), style: red),
              ),
            ),
            const SizedBox(width: 8),
            const Text('ريال', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            const Text('ع.ق', style: TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text('0.0', style: red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}