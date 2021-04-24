import 'package:devquiz/core/app_gradients.dart';
import 'package:devquiz/core/app_text_styles.dart';
import 'package:devquiz/home/widgets/score_card/score_card_widget.dart';
import 'package:devquiz/shared/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class AppBarWidget extends PreferredSize {
  final UserModel userModel;
  AppBarWidget({required this.userModel})
      : super(
    preferredSize: Size.fromHeight(250),
    child: Container(
      height: 250,
      child: Stack(
        children: [
          Container(
            height: 161,
            decoration: BoxDecoration(
              gradient: AppGradients.linear,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                    text: "Olá, ",
                    style: AppTextStyles.title,
                    children: [
                      TextSpan(
                        text: userModel.userName,
                        style: AppTextStyles.titleBold,
                      )
                    ])),
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              userModel.photoUrl))),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment(0.0,1.0),
              child: ScoreCardWidget(percent: (userModel.score / 100),)),
        ],
      ),
    ),
  );
}
