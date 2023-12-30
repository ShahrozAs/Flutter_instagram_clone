import 'package:flutter/material.dart';
// import 'package:instagram_mad/Crud_operations/realtime_database.dart';


void createBottomSheet(BuildContext context){

  showModalBottomSheet(isScrollControlled: true,context: context, builder: (BuildContext context) {
    
    return  Padding(
      padding:  EdgeInsets.only(top:20,left: 20,right: 20,bottom: MediaQuery.of(context).viewInsets.bottom+20),
      child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
           children: [
            Center(
              child: Container(
                height: 3.0,
                width: 35,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 30,),
            
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
                Text("Settings and privacy",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border)),
                Text("Saved",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.restore)),
                Text("Archive",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.history_toggle_off)),
                Text("Your activity",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(Icons.menu_open_sharp)),
                Text("Closed Friends",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            
            const SizedBox(height: 20,),
            
           ],
      ),
    );
  },);

}