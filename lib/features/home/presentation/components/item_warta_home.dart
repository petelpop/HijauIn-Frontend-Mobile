import 'package:flutter/material.dart';
import 'package:hijauin_frontend_mobile/common/constants.dart';
import 'package:hijauin_frontend_mobile/common/primary_text.dart';

class ItemWartaHome extends StatelessWidget {
  const ItemWartaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 187,
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: Colors.white, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x16000000),
            blurRadius: 18,
            offset: Offset(0, 7),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Constants.imgTrashItemWarta
                ),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                SizedBox(
                  width: 155,
                  child: PrimaryText(
                    text: 'Cara Memilah Sampah Yang Benar: Panduan Lengkap Untuk Rumah Tangga',
                    color: Color(0xFF111827),
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4,),
                SizedBox(
                  width: 155,
                  child: PrimaryText(
                    text: 'Memilah sampah adalah langkah pertama krusial dalam pengelolaan sampah berkelanjutan.',
                    color: Color(0xFF4B5563),
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
