import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'subscription_data.dart';
import 'payment_methods.dart';
import 'package:fl_chart/fl_chart.dart'; // pubspec.yamlにfl_chart: ^0.66.0 などを追加してください
import 'package:url_launcher/url_launcher.dart'; // pubspec.yamlに url_launcher: ^6.2.5 などを追加してください
import 'subscription_guide_data.dart';
import 'package:intl/intl.dart'; // pubspec.yamlに intl: ^0.18.1 などを追加してください
import 'package:shared_preferences/shared_preferences.dart'; // pubspec.yamlに shared_preferences: ^2.2.2 などを追加
import 'dart:convert'; // 追加: jsonDecodeを使うため

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await flutterLocalNotificationsPlugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SubscriptionHomePage(),
      routes: {
        '/guide': (context) => const SubscriptionGuidePage(),
        '/howto': (context) => const HowToUsePage(), // 追加
        '/inquiry': (context) => const InquiryPage(), // 追加
      },
    );
  }
}

class SubscriptionHomePage extends StatefulWidget {
  const SubscriptionHomePage({super.key});

  @override
  State<SubscriptionHomePage> createState() => _SubscriptionHomePageState();
}

class _SubscriptionHomePageState extends State<SubscriptionHomePage> {
  final List<Map<String, dynamic>> _subscriptions = [];
  final List<Map<String, dynamic>> _fanclubs = [];

