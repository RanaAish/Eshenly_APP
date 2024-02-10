import 'package:flutter/material.dart';
class ReturnPolicy extends StatelessWidget {
  const ReturnPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40,bottom: 15,right: 10,left: 10),
            child: Container(
              child: Text(
                '''
   Enjoy shopping with the following return policy features:

- You have 14 days to return the products sold after receipt Shipping cost will be added through the returns in your customer account or by calling customer service number (Company Number) or via email Company email.
- If the item have a defective, does not work properly, does not match the description of the site, is fake, or was received damaged as a result of transportation and shipment, you have the right to return it within 30 days from the date of receipt for free, and the value of the item will be refunded to you within a maximum period of 14 working days.
- When returning the product, make sure that all the accessories and labels for the order are in their proper condition and that the product is in its original package in the correct condition in which it was received and that the package is closed by the factory sealed (in the case of replacement within 14 days) as well as the inclusions in the offers such as included gifts with the products or Exceptional accessories. If you create a password for the device that you want to retrieve, please make sure to remove it, otherwise the request will not be completed correctly for products that show manufacturing defects within 30 days of purchase and applies if they are returned and received with all the inclusions, as well as the inclusions in the offers such as included gifts with the products or Exceptional accessories labels and packaging of the device in its receiving conditions.

Some products cannot be returned, and they are:

• Damaged Products (excluding transportation damage)
• Products that are not in their original packaging
• Products that do not include all accessories
• Unsealed products from the following product groups

          '''.replaceAll(RegExp(r"\s+"), " "),style: TextStyle(
                  wordSpacing: 1,
                fontSize: 20
              ),
              ),),
          ),
        )
    );;
  }
}
