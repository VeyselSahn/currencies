import 'package:flutter/material.dart';
import 'package:nekadarparamvar/core/provider/data.dart';
import 'package:nekadarparamvar/core/service/api.dart';
import 'package:nekadarparamvar/screen/currenies/currenies.dart';
import 'package:nekadarparamvar/screen/main/components/appbar.dart';
import 'package:nekadarparamvar/screen/main/components/drawer.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  final bool dataFetched;
  const MainScreen({Key? key, required this.dataFetched}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    !widget.dataFetched ? getData() : null;
  }

  Future<void> getData() async {
    var dataprovider = Provider.of<DataProvider>(context, listen: false);

    await Api().getData().then((value) => dataprovider.fillLists(value));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(), appBar: normal(context), body: Currenies());
  }
}
