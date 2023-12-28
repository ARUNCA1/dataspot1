
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        showDialog(
            context: context,
            builder: (builder) => AlertDialog(
              title: const Text(
                'VIBGYOR',
                style: TextStyle(color: Colors.green),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text('.'),
                    Text('Would you like to exit this app?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) => exit(0)));
                  },
                ),
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => HomePage()));
                  },
                ),
              ],
            ));
        //

      return true;
      },
      child: Scaffold(

        body: ChangeNotifierProvider(
          create: (context) => SuperHeroProvider(),
          builder: (context, snapshot) {
            return const SuperHero();
          },
        ),
       ),
    );
  }
}

class SuperHero extends StatefulWidget {
  const SuperHero({
    Key? key,
  }) : super(key: key);

  @override
  State<SuperHero> createState() => _SuperHeroState();
}

class _SuperHeroState extends State<SuperHero> {
  var array;
  TextEditingController Controller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var courseDetailsModel =
    Provider.of<SuperHeroProvider>(context, listen: false);
    courseDetailsModel.getsuperHeroDetails();

    return Consumer<SuperHeroProvider>(
        builder: (context, courseDetailsRepo, _) {
          return courseDetailsRepo.loadingStatus
              ? const Center(child: CircularProgressIndicator())
              : Padding(
            padding: const EdgeInsets.all(8.0),
            // implement GridView.builder
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:40,left: 8,right: 8),
                  child: Container(
                    height: 50,
                    child: TextFormField(
                      controller: Controller,
                       onChanged: (value){
                         array = courseDetailsModel.superhero.where((i) => i.name!.toUpperCase()!.contains(value)).toList();
                       print(array.toString()+"kkk");
                     value.length==4?
                      setState(() {
                       array;
                       print("array"+array.length.toString());
                      }):value.length==0? setState(() {
                       array;
                       print("array"+array.length.toString());
                     }):print("n");
                       },
                      // validator: (value) {
                      //   if (value != null && value.trim().length < 3) {
                      //     return 'This field requires a minimum of 3 characters';
                      //   }
                      //
                      //   return null;
                      // },
                      decoration: const InputDecoration(
                          labelText: 'Search Capital',

                          // This is the normal border
                          border: OutlineInputBorder(),

                          // This is the error border
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red, width: 5))),
                    ),
                  ),
                ),

                Controller.text.length==0?
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1.5/ 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: courseDetailsModel.superhero.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Stack(
                                children: [

                                  Container(

                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                      NetworkImage(courseDetailsModel.superhero[index].image.toString()),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40,top: 20),
                                    child: Container(
                                      width: 20,
                                      child: CircleAvatar(
                                        radius: 30.0,
                                      backgroundColor: courseDetailsModel.superhero[index].isOnline==true?Colors.green:Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                 // color: Colors.grey.shade100
                                  height: 60,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    color: Colors.grey.shade100,
                                    child: Column(
                                      children: [
                                        Text(courseDetailsModel.superhero[index].name.toString())
                                       , Text(courseDetailsModel.superhero[index].email.toString(),style: TextStyle(color: Colors.black),)

                                      ],
                                    ),
                                  ))
                           , SizedBox(height: 20,)
                              ,Text(courseDetailsModel.superhero[index].mobile.toString(),style: TextStyle(color: Colors.grey),),
                              Text(courseDetailsModel.superhero[index].zone.toString(),style: TextStyle(color: Colors.grey),),
                           Expanded(child: Container()),
                            Container(
                              height: 20,
                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.only( bottomLeft:Radius.circular(15), bottomRight: Radius.circular(15)),color: Colors.red,
                              ),

                              )

                            ],
                          ),
                        );
                      }),
                ):
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1.5/ 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: array.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            height: 200,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                Stack(
                                  children: [

                                    Container(

                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage:
                                        NetworkImage(array[index].image.toString()),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 40,top: 20),
                                      child: Container(
                                        width: 20,
                                        child: CircleAvatar(
                                          radius: 30.0,
                                          backgroundColor: array[index].isOnline==true?Colors.green:Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  // color: Colors.grey.shade100
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: Card(
                                      color: Colors.grey.shade100,
                                      child: Column(
                                        children: [
                                          Text(array[index].name.toString())
                                          , Text(array[index].email.toString(),style: TextStyle(color: Colors.black),)

                                        ],
                                      ),
                                    ))
                                , SizedBox(height: 5,)
                                ,Text(array[index].mobile.toString(),style: TextStyle(color: Colors.grey),),
                                Text(array[index].zone.toString(),style: TextStyle(color: Colors.grey),),
                                Expanded(child: Container()),
                                Container(
                                  height: 20,
                                  decoration: BoxDecoration(

                                    borderRadius: BorderRadius.only( bottomLeft:Radius.circular(15), bottomRight: Radius.circular(15)),color: Colors.red,
                                  ),

                                )

                              ],
                            ),
                          );
                        }),
                  ),
                )
                ,
              ],
            ),
          ); });
  }
}
