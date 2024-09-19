import 'package:flutter/cupertino.dart';
import 'widgets/category_text.dart';
import 'widgets/banner_widget.dart';
import 'widgets/search_input_widget.dart';
import 'widgets/welcome_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeText(),
          SizedBox(
            height: 14,
          ),
          SearchInputWidget(),
          BannerWidget(),
          CategoryText()
        ],
      ),
    );
  }
}
