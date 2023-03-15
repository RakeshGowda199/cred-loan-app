class AmountDetailsModel{
  bool _isopen=true;
  String _amountSelected="";
  String _maxLoanAmount="";
  double _interstRate=1.43;


  AmountDetailsModel(this._isopen, this._amountSelected, this._interstRate,this._maxLoanAmount);

  get isOpen=>_isopen;
  get AmountSelected=>(_amountSelected.isEmpty)?"10000":_amountSelected;
  get InterstRate=>_interstRate;
  get MaxLoanAmount=>_maxLoanAmount;


  set setIsOpen(bool isOpen){
    _isopen=isOpen;
  }
  set setAmountSelected(String amount){
    _amountSelected=amount;
  }
  set setInterstRate(double interstRate){
    _interstRate=interstRate;
  }
  set setMaxLoanAmount(String maxReleaseAmount){
    _maxLoanAmount=maxReleaseAmount;
  }
}