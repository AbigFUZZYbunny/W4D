import 'package:flutter/material.dart';
import 'package:whats4dinner/models/recipe_item.dart';
import 'package:whats4dinner/colors.dart';
import 'package:whats4dinner/utils/responsive.dart';
import 'package:whats4dinner/utils/string_format.dart';
import 'package:whats4dinner/models/ingredient_item.dart';
import 'package:whats4dinner/widget/list_item.dart';
import 'package:whats4dinner/custom_icons.dart' as CustomIcons;
import 'package:whats4dinner/widget/state_widget.dart';
import 'package:whats4dinner/utils/store.dart';

class MealDetailsScreen extends StatelessWidget {
  final Recipe bakmeal;

  MealDetailsScreen({this.bakmeal});

  @override
  Widget build(BuildContext context) {
    Recipe meal = StateWidget.of(context).state.schedule[0];
    return Scaffold(
        body: DefaultTabController(
          length: 5,
          child: Column(
            children: <Widget> [
              MealDetailsAppBar(meal),
              Container(
                height: Responsiveness.setHeight(context, 60),
                color: Colors.white,
                child: TabBar(
                  isScrollable: true,
                  labelColor: DarkGray,
                  unselectedLabelColor: Gray,
                  indicatorColor: SecondaryColor,
                  tabs: _buildTabs(),
                  labelStyle: Theme.of(context).textTheme.caption,
                ),
              ),
              Expanded(
                child: _buildTabViews(meal),
              ),
            ],
          ),
        ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: SizedBox(
                height: Responsiveness.setHeight(context, 60),
                child: Center(
                  child:Text(
                    "Cook Meal",
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              onPressed: () => (){},
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  List<Tab> _buildTabs(){
    List<Tab> _tabs = new List<Tab>();
    _tabs.add(new Tab(text: "Information"));
    _tabs.add(new Tab(text: "Diets"));
    _tabs.add(new Tab(text: "Nutrition"));
    _tabs.add(new Tab(text: "Ingredients"));
    _tabs.add(new Tab(text: "Steps"));
    return _tabs;
  }
  TabBarView _buildTabViews(Recipe meal){
    TabBarView _ret = new TabBarView(children: <Widget>[],);
    _ret.children.add(new MealDetailsInfo(meal));
    _ret.children.add(new Text("Diets"));
    _ret.children.add(new Text("Nutrition"));
    _ret.children.add(new MealIngredientsInfo(meal));
    _ret.children.add(new MealSteps(meal));
    return _ret;
  }
}

class MealDetailsAppBar extends StatefulWidget {
  final Recipe meal;

  MealDetailsAppBar(this.meal);

  @override
  State<StatefulWidget> createState() => new MealDetailsAppBarState(200, meal);
}

class MealDetailsAppBarState extends State<MealDetailsAppBar> {
  final Recipe meal;
  final double height;

  MealDetailsAppBarState(this.height,this.meal);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Image.network(
            meal.image,
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: FlatButton(
              child: Text(
                "Back",
                style: Theme.of(context).textTheme.display2,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          Positioned(
            child:
            RawMaterialButton(
              constraints: BoxConstraints(minWidth: 50, minHeight: 50),
              onPressed: () => _favoritesChanged(meal),//onFavoriteButtonPressed(),
              child: Icon(
                // Conditional expression:
                // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
                inFavorites(meal) ? Icons.favorite : Icons.favorite_border,//_setFavorite() == true ? Icons.star : Icons.star_border,
                color: DarkGray,
                size: 30,
              ),
              elevation: 2.0,
              fillColor: OffWhite,
              shape: CircleBorder(),
            ),
            top: 30.0,
            right: 20.0,
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            child:
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    meal.title,
                    style: Theme.of(context).textTheme.display1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            bottom: 10,
          ),
        ],
      ),
    );
  }
  void _favoritesChanged(Recipe r) async {
    setState(() {
      if(!inFavorites(r)){
        StateWidget.of(context).state.favorites.add(r);
      }else{
        StateWidget.of(context).state.favorites.removeWhere((rec) => rec.id == r.id);
      }
    });
    await updateFavoriteMeal(StateWidget.of(context).state.user.uid, r);
  }
  bool inFavorites (Recipe r){
    if(StateWidget.of(context).state.favorites != null) {
      for (var r in StateWidget
          .of(context)
          .state
          .favorites) {
        if (r.id == r.id)
          return true;
      }
    }
    return false;
  }
}

class MealSteps extends StatelessWidget {
  final Recipe rec;

  MealSteps(this.rec);

  @override
  Widget build(BuildContext context){
    List<RecipeStep> _ret = new List<RecipeStep>();
    for(var s in rec.analyzedInstructions[0].steps){
      _ret.add(s);
    }
    return ListView.builder(
      itemCount: _ret.length,
      itemBuilder: (context, int) {
        return RecipeStepsListItem(_ret[int], int,);
      },
    );
  }
}

class MealIngredientsInfo extends StatelessWidget {
  final Recipe rec;

  MealIngredientsInfo(this.rec,);

  @override
  Widget build(BuildContext context) {
    List<IngredientItem> _ret = new List<IngredientItem>();
    for(var i in rec.extendedIngredients){
      _ret.add(i);
    }
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: LightGray,
      ),
      itemCount: _ret.length,
      itemBuilder: (context, int) {
        return IngredientListItem(_ret[int], (){}, true,);
      },
    );
  }
}

class MealDetailsInfo extends StatelessWidget {
  final Recipe meal;
  MealDetailsInfo(this.meal);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            Icons.timer,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            meal.readyInMinutes.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Minutes",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.ingredients,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            meal.extendedIngredients.length.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Ingredients",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 10, 20, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.steps,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            meal.analyzedInstructions[0].steps.length.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Steps",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.cuisine,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            capitalizeFirstLetter(meal.cuisines[0]),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Cuisine",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            Icons.attach_money,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            (meal.pricePerServing).toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Per Serving",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 10, 20, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.diet,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            meal.diets.length.toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Diets",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(20, 10, 5, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.calories,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _getCalories().toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Calories",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.carbohydrates,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _getCarbs().toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Carbs",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  Card(
                    margin: const EdgeInsets.fromLTRB(5, 10, 20, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child:
                      Column(
                        children: [
                          Icon(
                            CustomIcons.CustomIcons.fat,
                            size: 40,
                            color: DarkGray,
                          ),
                          SizedBox(height: 10),
                          Text(
                            _getFat().toString(),
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            "Fat",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Credit: Nutritionist in the Kitchen",
                        style: TextStyle(fontSize: 14.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  String _getCalories() {
    for(var n in meal.nutrition.nutrients) {
      if(n.title == "Calories"){
        String _ret = n.amount.toString();
        return _ret;
      }
    }
    return "Unknown";
  }
  String _getCarbs() {
    for(var n in meal.nutrition.nutrients) {
      if(n.title == "Carbohydrates") {
        String _ret = n.amount.toString() + " " + n.unit;
        return _ret;
      }
    }
    return "Unknown";
  }
  String _getFat() {
    for(var n in meal.nutrition.nutrients) {
      if(n.title == "Fat") {
        String _ret = n.amount.toString() + " " + n.unit;
        return _ret;
      }
    }
    return "Unknown";
  }
}