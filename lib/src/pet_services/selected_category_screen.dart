import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../constants/constants.dart';
import '../../provider/pet_service.dart';
import '../../provider/service_type.dart';
import './service_screen.dart';

class SelectedCategoryScreen extends StatefulWidget {
  static const routeName = "/selected-category";

  @override
  _SelectedCategoryScreenState createState() => _SelectedCategoryScreenState();
}

class _SelectedCategoryScreenState extends State<SelectedCategoryScreen> {
  Future _servicesFuture;
  bool fetchServicesFlag = true;

  Future _obtainServicesFuture() {
    return Provider.of<PetService>(context).fetchServicesByType();
  }

  @override
  void didChangeDependencies() {
    if (fetchServicesFlag) {
      _servicesFuture = _obtainServicesFuture();
      fetchServicesFlag = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final SizeConfig sizeConfig = SizeConfig();
    final serviceTypeId = ModalRoute.of(context).settings.arguments as int;
    final serviceType = ServiceType.DUMMY_CATEGORIES
        .firstWhere((element) => element.id == serviceTypeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceType.title),
      ),
      body: FutureBuilder(
        future: _servicesFuture,
        builder: (_, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('Algo salio mal'),
              );
            } else {
              return Consumer<PetService>(builder: (ctx, services, child) {
                if (services.itemCount != 0) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return _availableService(
                        services.items[index],
                      );
                    },
                    itemCount: services.itemCount,
                  );
                } else {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/images/empty.png",
                              ),
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                        Text(
                          'Sin Servicios Disponibles',
                          style: TextStyle(
                            fontSize: sizeConfig.hp(4),
                            color: Constants.kPrimaryColor,
                          ),
                        )
                      ],
                    ),
                  );
                }
              });
            }
          }
        },
      ),
    );
  }

  Widget _availableService(PetServiceItem item) {
    return Container(
      height: 100,
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        elevation: 6,
        child: Center(
          child: ListTile(
              title: Text(
                item.title,
              ),
              subtitle: Text(
                item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ServiceScreen.routeName, arguments: item.id);
              },
              trailing: Icon(Icons.arrow_forward_ios)),
        ),
      ),
    );
  }
}
