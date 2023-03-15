import 'package:flutter/material.dart';
import 'package:flutter_sample/controllers/home_controller.dart';
import 'package:flutter_sample/models/emi_option_model.dart';
import 'package:get/get.dart';

class EMIOptionScreen extends StatefulWidget  {
   EMIOptionScreen({Key? key}) : super(key: key);

  @override
  State<EMIOptionScreen> createState() => _EMIOptionScreenState();
}

class _EMIOptionScreenState extends State<EMIOptionScreen> with SingleTickerProviderStateMixin {


  late AnimationController _controller;
  late Animation<Offset> _offset;
   bool _isopen = true;
   HomeController _homeController=Get.find();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _controller.forward();
    });
    _offset = Tween<Offset>( begin:const Offset(0.0, 1.0) ,
      end: const Offset(0.0, 0.0),).animate(_controller);
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height-210,
      child: Stack(
        children: [
          Align(
            child: SlideTransition(
              position: _offset,
              child: (_isopen)
                  ? Container(
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1),borderRadius: const BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32))),
                    child: Column(
                      children: [
                        const ListTile(
                          title: Text(
                            'how do you wish to repay?',
                            style: TextStyle(color: Colors.white54,fontWeight: FontWeight.w500),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'choose one of our recommended plans or make your\nown',style: TextStyle(color: Colors.white38),),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                        constraints: BoxConstraints(
                            maxHeight: 220.0,
                            minWidth: MediaQuery.of(context).size.width,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GetBuilder<HomeController>(
                                init: HomeController(),
                                builder: (context) {
                                  return ListView.separated(
                                      itemCount: (_homeController.getListData[1] as EmiDetailsModel).TenureList().length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context,index){
                                        return const SizedBox(width: 12,);
                                      },
                                      itemBuilder: (contxt, index) {
                                    return _rowWidget(index);
                                  });
                                }
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Container(height: 32,width: 150,decoration: BoxDecoration(border: Border.all(color: Colors.white60),borderRadius: const BorderRadius.all(Radius.circular(20))),child: const Center(child: Text('create your own plan',style: TextStyle(color: Colors.white70,fontSize: 12),)),)
                          ],
                        )),
                      ],
                    ),
                  )
                  : const SizedBox(),
            ),
          )
        ],
      ),
    );
  }


  Widget _rowWidget(int index){
    TenureOptionsModel tenureDetails= (_homeController.getListData[1] as EmiDetailsModel).TenureList()[index];
    TenureOptionsModel selectedTenure= (_homeController.getListData[1] as EmiDetailsModel).SelectedTenure;
    return GestureDetector(
      onTap: (){
        (_homeController.getListData[1] as EmiDetailsModel).SelectTenure=tenureDetails;
        _homeController.update();
      },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width/2.5,
            margin: const EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              color: hexToColor(tenureDetails.color).withOpacity(0.5),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                    child: Container(margin: const EdgeInsets.only(left: 12),height: 24,width: 24,decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white)),
                    child: (tenureDetails.tenure == selectedTenure.tenure)?const Icon(Icons.check_circle,color: Colors.white,size: 22,):const SizedBox(),
                    )),
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  Container(margin: const EdgeInsets.only(left: 8),child: Row(
                    children: [
                      Text(tenureDetails.monthlyEmi.toStringAsFixed(2),style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                      const Text(' /mo',style: TextStyle(fontSize: 12,color: Colors.white38,fontWeight: FontWeight.bold),),
                    ],
                  )),
                  const SizedBox(height: 4,),
                  Container(margin: const EdgeInsets.only(left: 8),child: Text('for ${tenureDetails.tenure} months',style: const TextStyle(fontSize: 12,color: Colors.white54),)),
                        const SizedBox(height: 20,),
                        Container(margin: const EdgeInsets.only(left: 8),child: const Text('See calculation',style: TextStyle(fontSize: 12,color: Colors.white54,fontWeight: FontWeight.bold),)),

                      ],)),
              ],
            ),
          ),
          (index == 1)? Positioned(top: 0.1,left: 1,right: 1,child: Container(margin: const EdgeInsets.symmetric(horizontal: 32.0),height: 16,child: const Center(child: Text('recommaned',style: TextStyle(fontSize: 8),)),decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.0),color: Colors.white,boxShadow: const [
            BoxShadow(color: Colors.black),
            BoxShadow(color: Colors.black),
            BoxShadow(color: Colors.black),
          ]),),):const SizedBox(),

        ],
      ),
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
