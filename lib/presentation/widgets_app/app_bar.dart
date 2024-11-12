import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  final String title;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key, 
    required this.title,
    this.onLogout
  });
  
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        MenuAnchor(
            builder: (context, controller, child){
              return IconButton(
                  onPressed: (){
                    if(controller.isOpen){
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  icon: Icon(Icons.menu)
              );
            },
            menuChildren: [
              MenuItemButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(
                    const Size(180, 40),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.logout, size: 18),
                    SizedBox(width: 8),
                    Text('Cerrar sesión', style: TextStyle(fontSize: 14)),
                  ],
                ),
                onPressed: () {
                  print("Cerrar sesión");
                  },
              ),
            ]
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
}