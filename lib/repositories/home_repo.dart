import 'dart:math';

import 'package:flutter_sample/models/bank_list_model.dart';
import 'package:flutter_sample/models/emi_option_model.dart';

class HomeRepo{


  List<TenureOptionsModel> getListTenures(String selectedLoanAmount,double interst){
    double _prinicipalAmount=double.parse(selectedLoanAmount);
    interst=interst/(12*100);
    return [
      TenureOptionsModel((((_prinicipalAmount * interst * pow((1+interst), 12)) / ( pow((1+interst),12) -1))),"12","#63666A"),
      TenureOptionsModel(((_prinicipalAmount * interst * pow((1+interst), 9)) / ( pow((1+interst),9) -1)),"9","#A52A2A"),
      TenureOptionsModel(((_prinicipalAmount * interst * pow((1+interst), 6)) / ( pow((1+interst),6) -1)),"6","#6B8E23"),
      TenureOptionsModel(((_prinicipalAmount * interst * pow((1+interst), 3)) / ( pow((1+interst),3) -1)),"3","#48D1CC")
    ];
  }

  List<BankDetails> getBankDetails(){
    return [
      BankDetails("HDFC Bank","0987654321","https://w7.pngwing.com/pngs/636/81/png-transparent-hdfc-thumbnail-bank-logos.png"),
      BankDetails("HDFC Bank","098765432999","https://w7.pngwing.com/pngs/636/81/png-transparent-hdfc-thumbnail-bank-logos.png"),
      BankDetails("HDFC Bank","09876543299955","https://w7.pngwing.com/pngs/636/81/png-transparent-hdfc-thumbnail-bank-logos.png"),
      BankDetails("HDFC Bank","098765432999555556","https://w7.pngwing.com/pngs/636/81/png-transparent-hdfc-thumbnail-bank-logos.png"),
      BankDetails("HDFC Bank","098765432999555556333","https://w7.pngwing.com/pngs/636/81/png-transparent-hdfc-thumbnail-bank-logos.png"),
    ];
  }
}

HomeRepo homeRepo=HomeRepo();