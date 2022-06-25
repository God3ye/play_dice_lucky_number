import 'package:flutter/material.dart';
import '/services/api_service.dart';

class DogCeoHome extends StatefulWidget {
  const DogCeoHome({Key? key}) : super(key: key);

  @override
  State<DogCeoHome> createState() => _DogCeoHomeState();
}

class _DogCeoHomeState extends State<DogCeoHome> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _textFieldF = FocusNode();
  final List<String> _suggestionData = [];

  void insertData(String data) {
    _controller.text = data;
    _suggestionData.clear();
    _textFieldF.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            focusNode: _textFieldF,
            controller: _controller,
            onEditingComplete: () {
              _suggestionData.clear();
              _textFieldF.unfocus();
              setState(() {});
            },
            onChanged: (searchData) {
              _suggestionData.clear();
              if (_suggestionData.isEmpty) {
                setState(() {});
                return;
              }
              final List<String>? _data = ApiService.instance().avaliable?.data;

              if (_data != null) {
                _suggestionData.addAll(
                    _data.where((data) => data.contains(searchData)).toList());
              }
              setState(() {});
            },
          ),
          /* StarlightTypeAhead(
            controller: _controller,
            data: ApiService.instance().avaliable?.data,
            width: MediaQuery.of(context).size.width,
            height: 100,
            itemHeight: 50,
            itemBuilder: (a) {
              return Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('$a'),
              );
            },
          ),*/
          if (_suggestionData.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                itemCount: _suggestionData.length,
                itemBuilder: (_, index) => InkWell(
                  onTap: () {
                    insertData(_suggestionData[index]);
                  },
                  child: Text(_suggestionData[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
