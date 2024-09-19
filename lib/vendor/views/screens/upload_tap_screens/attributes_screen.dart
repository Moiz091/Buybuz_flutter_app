import 'package:flutter/material.dart';
import 'package:mrktplace_store/provider/product_provider.dart';
import 'package:provider/provider.dart';

class AttributesTabScreen extends StatefulWidget {
  @override
  State<AttributesTabScreen> createState() => _AttributesTabScreenState();
}

class _AttributesTabScreenState extends State<AttributesTabScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final TextEditingController _sizeController = TextEditingController();
  bool _entered = false;
  List<String> _sizeList = [];
  bool _isSave = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _prodcutProvider =
        Provider.of<ProductProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextFormField(
            validator: ((value) {
              if (value!.isEmpty) {
                return 'Enter Brand Name';
              } else {
                return null;
              }
            }),
            onChanged: (value) {
              _prodcutProvider.getFormData(brandName: value);
            },
            decoration: InputDecoration(labelText: 'Brand'),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Flexible(
                child: Container(
                  width: 200,
                  child: TextFormField(
                    controller: _sizeController,
                    onChanged: (value) {
                      setState(() {
                        _entered = true;
                      });
                    },
                    decoration: InputDecoration(labelText: 'Size'),
                  ),
                ),
              ),
              _entered == true
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF3366FF)),
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          _sizeController.clear();
                        });
                        print(_sizeList);
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ))
                  : Text(''),
            ],
          ),
          if (_sizeList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _sizeList.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _sizeList.removeAt(index);
                              _prodcutProvider.getFormData(sizeList: _sizeList);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF3366FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                _sizeList[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3366FF)),
                onPressed: () {
                  _prodcutProvider.getFormData(sizeList: _sizeList);
                  setState(() {
                    _isSave = true;
                  });
                },
                child: Text(
                  _isSave ? 'Saved' : 'Save',
                  style: TextStyle(color: Colors.white),
                ))
        ],
      ),
    );
  }
}
