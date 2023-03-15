import 'package:flutter/material.dart';
import 'package:flutter_sample/controllers/home_controller.dart';
import 'package:flutter_sample/models/amount_details.dart';
import 'package:flutter_sample/widgets/circular_slider_widget.dart';
import 'package:get/get.dart';

class CreditAmountScreen extends StatefulWidget {
  const CreditAmountScreen({Key? key}) : super(key: key);

  @override
  _CreditAmountScreenState createState() => _CreditAmountScreenState();
}

class _CreditAmountScreenState extends State<CreditAmountScreen>
    with SingleTickerProviderStateMixin {
  int _end = 100;
   int _init = 40;


  late AnimationController _controller;
  late Animation<Offset> _offset;
  bool _isopen = true;

  HomeController _homeController=Get.find();


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _controller.forward();
    });
    _offset = Tween<Offset>(begin: const Offset(0.0,1.0), end: Offset.zero).animate(_controller);
  }

  //get custom seekbar
  Widget _getCustomSeekBar(){
    return  Expanded(
        flex: 3,
        child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            return CircularSliderPaint(
              intervals: int.parse(( controller.getListData[0] as AmountDetailsModel).MaxLoanAmount),
              init: _init,
              end:  int.parse(( controller.getListData[0] as AmountDetailsModel).AmountSelected),
              baseColor: Colors.orange.shade100,
              selectionColor: Colors.deepOrange,
              onSelectionChange: (newInit, newEnd) {
                _end = newEnd;
                ( controller.getListData[0] as AmountDetailsModel).setAmountSelected=_end.toString();
                controller.update();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('credit amount'),
                  const SizedBox(height: 4,),
                  Text('₹${( controller.getListData[0] as AmountDetailsModel).AmountSelected}'),
                  const SizedBox(height: 4,),
                  const Text('1.04% monthly'),

                ],
              ),
            );
          }
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height-200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ListTile(
            title: const Text(
              'Rakesh, how much do you need? ',
              style: TextStyle(color: Colors.white70),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('move the deal and set any amount you need upto\n₹${( _homeController.getListData[0] as AmountDetailsModel).MaxLoanAmount}', style: const TextStyle(color: Colors.white30),),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Stack(
              children: [
                Align(
                  child: SlideTransition(
                    position: _offset,
                    child: (_isopen)
                        ? Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.white),
                            child: Column(
                              children:[
                                _getCustomSeekBar(),
                                const Expanded(
                                    flex: 1,
                                    child: Text(
                                      'stash is instant. money will be credited within\nseconds.',
                                      textAlign: TextAlign.center,
                                    ))
                              ],
                            ))
                        : const SizedBox(),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
