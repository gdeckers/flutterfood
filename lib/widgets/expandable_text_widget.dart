import 'package:flutter/material.dart';
import 'package:flutterfood/utils/colors.dart';
import 'package:flutterfood/utils/dimensions.dart';
import 'package:flutterfood/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({ Key? key, required this.text }) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text.length>textHeight){
      firstHalf =  widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt()+1, widget.text.length);
    }else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty? SmallText(text: firstHalf,size: Dimensions.font16,color: AppColors.paraColor,): 
        Column(
          children: [
            SmallText(text: hiddenText?(firstHalf+'...'):(firstHalf+secondHalf),size: Dimensions.font16, color: AppColors.paraColor,height: 1.8,),
            InkWell(
              child: Row(
                children: [
                  hiddenText?SmallText(text: "Show more...", color: AppColors.mainColor,size: Dimensions.font16,) :
                    SmallText(text: "Show less...", color: AppColors.mainColor,size: Dimensions.font16,),
                  
                  hiddenText?Icon(Icons.arrow_drop_down, color: AppColors.mainColor,) :
                    Icon(Icons.arrow_drop_up, color: AppColors.mainColor,),
                ],
              ),
              onTap: (){
                setState(() {
                  hiddenText = !hiddenText;
                });
              },
            ),
          ],
        ),
    );
  }
}