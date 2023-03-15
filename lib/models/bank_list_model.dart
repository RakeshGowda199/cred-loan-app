class BankListModel {
  bool _isopen = true;
  String _amountSelected = "";
  double _interstRate = 1.43;
  List<BankDetails> _listBank=[];



  BankDetails? selectedBankDetails;

  BankListModel(this._isopen, this._amountSelected, this._interstRate,this._listBank,{this.selectedBankDetails});

  get isOpen => _isopen;

  get AmountSelected => _amountSelected;

  get InterstRate => _interstRate;
  List<BankDetails> get listBank => _listBank;


  set setIsOpen(bool isOpen) {
    _isopen = isOpen;
  }

  set setAmountSelected(String amount) {
    _amountSelected = amount;
  }

  set setInterstRate(double interstRate) {
    _interstRate = interstRate;
  }

  set listBank(List<BankDetails> value) {
    _listBank = value;
  }

}

class BankDetails {
  String _bankName = "";
  String _accountNumber = '';
  String _logo = '';

  BankDetails(this._bankName, this._accountNumber, this._logo);


  get BankName => _bankName;

  get AccountNumber => _accountNumber;

  get BankImageUrl => _logo;

  set bankName(String updatedBankName) {
    _bankName = updatedBankName;
  }

  set accountNumber(String updatedAccountNumber) {
    _accountNumber = updatedAccountNumber;
  }

  set logo(String updatedLogo) {
    _logo = updatedLogo;
  }

}
