import 'package:flutter_sample/models/amount_details.dart';
import 'package:flutter_sample/models/bank_list_model.dart';
import 'package:flutter_sample/models/emi_option_model.dart';
import 'package:flutter_sample/repositories/home_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  int index=0;
  int maxIndex=2;

  List<dynamic> getListData=[].obs;


  void switchScreens({int? switchIndex}){

    if(switchIndex != null){
      index= switchIndex;
    }
    switch(index){
      case 0:{
        (getListData[index] as AmountDetailsModel).setIsOpen=!(getListData[0] as AmountDetailsModel).isOpen;
        if(getListData.length >1){

          // (getListData[index] as EmiDetailsModel).setIsOpen(false);
        }
      }break;
      case 1:{
        (getListData[0] as AmountDetailsModel).setIsOpen=false;
        if(getListData.length >1){
          (getListData[index] as EmiDetailsModel).setIsOpen=true;
          (getListData[index] as EmiDetailsModel).setTenure=homeRepo.getListTenures((getListData[0]).AmountSelected,(getListData[0]).InterstRate);
          (getListData[index] as EmiDetailsModel).selectedTenure=(getListData[index] as EmiDetailsModel).SelectedTenure;
          update();
        }else{
          List _tenureList=homeRepo.getListTenures((getListData[0]).AmountSelected,(getListData[0]).InterstRate);
          getListData.insert(1, EmiDetailsModel(true,"",1.0,homeRepo.getListTenures((getListData[0]).AmountSelected,(getListData[0]).InterstRate),selectedTenure: _tenureList[1]));
          update();
        }
        // (homeController.getListData[1] as EmiDetailsModel).setIsOpen(false);

      }break;
      case 2:{
        (getListData[0] as AmountDetailsModel).setIsOpen=false;
        (getListData[1] as EmiDetailsModel).setIsOpen=false;
        if(getListData.length >= 3){
          (getListData[2] as BankListModel).setIsOpen=true;
          (getListData[2] as BankListModel).selectedBankDetails=(getListData[2] as BankListModel).selectedBankDetails ?? homeRepo.getBankDetails()[0] ;

           }else{
          getListData.insert(2, BankListModel(true,"",1.0,homeRepo.getBankDetails(),selectedBankDetails: homeRepo.getBankDetails()[0]));
        }
      }break;
    }

    update();
  }

}

