import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_search_memorization_group_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/selected_part_of_quran_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_langugue_filtter.dart';

class ParticipantSearchMemorizationGroupController extends GetxController {
  var selectedGender = GenderSearchFiltter.notSelected.obs;

  var selectedGroupObjective = GroupObjectiveSearchFiltter.all.obs;

  var selectedSupervisorLanguage = SupervisorLangugueFilter.all.obs;

  var selectedGroupContent = GroupContentFilter.allOfQuran.obs;

  TextEditingController searchController = TextEditingController();

  final RxList<String> surahList = <String>[
    'الفاتحة',
    'البقرة',
    'آل عمران',
    'النساء',
    'المائدة',
    'الأنعام',
    'الأعراف',
    'الأنفال',
    'التوبة',
    'يونس',
    'هود',
    'يوسف',
    'الرعد',
    'إبراهيم',
    'الحجر',
    'النحل',
    'الإسراء',
    'الكهف',
    'مريم',
    'طه',
    'الأنبياء',
    'الحج',
    'المؤمنون',
    'النور',
    'الفرقان',
    'الشعراء',
    'النمل',
    'القصص',
    'العنكبوت',
    'الروم',
    'لقمان',
    'السجدة',
    'الأحزاب',
    'سبأ',
    'فاطر',
    'يس',
    'الصافات',
    'ص',
    'الزمر',
    'غافر',
    'فصلت',
    'الشورى',
    'الزخرف',
    'الدخان',
    'الجاثية',
    'الأحقاف',
    'محمد',
    'الفتح',
    'الحجرات',
    'ق',
    'الذاريات',
    'الطور',
    'النجم',
    'القمر',
    'الرحمن',
    'الواقعة',
    'الحديد',
    'المجادلة',
    'الحشر',
    'الممتحنة',
    'الصف',
    'الجمعة',
    'المنافقون',
    'التغابن',
    'الطلاق',
    'التحريم',
    'الملك',
    'القلم',
    'الحاقة',
    'المعارج',
    'نوح',
    'الجن',
    'المزمل',
    'المدثر',
    'القيامة',
    'الإنسان',
    'المرسلات',
    'النبأ',
    'النازعات',
    'عبس',
    'التكوير',
    'الإنفطار',
    'المطففين',
    'الإنشقاق',
    'البروج',
    'الطارق',
    'الأعلى',
    'الغاشية',
    'الفجر',
    'البلد',
    'الشمس',
    'الليل',
    'الضحى',
    'الشرح',
    'التين',
    'العلق',
    'القدر',
    'البينة',
    'الزلزلة',
    'العاديات',
    'القارعة',
    'التكاثر',
    'العصر',
    'الهمزة',
    'الفيل',
    'قريش',
    'الماعون',
    'الكوثر',
    'الكافرون',
    'النصر',
    'المسد',
    'الإخلاص',
    'الفلق',
    'الناس'
  ].obs;

  var selectedSurahs = [].obs;

  final RxList juzzaList = [].obs;

  var selectedJuzzas = [].obs;

  var selectedPartOfQuranType = SelectedPartOfQuranFiltter.notSelected.obs;

  var selectedStudentLevelRange = const RangeValues(0, 3).obs;

  final ParticipantSearchMemorizationGroupService
      _participantSearchMemorizationGroupService;
  ParticipantSearchMemorizationGroupController(
      this._participantSearchMemorizationGroupService);

  var selectedStudentLevel = 0.obs;
}
