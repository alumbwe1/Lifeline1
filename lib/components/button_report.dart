import 'package:flutter/material.dart';
 class ReportButton extends StatelessWidget {
   const ReportButton({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Container(
       height: 80,
       width: 100,
       decoration: BoxDecoration(
         color: Colors.purple,
         borderRadius: BorderRadius.circular(40)
       ),
       child: const Text(
         'Report',style: TextStyle(fontSize: 20,),
       ),
     );
   }
 }
 