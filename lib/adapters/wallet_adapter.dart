import 'package:flutter/material.dart';
import 'package:expense_management/models/wallet.dart';
import 'package:expense_management/utils/db_helper.dart';
import 'package:expense_management/utils/hex_color.dart';
import 'package:expense_management/utils/methods.dart';
import 'package:expense_management/views/secret_phrase.dart';
import 'package:expense_management/views/view_secret_phrase.dart';

class WalletAdapter extends StatefulWidget {
  int num;
  Wallet wallet;
  Function callback;
  WalletAdapter({this.num, this.wallet, this.callback});

  @override
  State<WalletAdapter> createState() => _WalletAdapterState();
}

class _WalletAdapterState extends State<WalletAdapter> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            useSafeArea: false,
            context: context,
            builder: (ctx) => AlertDialog(
                backgroundColor: Colors.transparent,
                contentPadding: const EdgeInsets.all(0),
                content: OptionsDialog(wallet: widget.wallet, callback: widget.callback,)));
      },
      child: Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: HexColor("#1B1B1B"),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
              width: 15,
            ),
            Image.asset(
              "assets/images/wallet.png",
              width: 24,
              height: 24,
            ),
            Container(
              width: 10,
            ),
            Text(
              "Wallet ${widget.num}",
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'inter-regular',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              width: 180,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Colors.transparent,
                    contentPadding: const EdgeInsets.all(0),
                    content: OptionsDialog(wallet: widget.wallet, callback: widget.callback,)));
              },
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OptionsDialog extends StatefulWidget {

  Wallet wallet;
  Function callback;

  OptionsDialog({this.callback, this.wallet});

  @override
  State<OptionsDialog> createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSecretPhrase(wallet: widget.wallet,)));
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 88,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: HexColor("#1B1B1B"),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 15,
                  ),
                  Image.asset("assets/images/eye.png"),
                  Container(
                    width: 10,
                  ),
                  const Text(
                    "Secret phrase",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'inter-regular',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 5,
          ),
          InkWell(
            onTap: () async {
              showToast("Deleting");
              DbHelper db = DbHelper();
              await db.deleteWallet(widget.wallet);
              Navigator.pop(context);
              await widget.callback();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 88,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: HexColor("#1B1B1B"),
                borderRadius: const BorderRadius.all(Radius.circular(3)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 15,
                  ),
                  Image.asset("assets/images/unlink.png"),
                  Container(
                    width: 10,
                  ),
                  const Text(
                    "Disconnect wallet",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'inter-regular',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
