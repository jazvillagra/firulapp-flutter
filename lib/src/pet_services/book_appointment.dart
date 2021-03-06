import 'package:firulapp/provider/appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../mixins/validator_mixins.dart';
import '../../components/dialogs.dart';
import '../../size_config.dart';
import '../../components/default_button.dart';
import '../../constants/constants.dart';
import '../../provider/agenda.dart';
import '../../provider/pets.dart';

class BookAppointment extends StatefulWidget {
  static const routeName = "/book-appointment";
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment>
    with ValidatorMixins {
  Future _petsFuture;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final df = new DateFormat('dd-MM-yyyy');
  DateTime _appointmentDate = new DateTime.now();
  AppointmentItem _appointment = AppointmentItem();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: _appointmentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null && pickedDate != _appointmentDate) {
      setState(() {
        _appointmentDate = pickedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _petsFuture = Provider.of<Pets>(context, listen: false).fetchPetList();
  }

  @override
  Widget build(BuildContext context) {
    final serviceId = ModalRoute.of(context).settings.arguments as int;
    final SizeConfig sizeConfig = SizeConfig();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservar Turno"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: sizeConfig.wp(4.5),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Fecha de Turno',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Constants.kSecondaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(_appointmentDate),
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today_outlined),
                                  onPressed: () => _selectDate(context),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  SizeConfig.getProportionateScreenHeight(25),
                            ),
                            FutureBuilder(
                              future: _petsFuture,
                              builder: (_, dataSnapshot) {
                                return Consumer<Pets>(
                                  builder: (ctx, providerData, child) =>
                                      DropdownButtonFormField(
                                    items: providerData.items
                                        .map(
                                          (pet) => DropdownMenuItem(
                                            value: pet.id,
                                            child: Text(pet.name),
                                          ),
                                        )
                                        .toList(),
                                    value: _appointment.petId,
                                    onChanged: (newValue) =>
                                        _appointment.petId = newValue,
                                    hint: const Text("Mascota"),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height:
                                  SizeConfig.getProportionateScreenHeight(25),
                            ),
                            DefaultButton(
                              text: "Enviar",
                              color: Constants.kPrimaryColor,
                              press: () async {
                                if (_appointment.petId == null) {
                                  Dialogs.info(
                                    context,
                                    title: "ERROR",
                                    content: "Debe seleccionar a una mascota",
                                  );
                                  return;
                                }
                                try {
                                  setState(() {
                                    _isLoading = true;
                                    _appointment.serviceId = serviceId;
                                    _appointment.appointmentDate =
                                        _appointmentDate.toIso8601String();
                                  });
                                  Provider.of<Appointment>(
                                    context,
                                    listen: false,
                                  ).setAppointmentItem(_appointment);
                                  await Provider.of<Appointment>(
                                    context,
                                    listen: false,
                                  ).saveAppointment();
                                  /*await Dialogs.info(
                                    context,
                                    title: "Turno reservado",
                                    content:
                                        "Comuníquese con el oferente para definir el horario",
                                  );*/
                                  await Provider.of<Agenda>(context,
                                          listen: false)
                                      .fetchEvents();
                                } catch (error) {
                                  Dialogs.info(
                                    context,
                                    title: 'ERROR',
                                    content: error.response.data["message"],
                                  );
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                                int count = 0;
                                Navigator.of(context)
                                    .popUntil((_) => count++ >= 2);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
