import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'bottom_nav.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<String> nonEditableFields = ['name', 'id', 'cclass'];

  Map<String, String> infoMap = {
    "name": "মোঃ কামাল হোসেন",
    "id": "STU-2023-101",
    "cclass": "দশম",
    "phone": "01XXXXXXXXX",
    "email": "kamal.hossain@example.com",
    "gender": "পুরুষ",
    "birth_cert": "2005-01-15",
    "blood_group": "O+",
    "current_address": "গ্রাম: উত্তর পাড়া,\nডাকঘর: ---,\nউপজেলা: ---,\nজেলা: ---",
    "permanent_address": "গ্রাম: দক্ষিণ পাড়া,\nডাকঘর: ---,\nউপজেলা: ---,\nজেলা: ---",
    "father_name": "আলী হোসেন",
    "father_phone": "01YYYYYYYYY",
    "mother_name": "ফাতেমা বেগম",
    "mother_phone": "01ZZZZZZZZZ",
  };

  Map<String, bool> isEditing = {};
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    for (var key in infoMap.keys) {
      isEditing[key] = false;
      controllers[key] = TextEditingController(text: infoMap[key]);
    }
  }

  String getLabel(String key, AppLocalizations loc) {
    switch (key) {
      case 'name': return loc.home;
      case 'id': return loc.id;
      case 'cclass': return loc.cclass;
      case 'phone': return loc.phone;
      case 'email': return loc.email;
      case 'gender': return loc.gender;
      case 'birth_cert': return loc.birthCert;
      case 'blood_group': return loc.bloodGroup;
      case 'current_address': return loc.currentAddress;
      case 'permanent_address': return loc.permanentAddress;
      case 'father_name': return loc.fatherName;
      case 'father_phone': return loc.fatherPhone;
      case 'mother_name': return loc.motherName;
      case 'mother_phone': return loc.motherPhone;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final screenW = MediaQuery.of(context).size.width;
    final avatarSize = screenW * 0.35;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.profile, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // প্রোফাইল ছবি
            Container(
              width: avatarSize,
              height: avatarSize,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal.shade400,
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(Icons.person, size: avatarSize * 0.6, color: Colors.white),
              ),
            ),
            // নাম
            Text(
              infoMap["name"]!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // তথ্য তালিকা
            ...infoMap.entries.where((entry) => entry.key != 'name').map((entry) {
              final key = entry.key;
              final value = entry.value;
              final editing = isEditing[key] ?? false;
              final editable = !nonEditableFields.contains(key);
              final label = getLabel(key, loc);

              return GestureDetector(
                onTap: () {
                  if (!editable || editing) return;
                  setState(() {
                    isEditing[key] = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: editing
                            ? TextField(
                          controller: controllers[key],
                          maxLines: null,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: label,
                            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                            border: InputBorder.none,
                          ),
                        )
                            : RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                            children: [
                              TextSpan(
                                text: '$label: ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: value),
                            ],
                          ),
                        ),
                      ),
                      if (editable && editing)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check_circle, color: Colors.green),
                              onPressed: () {
                                setState(() {
                                  infoMap[key] = controllers[key]!.text;
                                  isEditing[key] = false;
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.cancel, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  controllers[key]!.text = infoMap[key]!;
                                  isEditing[key] = false;
                                });
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}
