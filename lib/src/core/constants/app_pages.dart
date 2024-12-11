import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/athkar_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/authentication_pages/authentication_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/entry_screens_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/family_links_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/home_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages/supervisor_pages/supervisor_pages.dart';

class AppPages {
  static final pages = [
    ...HomePages.pages,
    ...AthkarPages.pages,
    ...EntryScreensPages.pages,
    ...FamilyLinksPages.pages,
    ...AuthenticationPages.pages, // contain register pages also
    ...SupervisorPages.pages,
  ];
}
