
import 'package:flutter/material.dart';
 
class MenuItem {
  final String title;
  final String imagePath;
  final String routeName;
  const MenuItem(this.title, this.imagePath, this.routeName);
}
 
// مسارات الصور وهمية - استبدلها بمساراتك الحقيقية داخل مجلد assets
const List<MenuItem> menuItems = [
  MenuItem('المبيعات', 'images/sales.png', '/sales'),
  MenuItem('المشتريات', 'images/purchases.png', '/purchases'),
  MenuItem('العملاء', 'images/customers.png', '/customers'),
  MenuItem('الموردين', 'images/suppliers.png', '/suppliers'),
  MenuItem('الصندوق', 'images/storage.png', '/storage'),
  MenuItem('المصروفات', 'images/expenses.png', '/expenses'),
  MenuItem('المخزون', 'images/inventory.png', '/inventory'),
  MenuItem('الاستعلامات', 'images/reports.png', '/reports'),
];
 
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF2A3580), Color(0xFF4A56B0), Color(0xFF7B88C8)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () {},
        ),
        title: const Text(
          'MicroPOS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.mail, color: Color(0xFFFFC107), size: 38),
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB71C1C),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // اتجاه الشبكة من اليمين لليسار
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.04,
          ),
          itemBuilder: (context, index) => MenuCard(item: menuItems[index]),
        ),
      ),
    );
  }
}
 
class MenuCard extends StatelessWidget {
  final MenuItem item;
  const MenuCard({super.key, required this.item});
 
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
         Navigator.pushNamed(context, item.routeName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.contain,
              // أيقونة بديلة تظهر طالما الصورة غير موجودة
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image_outlined,
                size: 70,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
