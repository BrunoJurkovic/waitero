import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waitero/providers/products.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.8;
    const Radius radius = Radius.circular(50);
    const BorderRadius borderRadius = BorderRadius.horizontal(
      left: radius,
      right: radius,
    );

//     return Card(
//       shape: const RoundedRectangleBorder(borderRadius: borderRadius),
//       elevation: 0,
//       child: InkWell(
//         onTap: () {
// //          TODO: expand the widget
//         },
//         borderRadius: borderRadius,
//         child: Container(
//           width: width,
//           height: 150,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Text(
//                   'Order ID: orderId',
//                   style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
//                 ),
//               ),
//               Icon(
//                 Icons.arrow_forward,
//                 size: 36,
//                 color: Colors.grey,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
      return Image.network(Provider.of<Product>(context).products[0].imageId);
  }
}
