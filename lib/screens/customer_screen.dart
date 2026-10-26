import 'package:flutter/material.dart';

/// شاشة العملاء
/// ملاحظة: MaterialApp موجود في شاشة أخرى، لذلك هذه الشاشة تعتمد على Scaffold فقط.
class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <_MenuItem>[
      _MenuItem(
        title: 'اضافة عميل جديد',
        icon: const Icon(Icons.add, color: Color(0xFF6DB521), size: 40),
        onTap: () {
          // TODO: الانتقال إلى شاشة إضافة عميل جديد
        },
      ),
      _MenuItem(
        title: 'ألارصدة الافتتاحيه والمبالغ النقدية للعملاء',
        icon: Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            color: Color(0xFF4A5057),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.currency_exchange,
              color: Color(0xFFF2994A), size: 28),
        ),
        onTap: () {
          // TODO: الانتقال إلى شاشة الأرصدة الافتتاحية
        },
      ),
      _MenuItem(
        title: 'ذمم العملاء - المبالغ المتبقية عند العملاء من الفواتير الآجل',
        icon: const Icon(Icons.account_circle,
            color: Color(0xFF2B2B2B), size: 48),
        onTap: () {
          // TODO: الانتقال إلى شاشة الذمم
        },
      ),
      _MenuItem(
        title: 'ذمم العملاء - تقرير',
        icon: const Icon(Icons.receipt_long, color: Colors.black54, size: 40),
        onTap: () {
          // TODO: تقرير ذمم العملاء
        },
      ),
      _MenuItem(
        title: 'العملاء المتبقي لهم أرصدة - تقرير',
        icon: const Icon(Icons.receipt_long, color: Colors.black54, size: 40),
        onTap: () {
          // TODO: تقرير العملاء المتبقي لهم أرصدة
        },
      ),
      _MenuItem(
        title: 'فحص ارصدة العملاء',
        icon: const Icon(Icons.receipt_long, color: Colors.black54, size: 40),
        onTap: () {
          // TODO: فحص أرصدة العملاء
        },
      ),
      _MenuItem(
        title: 'عرض العملاء',
        icon: const Icon(Icons.search, color: Colors.grey, size: 44),
        onTap: () {
          // TODO: عرض العملاء
        },
      ),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Column(
            children: [
              // ===== الترويسة =====
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: SizedBox(
                  height: 120,
                  child: Row(
                    children: [
                      // الصورة (تظهر على اليمين في RTL)
                      const CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.transparent,
                        child: Icon(Icons.account_circle,
                            size: 88, color: Color(0xFF3A3A3A)),
                        // يمكن استبدالها بـ: backgroundImage: AssetImage('assets/images/client.png'),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'العملاء',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                      ),
                      // موازنة المساحة لتوسيط العنوان
                      const SizedBox(width: 88),
                    ],
                  ),
                ),
              ),

              // ===== القائمة =====
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) =>
                      _MenuTile(item: items[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final Widget icon;
  final VoidCallback onTap;

  const _MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}

class _MenuTile extends StatelessWidget {
  final _MenuItem item;

  const _MenuTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: item.onTap,
        child: Container(
          constraints: const BoxConstraints(minHeight: 118),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFDDDDDD), width: 1.5),
            ),
          ),
          child: Row(
            children: [
              // الأيقونة على اليمين (RTL)
              SizedBox(width: 56, child: Center(child: item.icon)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF222222),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}