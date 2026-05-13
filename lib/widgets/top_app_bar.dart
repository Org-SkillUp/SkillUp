import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),

      flexibleSpace: Container(
        decoration: const BoxDecoration(

          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),

          border: Border(
            bottom: BorderSide(
              color: Color(0x1AFFFFFF),
              width: 1,
            ),
          ),
        ),
      ),

      leading: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Image.asset(
          "assets/images/logo.png", 
          width: 128,
          height: 32,  
        ),
      ),

      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 59, 74, 94),
              borderRadius: BorderRadius.circular(10),
            ),

            child: IconButton(
              onPressed: () {}, 
              icon: SvgPicture.asset(
                "assets/icons/logout_icon.svg",
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  Color.fromARGB(255, 192, 192, 192), 
                  BlendMode.srcIn
                ),
              ),
            )
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}