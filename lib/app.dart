import 'package:flutter/material.dart';
import 'package:flutter_sample/controllers/home_controller.dart';
import 'package:flutter_sample/models/amount_details.dart';
import 'package:flutter_sample/models/bank_list_model.dart';
import 'package:flutter_sample/models/emi_option_model.dart';
import 'package:flutter_sample/ui/bank_list_screen.dart';
import 'package:flutter_sample/ui/credit_amount_screen.dart';
import 'package:flutter_sample/ui/emi_option_screen.dart';
import 'package:get/get.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CRED Sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    homeController.getListData.add(AmountDetailsModel(true, "", 1.43,"500000"));
    homeController.update();
  }

  //on back press
  Future<bool> _onBackPressed() async {
    if (homeController.index != 0) {
      homeController.index--;
      homeController.switchScreens();
    }
    return false;
  }

  //get the collpsed Loan Amount card
  Widget _getLoanAmountCard() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade900.withOpacity(0.4),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: const Text(
          'credit amount',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
        subtitle: Text(
          "₹" +
              (homeController.getListData[0] as AmountDetailsModel)
                  .AmountSelected,
          style: const TextStyle(
              color: Colors.white38, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white70,
        ),
        onTap: () {
          homeController.switchScreens(switchIndex: 0);
        },
      ),
    );
  }

  //get the collpsed emi selection card
  Widget _getSelectedEmiCard() {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        onTap: () {
          homeController.switchScreens(switchIndex: 1);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getColumnWidget("EMI",
                "₹${(homeController.getListData[1] as EmiDetailsModel).SelectedTenure!.monthlyEmi.toStringAsFixed(2)} /mo"),
            _getColumnWidget("duration",
                "${(homeController.getListData[1] as EmiDetailsModel).SelectedTenure!.tenure} months"),
            const Expanded(
                flex: 1,
                child: Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white38,
                    )))
          ],
        ),
      ),
    );
  }

  //get the custom column
  Widget _getColumnWidget(String title, String value) {
    return Expanded(
      flex: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white54, fontSize: 16),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black26,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.help,
                  color: Colors.white,
                )),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<HomeController>(
                init: HomeController(),
                builder: (controller) {
              return Column(
                children: [
                  (controller.getListData[0] as AmountDetailsModel).isOpen
                      ? const CreditAmountScreen()
                      : _getLoanAmountCard(),
                  const SizedBox(
                    height: 2,
                  ),
                  if (controller.index >= 1)
                    (controller.getListData[1] as EmiDetailsModel).isOpen
                        ? EMIOptionScreen()
                        : _getSelectedEmiCard(),
                  const SizedBox(
                    height: 2,
                  ),
                  if (controller.index >= 2)
                    (controller.getListData[2] as BankListModel).isOpen
                        ? const BankListScreen()
                        : _getSelectedEmiCard(),
                ],
              );
            }),
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
          onTap: () {
            if (homeController.index <= homeController.maxIndex) {
              homeController.index++;
              homeController.switchScreens();
            }
          },
          child: Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blueAccent.shade700,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24))),
            child: Center(child: GetBuilder<HomeController>(builder: (context) {
              return Text(
                (homeController.index == 0)
                    ? "Proceed to EMI selection "
                    : (homeController.index == 1)
                        ? "Select your bank account"
                        : "Tap for a 1-click kyc",
                style: const TextStyle(color: Colors.white),
              );
            })),
          )),
    );
  }
}
