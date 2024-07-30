import 'package:farm_and_food/constants/promts.dart';
import 'package:farm_and_food/utils/base_page.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FarmPage extends BasePage {
  const FarmPage({super.key});

  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends BasePageState<FarmPage> {
  @override
  String get title => 'Analyze Farm 🪴';

  @override
  TextPart get prompt => FARM_PROMPT;

  @override
  String get task => 'Select A Crop/Plant Image To Explore It.';

  @override
  String get backgroundAsset => 'assets/Backgrounds/farm_home_bk.json';
  
  @override
  String get loaderAsset => 'assets/Backgrounds/farm_loader.json';

}