  @override
  void initState() {
    super.initState();
    _loadData();
    // チュートリアル表示
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorialDialog();
    });
  }

  void _showTutorialDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // 背景タップで閉じない
      builder: (context) {
        return AlertDialog(
          title: const Text('ようこそ！サブスク管理アプリ チュートリアル'),
          content: SingleChildScrollView(
            child: Column(
              children: const [
                Text('このアプリでは、サブスクリプションやファンクラブの管理が簡単にできます。'),
                SizedBox(height: 12),
                Text('■ サブスク追加', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('・メニューから「サブスク追加」でサービス・プラン・開始日などを登録できます。VtuberやYouTuberのメンバーシップも追加可能です。'),
                SizedBox(height: 8),
                Text('■ ファンクラブ追加', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('・「ファンクラブ追加」から任意のファンクラブも管理できます。FantiaやFANBOXなどの会費登録はこちらです。'),
                SizedBox(height: 8),
                Text('■ 合計金額・グラフ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('・月毎・年毎・年間総額や、支払い方法ごとのグラフも確認できます。'),
                SizedBox(height: 8),
                Text('■ サブスク案内', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('・「サブスク案内」では各サービスの特徴や公式サイトもチェックできます。'),
                SizedBox(height: 8),
                Text('■ 無料期間通知', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('・「無料期間通知設定」で無料期間終了前に通知を受け取れます。'),
                SizedBox(height: 8),
                Text('■ その他', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('・「アプリの使い方」や「お問い合わせ」もメニューからご利用いただけます。'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  // データの保存・読込
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('subscriptions', _encodeList(_subscriptions));
    prefs.setString('fanclubs', _encodeList(_fanclubs));
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final subStr = prefs.getString('subscriptions');
    final fanStr = prefs.getString('fanclubs');
    setState(() {
      _subscriptions.clear();
      _fanclubs.clear();
      // サブスク
      if (subStr != null && subStr.isNotEmpty) {
        try {
          _subscriptions.addAll(List<Map<String, dynamic>>.from(_decodeList(subStr)));
        } catch (e) {
          // フォーマットエラー時は空リストで初期化
          _subscriptions.clear();
        }
      }
      // ファンクラブ
      if (fanStr != null && fanStr.isNotEmpty) {
        try {
          _fanclubs.addAll(List<Map<String, dynamic>>.from(_decodeList(fanStr)));
        } catch (e) {
          _fanclubs.clear();
        }
      }
    });
  }

  String _encodeList(List<Map<String, dynamic>> list) =>
      jsonEncode(list.map((e) => e.map((k, v) => MapEntry(k, v is DateTime ? v.toIso8601String() : v))).toList());

  List<dynamic> _decodeList(String str) => jsonDecode(str);

  void _addSubscription(Map<String, dynamic> data) {
    setState(() {
      _subscriptions.add(data);
    });
    _saveData();
  }

  void _addFanClub(Map<String, dynamic> data) {
    setState(() {
      _fanclubs.add(data);
    });
    _saveData();
  }

  void _showAddDialog() {
    String? selectedService;
    String? selectedInterval;
    SubscriptionPlan? selectedPlan;
    DateTime? startDate;
    int? price;
    String? selectedPayment;
    String searchText = '';

    final TextEditingController notifyDaysController = TextEditingController(text: '3'); // デフォルト3日前

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            List<SubscriptionService> filteredServices = subscriptionServices.where((s) {
              if (searchText.isEmpty) return true;
              final serviceName = s.name.toLowerCase();
              final search = searchText.toLowerCase();
              return serviceName.contains(search);
            }).toList();

            SubscriptionService? service = selectedService != null
                ? subscriptionServices.firstWhere((s) => s.name == selectedService)
                : null;
            List<SubscriptionPlan> plans = service?.plans ?? [];
            // サービスごとに定義されたintervalsのみを選択肢に
            final List<String> intervalOptions = service?.intervals ?? [];

            return AlertDialog(
              title: const Text('サブスク追加'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'サービス名検索',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'サービス名'),
                      value: filteredServices.any((s) => s.name == selectedService) ? selectedService : null,
                      items: filteredServices
                          .map((s) => DropdownMenuItem(
                                value: s.name,
                                child: Text(s.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedService = value;
                          selectedInterval = null;
                          selectedPlan = null;
                          price = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('開始日: '),
                        Text(
                          startDate != null
                              ? "${startDate!.year}/${startDate!.month}/${startDate!.day}"
                              : '未選択',
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                startDate = picked;
                              });
                            }
                          },
                        ),
                        if (startDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: '日付を未選択に戻す',
                            onPressed: () {
                              setState(() {
                                startDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 月毎・年毎を固定で選択
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: '間隔'),
                      value: selectedInterval,
                      items: intervalOptions
                          .map((interval) => DropdownMenuItem(
                                value: interval,
                                child: Text(interval),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedInterval = value;
                          selectedPlan = null;
                          price = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    // プランドロップダウン（intervalは参照しない）
                    DropdownButtonFormField<SubscriptionPlan>(
                      decoration: const InputDecoration(labelText: 'プラン'),
                      value: selectedPlan,
                      items: plans
                          .map((plan) => DropdownMenuItem(
                                value: plan,
                                child: Text(plan.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPlan = value;
                          price = value?.price;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: '支払い方法'),
                      value: selectedPayment,
                      items: paymentMethods
                          .map((method) => DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('金額: '),
                        Text(price != null ? '$price 円' : '未選択'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notifyDaysController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '課金日通知（何日前）',
                        hintText: '例: 3',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: (selectedService != null &&
                          selectedInterval != null &&
                          selectedPlan != null &&
                          selectedPayment != null)
                      ? () {
                          _addSubscription({
                            'service': selectedService,
                            'plan': selectedPlan!.name,
                            'interval': selectedInterval,
                            'startDate': startDate,
                            'price': price,
                            'payment': selectedPayment,
                          });
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('追加'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _editSubscription(int index) {
    final sub = _subscriptions[index];
    String? selectedService = sub['service'];
    String? selectedInterval = sub['interval'];
    SubscriptionService? service = selectedService != null
        ? subscriptionServices.firstWhere((s) => s.name == selectedService)
        : null;
    List<SubscriptionPlan> plans = service?.plans ?? [];
    SubscriptionPlan? selectedPlan = plans
        .firstWhere(
          (p) => p.name == sub['plan'],
          orElse: () => plans.isNotEmpty ? plans.first : SubscriptionPlan(name: '未設定', price: 0),
        );
    DateTime? startDate;
    final startDateRaw = sub['startDate'];
    if (startDateRaw is DateTime) {
      startDate = startDateRaw;
    } else if (startDateRaw is String && startDateRaw.isNotEmpty) {
      startDate = DateTime.tryParse(startDateRaw);
    }
    int? price = sub['price'];
    String? selectedPayment = sub['payment'];
    String searchText = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            List<SubscriptionService> filteredServices = subscriptionServices.where((s) {
              if (searchText.isEmpty) return true;
              final serviceName = s.name.toLowerCase();
              final search = searchText.toLowerCase();
              return serviceName.contains(search);
            }).toList();

            SubscriptionService? service = selectedService != null
                ? subscriptionServices.firstWhere((s) => s.name == selectedService)
                : null;
            List<SubscriptionPlan> plans = service?.plans ?? [];
            // サービスごとに定義されたintervalsのみを選択肢に
            final List<String> intervalOptions = service?.intervals ?? [];

            return AlertDialog(
              title: const Text('サブスク編集'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'サービス名検索',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'サービス名'),
                      value: filteredServices.any((s) => s.name == selectedService) ? selectedService : null,
                      items: filteredServices
                          .map((s) => DropdownMenuItem(
                                value: s.name,
                                child: Text(s.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedService = value;
                          selectedInterval = null;
                          selectedPlan = null;
                          price = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('開始日: '),
                        Text(
                          startDate != null
                              ? "${startDate!.year}/${startDate!.month}/${startDate!.day}"
                              : '未選択',
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: startDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                startDate = picked;
                              });
                            }
                          },
                        ),
                        if (startDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: '日付を未選択に戻す',
                            onPressed: () {
                              setState(() {
                                startDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 月毎・年毎を固定で選択
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: '間隔'),
                      value: selectedInterval,
                      items: intervalOptions
                          .map((interval) => DropdownMenuItem(
                                value: interval,
                                child: Text(interval),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedInterval = value;
                          selectedPlan = null;
                          price = null;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    // プランドロップダウン（intervalは参照しない）
                    DropdownButtonFormField<SubscriptionPlan>(
                      decoration: const InputDecoration(labelText: 'プラン'),
                      value: selectedPlan,
                      items: plans
                          .map((plan) => DropdownMenuItem(
                                value: plan,
                                child: Text(plan.name),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPlan = value;
                          price = value?.price;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: '支払い方法'),
                      value: selectedPayment,
                      items: paymentMethods
                          .map((method) => DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('金額: '),
                        Text(price != null ? '$price 円' : '未選択'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: (selectedService != null &&
                          selectedInterval != null &&
                          selectedPlan != null &&
                          selectedPayment != null)
                      ? () {
                          setState(() {
                            _subscriptions[index] = {
                              'service': selectedService,
                              'plan': selectedPlan!.name,
                              'interval': selectedInterval,
                              'startDate': startDate,
                              'price': price,
                              'payment': selectedPayment,
                            };
                          });
                          _saveData(); // ここで必ず保存
                          Navigator.pop(context);
                        }
                      : null,
                  child: const Text('保存'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showFreeTrialNotificationDialog() {
    String? serviceName;
    DateTime? startDate;
    Set<String> selectedFrequencies = {}; // 複数選択用
    int? freeDays;
    DateTime? endDate;
    final List<String> frequencyOptions = ['毎日', '3日前', '1週間前', '2週間前', '1ヶ月前'];
    final TextEditingController serviceNameController = TextEditingController();
    final TextEditingController freeDaysController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // 終了日の自動計算
            if (startDate != null && freeDays != null && freeDays! > 0) {
              endDate = startDate!.add(Duration(days: freeDays ?? 0));
            } else {
              endDate = null;
            }

            return AlertDialog(
              title: const Text('無料期間通知設定'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: serviceNameController,
                      decoration: const InputDecoration(
                        labelText: 'サービス名（任意）',
                        hintText: '例: Netflix体験版',
                      ),
                      onChanged: (value) {
                        setState(() {
                          serviceName = value;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('開始日: '),
                        Text(
                          startDate != null
                              ? DateFormat('yyyy/MM/dd').format(startDate!)
                              : '未選択',
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                startDate = picked;
                              });
                            }
                          },
                        ),
                        if (startDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: '日付を未選択に戻す',
                            onPressed: () {
                              setState(() {
                                startDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: freeDaysController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '無料期間（日数）',
                        hintText: '例: 30',
                      ),
                      onChanged: (value) {
                        setState(() {
                          freeDays = int.tryParse(value);
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('終了日: '),
                        Text(
                          endDate != null
                              ? DateFormat('yyyy/MM/dd').format(endDate!)
                              : '未設定',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // 通知頻度を複数選択できるチェックボックスリスト
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('通知頻度（複数選択可）', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ...frequencyOptions.map((f) => CheckboxListTile(
                          title: Text(f),
                          value: selectedFrequencies.contains(f),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (checked) {
                            setState(() {
                              if (checked == true) {
                                selectedFrequencies.add(f);
                              } else {
                                selectedFrequencies.remove(f);
                              }
                            });
                          },
                        )),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: (startDate != null && endDate != null && selectedFrequencies.isNotEmpty)
                      ? () async {
                          List<DateTime> notifyDates = [];
                          for (final frequency in selectedFrequencies) {
                            DateTime? notifyDate;
                            switch (frequency) {
                              case '毎日':
                                notifyDate = endDate!.subtract(const Duration(days: 1));
                                break;
                              case '3日前':
                                notifyDate = endDate!.subtract(const Duration(days: 3));
                                break;
                              case '1週間前':
                                notifyDate = endDate!.subtract(const Duration(days: 7));
                                break;
                              case '2週間前':
                                notifyDate = endDate!.subtract(const Duration(days: 14));
                                break;
                              case '1ヶ月前':
                                notifyDate = endDate!.subtract(const Duration(days: 30));
                                break;
                            }
                            if (notifyDate != null && notifyDate.isAfter(DateTime.now())) {
                              await scheduleFreeTrialNotification(
                                title: 'サブスク課金日が近づいています',
                                body: '${serviceName ?? "サービス"}の次回課金日: ${endDate != null ? DateFormat('yyyy/MM/dd').format(endDate!) : "未設定"}',
                                scheduledDate: notifyDate,
                                serviceName: serviceName ?? "サービス",
                                planName: "無料体験", // 固定値または必要に応じて変更
                                repeatMonthly: true, // ← ここをtrueに
                              );
                              notifyDates.add(notifyDate);
                            }
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '通知設定を保存しました\n通知予定日: ${notifyDates.map((d) => DateFormat('yyyy/MM/dd').format(d)).join(", ")}',
                              ),
                            ),
                          );
                        }
                      : null,
                  child: const Text('保存'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _calculateDuration(DateTime? startDate) {
    if (startDate == null) return '不明';
    final now = DateTime.now();
    int years = now.year - startDate.year;
    int months = now.month - startDate.month;
    int days = now.day - startDate.day;
    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }
    String result = '';
    if (years > 0) result += '$years年';
    if (months > 0) result += '$monthsヶ月';
    if (days > 0) result += '$days日';
    if (result.isEmpty) result = '0日';
    return result;
  }

  void _showAddFanClubDialog() {
    final TextEditingController nameController = TextEditingController();
    DateTime? startDate;
    final TextEditingController priceController = TextEditingController();
    final TextEditingController memoController = TextEditingController();
    final TextEditingController urlController = TextEditingController(); // 追加

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('ファンクラブ追加'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'ファンクラブ名',
                        hintText: '例: ○○ファンクラブ',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('開始日: '),
                        Text(
                          startDate != null
                              ? "${startDate!.year}/${startDate!.month}/${startDate!.day}"
                              : '未選択',
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                startDate = picked;
                              });
                            }
                          },
                        ),
                        if (startDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: '日付を未選択に戻す',
                            onPressed: () {
                              setState(() {
                                startDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '料金（円）',
                        hintText: '例: 5000',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                        labelText: 'ファンクラブページURL（任意）',
                        hintText: 'https://example.com',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: memoController,
                      decoration: const InputDecoration(
                        labelText: 'メモ（任意）',
                        hintText: '例: 支払い方法や特記事項など',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: nameController.text.isNotEmpty &&
                          startDate != null &&
                          priceController.text.isNotEmpty
                      ? () {
                          _addFanClub({
                            'name': nameController.text,
                            'startDate': startDate,
                            'price': int.tryParse(priceController.text) ?? 0,
                            'memo': memoController.text,
                            'url': urlController.text, // 追加
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('ファンクラブを追加しました')),
                          );
                        }
                      : null,
                  child: const Text('追加'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ファンクラブ編集ダイアログを追加
  void _showEditFanClubDialog(int fcIndex) {
    final fc = _fanclubs[fcIndex];
    final TextEditingController nameController = TextEditingController(text: fc['name'] ?? '');
    DateTime? startDate;
    final startDateRaw = fc['startDate'];
    if (startDateRaw is DateTime) {
      startDate = startDateRaw;
    } else if (startDateRaw is String && startDateRaw.isNotEmpty) {
      startDate = DateTime.tryParse(startDateRaw);
    }
    final TextEditingController priceController = TextEditingController(text: (fc['price'] ?? '').toString());
    final TextEditingController memoController = TextEditingController(text: fc['memo'] ?? '');
    final TextEditingController urlController = TextEditingController(text: fc['url'] ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('ファンクラブ編集'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'ファンクラブ名',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Text('開始日: '),
                        Text(
                          startDate != null
                              ? "${startDate?.year}/${startDate?.month}/${startDate?.day}"
                              : '未選択',
                        ),
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: startDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() {
                                startDate = picked;
                              });
                            }
                          },
                        ),
                        if (startDate != null)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: '日付を未選択に戻す',
                            onPressed: () {
                              setState(() {
                                startDate = null;
                              });
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '料金（円）',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                        labelText: 'ファンクラブページURL（任意）',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: memoController,
                      decoration: const InputDecoration(
                        labelText: 'メモ（任意）',
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('キャンセル'),
                ),
                ElevatedButton(
                  onPressed: nameController.text.isNotEmpty &&
                          startDate != null &&
                          priceController.text.isNotEmpty
                      ? () {
                          setState(() {
                            _fanclubs[fcIndex] = {
                              'name': nameController.text,
                              'startDate': startDate,
                              'price': int.tryParse(priceController.text) ?? 0,
                              'memo': memoController.text,
                              'url': urlController.text,
                            };
                          });
                          _saveData();
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('ファンクラブを編集しました')),
                          );
                        }
                      : null,
                  child: const Text('保存'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int monthlyTotal = 0;
    int yearlyTotal = 0;

    for (final sub in _subscriptions) {
      if (sub['interval'] == '月毎') {
        monthlyTotal += (sub['price'] as num).toInt();
      } else if (sub['interval'] == '年毎') {
        yearlyTotal += (sub['price'] * 12 as num).toInt();
      }
    }
    // ファンクラブも月額合計に加算
    for (final fc in _fanclubs) {
      monthlyTotal += (fc['price'] as num).toInt();
    }
    int annualTotal = monthlyTotal * 12 + yearlyTotal;

    return Scaffold(
      appBar: AppBar(title: const Text('サブスク管理')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('メニュー')),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('サブスク追加'),
              onTap: () {
                Navigator.pop(context);
                _showAddDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.orange),
              title: const Text('ファンクラブ追加'),
              onTap: () {
                Navigator.pop(context);
                _showAddFanClubDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text('無料期間通知設定'),
              onTap: () {
                Navigator.pop(context);
                _showFreeTrialNotificationDialog();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('サブスク案内'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/guide');
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline),
              title: const Text('アプリの使い方'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/howto');
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('お問い合わせ'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/inquiry');
              },
            ),
            // ↓↓↓ 寄付ボタンを追加 ↓↓↓
            ListTile(
              leading: const Icon(Icons.volunteer_activism, color: Colors.pink),
              title: const Text('寄付する'),
              onTap: () async {
                // 寄付ページのURLを設定してください
                const url = 'https://ofuse.me/16914628';
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('寄付ページを開けませんでした')),
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // 合計表示（年間総額は一番右・一番左にグラフボタン）
          Card(
            margin: const EdgeInsets.all(8),
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isNarrow = constraints.maxWidth < 600;
                  return isNarrow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.bar_chart),
                              label: const Text('詳細グラフはこちら'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MonthlyPaymentBarChartPage(subscriptions: _subscriptions),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text('月毎合計', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('¥$monthlyTotal', style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('年毎合計', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('¥$yearlyTotal', style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('年間総額', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('¥$annualTotal', style: const TextStyle(fontSize: 22)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.bar_chart),
                              label: const Text('詳細グラフはこちら'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                textStyle: const TextStyle(fontSize: 14),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MonthlyPaymentBarChartPage(subscriptions: _subscriptions),
                                  ),
                                );
                              },
                            ),
                            Column(
                              children: [
                                const Text('月毎合計', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('¥$monthlyTotal', style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('年毎合計', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('¥$yearlyTotal', style: const TextStyle(fontSize: 18)),
                              ],
                            ),
                            Column(
                              children: [
                                const Text('年間総額', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('¥$annualTotal', style: const TextStyle(fontSize: 22)),
                              ],
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
          const Divider(height: 1),

          // ★ ここにサブスク追加・ファンクラブ追加ボタンを追加
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('サブスク追加'),
                  onPressed: _showAddDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.star, color: Colors.orange),
                  label: const Text('ファンクラブ追加'),
                  onPressed: _showAddFanClubDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // サブスク一覧
          Expanded(
            child: ListView(
              children: [
                // サブスク一覧をListView.builderでindexを渡す
                ...List.generate(_subscriptions.length, (index) {
                  final sub = _subscriptions[index];
                  final dynamic startDateRaw = sub['startDate'];
                  DateTime? startDate;
                  if (startDateRaw is DateTime) {
                    startDate = startDateRaw;
                  } else if (startDateRaw is String && startDateRaw.isNotEmpty) {
                    startDate = DateTime.tryParse(startDateRaw);
                  } else {
                    startDate = null;
                  }
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: ListTile(
                      title: Text('${sub['service']}（${sub['plan']}）'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('間隔: ${sub['interval']}'),
                          Text(
                            '開始日: ${startDate != null ? "${startDate.year}/${startDate.month}/${startDate.day}" : "未選択"}',
                          ),
                          Text('金額: ${sub['price']}円'),
                          Text('継続期間: ${_calculateDuration(startDate)}'),
                          Text('支払い方法: ${sub['payment'] ?? '未設定'}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ログインページボタン追加
                          IconButton(
                            icon: const Icon(Icons.login, color: Colors.green),
                            tooltip: 'ログインページへ',
                            onPressed: () async {
                              // サブスク名からログインURLを取得
                              final serviceName = sub['service'];
                              final service = subscriptionServices.firstWhere(
                                (s) => s.name == serviceName,
                                orElse: () => SubscriptionService(name: '', plans: [], intervals: []),
                              );
                              final loginUrl = (service.loginUrl != null && service.loginUrl!.isNotEmpty)
                                  ? service.loginUrl
                                  : null;
                              if (loginUrl != null) {
                                if (await canLaunchUrl(Uri.parse(loginUrl))) {
                                  await launchUrl(Uri.parse(loginUrl), mode: LaunchMode.externalApplication);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('ログインページを開けませんでした')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('ログインページURLが未設定です')),
                                );
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            tooltip: '編集',
                            onPressed: () {
                              _editSubscription(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: '削除',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('削除の確認'),
                                  content: const Text('このサブスクライブを削除しますか？'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('キャンセル'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _subscriptions.removeAt(index);
                                        });
                                        _saveData(); // ★ここを追加
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text('削除', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                // ファンクラブ一覧
                ...List.generate(_fanclubs.length, (fcIndex) {
                  final fc = _fanclubs[fcIndex];
                  final dynamic startDateRaw = fc['startDate'];
                  DateTime? startDate;
                  if (startDateRaw is DateTime) {
                    startDate = startDateRaw;
                  } else if (startDateRaw is String && startDateRaw.isNotEmpty) {
                    startDate = DateTime.tryParse(startDateRaw);
                  } else {
                    startDate = null;
                  }
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.orange[50],
                    child: ListTile(
                      title: Text('${fc['name']}（ファンクラブ）'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '開始日: ${startDate != null ? "${startDate.year}/${startDate.month}/${startDate.day}" : "未選択"}',
                          ),
                          Text('金額: ${fc['price']}円'),
                          if ((fc['memo'] ?? '').toString().isNotEmpty)
                            Text('メモ: ${fc['memo']}'),
                          Text('継続期間: ${_calculateDuration(startDate)}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ファンクラブページへ行くボタン
                          IconButton(
                            icon: const Icon(Icons.open_in_new, color: Colors.green),
                            tooltip: 'ファンクラブページへ',
                            onPressed: () async {
                              final url = fc['url'] ?? '';
                              if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('ファンクラブページURLが未設定か開けません')),
                                );
                              }
                            },
                          ),
                          // 編集ボタン
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            tooltip: '編集',
                            onPressed: () {
                              _showEditFanClubDialog(fcIndex);
                            },
                          ),
                          // 削除ボタン
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: '削除',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('削除の確認'),
                                  content: const Text('このファンクラブを削除しますか？'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('キャンセル'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _fanclubs.removeAt(fcIndex);
                                        });
                                        _saveData();
                                        Navigator.pop(ctx);
                                      },
                                      child: const Text('削除', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 棒グラフページ
class MonthlyPaymentBarChartPage extends StatelessWidget {
  final List<Map<String, dynamic>> subscriptions;
  const MonthlyPaymentBarChartPage({super.key, required this.subscriptions});

  @override
  Widget build(BuildContext context) {
    // 月毎のみ抽出し、支払い方法ごとに合計
    // Map<month, Map<payment, total>>
    Map<int, Map<String, int>> monthPaymentTotals = {};
    final now = DateTime.now();

    // 1月〜12月の初期化
    for (int m = 1; m <= 12; m++) {
      monthPaymentTotals[m] = {};
    }

    // 支払い方法一覧を全サブスクから抽出
    final paymentSet = <String>{};
    for (final sub in subscriptions) {
      if (sub['interval'] == '月毎') {
        final payment = sub['payment'] ?? '未設定';
        paymentSet.add(payment);
      }
    }
    final paymentMethodsList = paymentSet.toList();

    // 月ごと・支払い方法ごとに合計
    for (final sub in subscriptions) {
      if (sub['interval'] == '月毎') {
        final payment = sub['payment'] ?? '未設定';
        DateTime? startDate;
        final raw = sub['startDate'];
        if (raw is DateTime) {
          startDate = raw;
        } else if (raw is String && raw.isNotEmpty) {
          startDate = DateTime.tryParse(raw);
        }
        // 開始月の決定
        int startMonth;
        if (startDate != null) {
          startMonth = startDate.month;
        } else {
          // 未設定の場合は追加した月（今月）から
          startMonth = now.month;
        }
        // 今年のstartMonthから「今月」まで毎月加算
        for (int m = startMonth; m <= now.month; m++) {
          monthPaymentTotals[m]![payment] =
              (monthPaymentTotals[m]![payment] ?? 0) + (sub['price'] as num).toInt();
        }
      }
    }

    // 1月〜12月の順で表示
    final months = List.generate(12, (i) => i + 1);

    // 支払い方法ごとに色を割り当て
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.brown,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
    ];
    Map<String, Color> paymentColorMap = {};
    for (int i = 0; i < paymentMethodsList.length; i++) {
      paymentColorMap[paymentMethodsList[i]] = colors[i % colors.length];
    }

    // 棒グラフデータ作成（支払い方法ごとに横並びで重ならないようにする）
    List<BarChartGroupData> barGroups = [];
    double maxY = 250;
    for (int i = 0; i < months.length; i++) {
      final month = months[i];
      final paymentTotals = monthPaymentTotals[month] ?? {};
      double groupMax = 0;
      List<BarChartRodData> rods = [];
      for (int j = 0; j < paymentMethodsList.length; j++) {
        final payment = paymentMethodsList[j];
        final value = (paymentTotals[payment] ?? 0).toDouble();
        rods.add(
          BarChartRodData(
            toY: value,
            color: paymentColorMap[payment],
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        );
        if (value > groupMax) groupMax = value;
      }
      if (groupMax > maxY) maxY = groupMax;
      barGroups.add(
        BarChartGroupData(
          x: month,
          barRods: rods,
          barsSpace: 4,
          groupVertically: false, // 横並びで重ならないようにする
        ),
      );
    }
    if (maxY < 250) {
      maxY = 250;
    } else {
      maxY *= 1.2;
    }

    // 1グループあたりの幅（棒の本数×棒幅＋棒間スペース）
    const double barWidth = 16;
    const double barsSpace = 4;
    final int paymentCount = paymentMethodsList.length;
    final double groupWidth = paymentCount * barWidth + (paymentCount - 1) * barsSpace + 32; // 余白
    final double chartWidth = months.length * groupWidth;

    return Scaffold(
      appBar: AppBar(title: const Text('月毎の支払い方法別グラフ')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: chartWidth,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY,
                      minY: 0,
                      barTouchData: BarTouchData(enabled: true),
                      groupsSpace: 24,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final month = value.toInt();
                              if (month < 1 || month > 12) return const SizedBox();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('$month月', style: const TextStyle(fontSize: 12)),
                              );
                            },
                            reservedSize: 32,
                          ),
                        ),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: barGroups,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        drawHorizontalLine: true,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 凡例
            Wrap(
              spacing: 16,
              children: paymentMethodsList.map((payment) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 16, height: 16, color: paymentColorMap[payment]),
                    const SizedBox(width: 4),
                    Text(payment, style: const TextStyle(fontSize: 14)),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- サブスク案内ページ ---
class SubscriptionGuidePage extends StatefulWidget {
  const SubscriptionGuidePage({super.key});

  @override
  State<SubscriptionGuidePage> createState() => _SubscriptionGuidePageState();
}

// --- サブスク案内ページの検索ロジックをカテゴリ対応に修正 ---
class _SubscriptionGuidePageState extends State<SubscriptionGuidePage> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    // サービス名またはカテゴリ名でフィルタ（カテゴリは複数対応）
    final filteredServices = subscriptionServices.where((service) {
      if (_searchText.isEmpty) return true;
      final guide = subscriptionGuideInfos.firstWhere(
        (g) => g.name == service.name,
        orElse: () => SubscriptionGuideInfo(
          name: service.name,
          description: '',
          url: '',
          categories: [],
        ),
      );
      final searchLower = _searchText.toLowerCase();
      return service.name.toLowerCase().contains(searchLower) ||
          guide.categories.any((cat) => cat.toLowerCase().contains(searchLower));
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('サブスク案内')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'サービス名・カテゴリで検索',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredServices.length,
                itemBuilder: (context, index) {
                  final service = filteredServices[index];
                  final guide = subscriptionGuideInfos.firstWhere(
                    (g) => g.name == service.name,
                    orElse: () => SubscriptionGuideInfo(
                      name: service.name,
                      description: '特徴情報はありません。',
                      url: '',
                      categories: [],
                    ),
                  );

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (guide.logoAsset != null)
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: Image.asset(
                                    guide.logoAsset!,
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) => const SizedBox(width: 40, height: 40),
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  service.name,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'カテゴリ: ${guide.categories.join(", ")}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(guide.description),
                          const SizedBox(height: 8),
                          const Text('プラン一覧:', style: TextStyle(fontWeight: FontWeight.bold)),
                          ...service.plans.map((plan) => Padding(
                                padding: const EdgeInsets.only(left: 8, top: 2),
                                child: Text('・${plan.name}：¥${plan.price}（月毎）'),
                              )),
                          const SizedBox(height: 8),
                          if (guide.url.isNotEmpty)
                            ElevatedButton.icon(
                              icon: const Icon(Icons.open_in_new),
                              label: const Text('公式サイトへ'),
                              onPressed: () async {
                                if (await canLaunchUrl(Uri.parse(guide.url))) {
                                  await launchUrl(Uri.parse(guide.url), mode: LaunchMode.externalApplication);
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 使い方ページ ---
class HowToUsePage extends StatelessWidget {
  const HowToUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('アプリの使い方')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            Text(
              'サブスク管理アプリの使い方',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('■ サブスクの追加', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('・メニューから「サブスク追加」を選択し、サービス名・プラン・間隔・開始日・支払い方法を入力して「追加」ボタンを押してください。'),
            SizedBox(height: 12),
            Text('■ サブスクの編集・削除', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('・一覧の各サブスク右側の鉛筆アイコンで編集、ゴミ箱アイコンで削除できます。'),
            SizedBox(height: 12),
            Text('■ 合計金額の確認', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('・画面上部に月毎・年毎・年間総額が表示されます。'),
            SizedBox(height: 12),
            Text('■ グラフの確認', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('・「詳細グラフはこちら」ボタンから、月ごと・支払い方法ごとの支払い推移をグラフで確認できます。'),
            SizedBox(height: 12),
            Text('■ サブスク案内', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('・メニューの「サブスク案内」から各サービスの特徴や加入ページを確認できます。'),
            SizedBox(height: 12),
            Text('■ その他', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('・開始日を未設定のままでも追加できます。'),
            Text('・年毎プランがあるサービスは「間隔」で年毎を選択してください。'),
            Text('・年毎金額は現状、月毎金額の12倍で表示されます。年毎の特別な割引は考慮していません。'),
          ],
        ),
      ),
    );
  }
}

// --- 問い合わせページ ---
class InquiryPage extends StatelessWidget {
  const InquiryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('お問い合わせ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'お問い合わせ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('ご意見・ご要望・不具合報告などがありましたら、下記ボタンをタップ（クリック）してメールアプリからご連絡ください。'),
            SizedBox(height: 8),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.email),
        label: const Text('メールで問い合わせ'),
        onPressed: () async {
          final uri = Uri(
            scheme: 'mailto',
            path: 'synpul-yuto@synpul.net',
            query: 'subject=サブスク管理アプリへのお問い合わせ',
          );
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        },
      ),
    );
  }
}

// --- 通知スケジューリング関数をトップレベルに移動 ---
Future<void> scheduleFreeTrialNotification({
  required String title,
  required String body,
  required DateTime scheduledDate,
  required String serviceName,
  required String planName,
  bool repeatMonthly = false, // ← 追加
}) async {
  await flutterLocalNotificationsPlugin.zonedSchedule(
    generateSubscriptionNotificationId(serviceName, planName), // ← 一意なID
    title,
    body,
    tz.TZDateTime.from(scheduledDate, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'your_channel_id',
        'your_channel_name',
        channelDescription: 'your_channel_description',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: false,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: repeatMonthly
        ? DateTimeComponents.dayOfMonthAndTime // ← ここで毎月繰り返し
        : DateTimeComponents.dateAndTime,
  );
  return;
}

int generateSubscriptionNotificationId(String service, String plan) {
  return (service + plan).hashCode & 0x7FFFFFFF; // 正の値にする
}