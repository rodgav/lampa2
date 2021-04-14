import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ItemAtractivo extends StatelessWidget {
  String asset;
  String nombre;
  String distancia;
  VoidCallback onTap;

  ItemAtractivo(
      {@required this.asset,
      @required this.nombre,
      @required this.distancia,
      @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 120,
        height: 120,
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
        ),
        child: Column(
          children: [
            Container(
                width: 93,
                height: 93,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.5), //(x,y)
                        blurRadius: 2.0,
                      ),
                    ]),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width: 93,
                        height: 93,
                        imageUrl: asset,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.error)),
                      ),
                    ),
                    distancia != ''
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Text(
                              distancia,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : Container()
                  ],
                )),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                nombre,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                maxLines: 1,overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
