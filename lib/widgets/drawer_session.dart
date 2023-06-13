import 'package:cuchos_market_mobile/models/session.dart';
import 'package:flutter/material.dart';

class DrawerSession extends StatefulWidget {
  const DrawerSession({Key? key}) : super(key: key);

  @override
  State<DrawerSession> createState() => _DrewerSessionState();
}

class _DrewerSessionState extends State<DrawerSession> {
  final Session session = Session();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey[900],
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    child: const Icon(Icons.person),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${session.user?.firstName} ${session.user?.lastName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${session.user?.email}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
