import 'package:flutter/material.dart';
import 'package:todoflutter/models/category.dart';
import 'package:todoflutter/screens/home.dart';
import 'package:todoflutter/services/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();
  var category;
  List<Category> _categoryList = List<Category>();
  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async{
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category){
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);

      });
    });
  }

  _editCategory(BuildContext context, categoryId) async{
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name']??'No Name';
      _editCategoryDescriptionController.text = category[0]['description']??'No Description';
    });
    _editFormDialog(context);
  }
  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.orange,
                onPressed: () => Navigator.of(context).pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.white),),
              ),
              FlatButton(color: Colors.orange,
                  onPressed: () async{
                _category.name = _categoryNameController.text;
                _category.description = _categoryDescriptionController.text;

                var result = await _categoryService.saveCategory(_category);
                Navigator.pop(context);
                getAllCategories();
                  },
                  child: Text('Save', style: TextStyle(color: Colors.white),))
            ],
            title: Text('Add Category'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }
  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.orange,
                onPressed: () => Navigator.of(context).pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.white),),
              ),
              FlatButton(color: Colors.orange,
                  onPressed: () async{
                    _category.id = category[0]['id'];
                    _category.name = _editCategoryNameController.text;
                    _category.description = _editCategoryDescriptionController.text;
                    var result = await _categoryService.updateCategory(_category);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(Text("Updated", style: TextStyle(backgroundColor: Colors.green, color: Colors.white),));
          }
                    print(result);
                  },
                  child: Text('Update', style: TextStyle(color: Colors.white),))
            ],
            title: Text('Edit Category'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                        hintText: 'Enter category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'Enter description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                color: Colors.green,
                onPressed: () => Navigator.of(context).pop(context),
                child: Text('Cancel', style: TextStyle(color: Colors.white),),
              ),
              FlatButton(color: Colors.red,
                  onPressed: () async{

                    var result = await _categoryService.deleteCategory(categoryId);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(Text("Deleted", style: TextStyle(backgroundColor: Colors.green, color: Colors.white),));
                    }
                    print(result);
                  },
                  child: Text('Delete', style: TextStyle(color: Colors.white),))
            ],
            title: Text('Are you sure you want to delete this category?'),

          );
        });
  }

  _showSuccessSnackBar(message){
    var _snackBar = SnackBar(content: message, backgroundColor: Colors.green,);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () =>
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
        ),
        title: Text('Categories'),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(itemCount:_categoryList.length, itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.only(top:5.0, bottom: 5.0),
          child: Card(
            elevation: 5.0,
            child: ListTile(
              leading: IconButton(icon: Icon(Icons.edit), onPressed: (){
                _editCategory(context, _categoryList[index].id);
              }),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_categoryList[index].name),
                  IconButton(icon: Icon(Icons.delete, color: Colors.red,),onPressed: (){
                    _deleteFormDialog(context, _categoryList[index].id);
                  },)
                ],
              ),
              subtitle: Text(_categoryList[index].description),
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        splashColor: Colors.white,
      ),
    );
  }
}
