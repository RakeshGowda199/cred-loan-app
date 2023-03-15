class EmiDetailsModel{
  bool _isopen=true;
  String _amountSelected="";
  double _interstRate=1.43;
  List<TenureOptionsModel> _listTenureDetials=[];
  TenureOptionsModel? selectedTenure;

  EmiDetailsModel(this._isopen, this._amountSelected, this._interstRate,this._listTenureDetials,{this.selectedTenure});

  get isOpen=>_isopen;
  get AmountSelected => _amountSelected;
  get InterstRate => _interstRate;
  get SelectedTenure=>selectedTenure;

   List<TenureOptionsModel> TenureList(){
     return _listTenureDetials;
   }

  set setIsOpen(bool isOpen){
    _isopen=isOpen;
  }
  set setAmountSelected(String amount){
    _amountSelected=amount;
  }
  set setInterstRate(double interstRate){
    _interstRate=interstRate;
  }
  set setTenure(List<TenureOptionsModel> tenure){
    _listTenureDetials=tenure;
  }
  set SelectTenure(TenureOptionsModel tenure){
    selectedTenure=tenure;
  }
}

class TenureOptionsModel{
  double _monthlyEmi=0.00;
  String _tenure="";
  String _color='';

  TenureOptionsModel(this._monthlyEmi, this._tenure,this._color);

  get monthlyEmi=>_monthlyEmi;
  get tenure=>_tenure;
  get color=>_color;

  set setMonthlyEmi(double emiMonthly){
    _monthlyEmi=emiMonthly;
  }
  set setTenure(String newTenure){
    _tenure=newTenure;
  }
}