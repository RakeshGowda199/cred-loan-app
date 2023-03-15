import 'package:flutter/material.dart';
import 'package:flutter_sample/controllers/home_controller.dart';
import 'package:flutter_sample/models/bank_list_model.dart';
import 'package:get/get.dart';

class BankListScreen extends StatefulWidget {
  const BankListScreen({Key? key}) : super(key: key);

  @override
  _BankListScreenState createState() => _BankListScreenState();
}

class _BankListScreenState extends State<BankListScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _offset;

   bool _isopen = true;


  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      _controller.forward();
    });


    _offset = Tween<Offset>( begin:const Offset(0.0, 1.0) ,
      end: const Offset(0.0, 0.0),).animate(_controller);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.shade900.withOpacity(0.6),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      child: Align(
        child: SlideTransition(
          position: _offset,
          child: (_isopen)
              ? Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const ListTile(
                    title: Text(
                      'where should we send the money?',
                      style: TextStyle(color: Colors.white60,fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'amount will be credited to this bank account, EMI will also be debited from this bank account',style: TextStyle(color: Colors.white38),),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: (controller) {
                          BankListModel _bankDetails=(controller.getListData[2] as BankListModel);
                          return ListView.builder(
                              itemCount: _bankDetails.listBank.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (contxt, index) {
                                return GestureDetector(onTap: (){
                                  (controller.getListData[2]).selectedBankDetails=_bankDetails.listBank[index];
                                  controller.update();
                                },child: _rowWidget(_bankDetails.listBank[index],_bankDetails.selectedBankDetails!));
                              });
                        }
                      ),
                      const SizedBox(height: 20,),
                      Container(height: 32,width: 150,decoration: BoxDecoration(border: Border.all(color: Colors.white38),borderRadius: const BorderRadius.all(Radius.circular(20))),child: const Center(child: Text('Change account',style: TextStyle(color: Colors.white54),)),)
                    ],
                  )),
                ],
              )
              : const ListTile(
            title: Text(
              'Rakesh, how much do you need? ',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
                'move the deal and set any amount you need upto RS \n500000'),
          ),
        ),
      ),
    );
  }


  Widget _rowWidget(BankDetails _bankDetails,BankDetails _selectedBankDetails){
    return ListTile(
      minLeadingWidth: 40,
      leading:  Container(
        height: 42,
        width: 40,
        decoration:BoxDecoration(color: Colors.white,shape: BoxShape.rectangle,borderRadius: BorderRadius.circular(12)),child:  Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.network(_bankDetails.BankImageUrl),
      ),),
      title:  Text(_bankDetails.BankName,style: const TextStyle(color: Colors.white60,fontWeight: FontWeight.bold)),
      subtitle:  Text(_bankDetails.AccountNumber,style: const TextStyle(color: Colors.white30)),
      trailing: (_bankDetails.AccountNumber == _selectedBankDetails.AccountNumber)? Container(margin: const EdgeInsets.only(left: 12),decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.white24),child: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Icon(Icons.check,color: Colors.white54,size: 20,),
      )):const SizedBox(),
    );
  }
}
