import 'package:flutter/material.dart';

class AppBarQuipux extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const AppBarQuipux({
    Key? key,
    this.title,
    this.onBackPressed,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor ?? Theme.of(context).primaryColor,
            backgroundColor?.withOpacity(0.8) ??
                Theme.of(context).primaryColor.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        elevation: 0, // Quitamos la sombra del AppBar porque ya tenemos la del Container
        backgroundColor: Colors.transparent, // Hacemos transparente el AppBar para ver el gradient
        centerTitle: true,
        title: Text(
          "App bar",
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textColor ?? Colors.white,
            size: 22,
          ),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
          splashRadius: 24,
          tooltip: 'Regresar',
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
              ),
            ),
            child: PopupMenuButton(
              offset: const Offset(-20, 45),
              icon: Icon(
                Icons.more_vert,
                color: textColor ?? Colors.white,
                size: 24,
              ),
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem(
                  value: 1,
                  child: ListTile(
                    leading: Icon(Icons.settings, size: 22),
                    title: Text('Configuración'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: ListTile(
                    leading: Icon(Icons.person, size: 22),
                    title: Text('Perfil'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: ListTile(
                    leading: Icon(Icons.help_outline, size: 22),
                    title: Text('Ayuda'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                const PopupMenuItem(
                  value: 4,
                  child: ListTile(
                    leading: Icon(Icons.logout, size: 22),
                    title: Text('Cerrar sesión'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              onSelected: (value) {
                switch (value) {
                  case 1:
                  // Acción para configuración
                    break;
                  case 2:
                  // Acción para perfil
                    break;
                  case 3:
                  // Acción para ayuda
                    break;
                  case 4:
                  // Acción para cerrar sesión
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}