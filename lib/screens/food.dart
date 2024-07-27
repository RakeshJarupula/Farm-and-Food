import 'package:farm_and_food/constants/promts.dart';
import 'package:farm_and_food/utils/basePage.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FoodPage extends BasePage {
  const FoodPage({super.key});

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends BasePageState<FoodPage> {
  @override
  String get title => 'Analyze Food 😋';

  @override
  TextPart get prompt => FOOD_PROMPT;

  @override
  String get task => 'Select A Food Image To Explore It.';

  @override
  String get backgroundAsset => 'assets/Backgrounds/food_home_bk.json';
  
  @override
  String get loaderAsset => 'assets/Backgrounds/food_loader.json';

}




