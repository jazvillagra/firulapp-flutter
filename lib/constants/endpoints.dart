import 'package:firulapp/src/pets/components/adoptions/transfer_pet.dart';

class Endpoints {
  static final baseUrl = '';
  static final user = '/user';
  static final param = '/param';
  static final login = '$user/login';
  static final signUp = '$user/register';
  static final logout = '$user/logout';
  static final species = '$param/species';
  static final breeds = '$param/breed/species';
  static final updateUser = '$user/update';
  static final city = '$param/city';
  static final pet = '/pet';
  static final petSave = '$pet/save';
  static final petDelete = '$pet/delete';
  static final petByUser = '$pet/user';
  static final petByStatus = '$pet/status';
  static final medicalRecord = '$pet/medical/record';
  static final medicalRecordByPet = '$pet/medical/record/pet';
  static final saveMedicalRecord = '$medicalRecord/save';
  static final deleteMedicalRecord = "$medicalRecord/delete";
  static final vaccinationRecord = '$pet/vaccination/record';
  static final vaccinationRecordByPet = '$vaccinationRecord/pet';
  static final saveVaccinationRecord = '$vaccinationRecord/save';
  static final deleteVaccinationRecord = "$vaccinationRecord/delete";
  static final petActivity = '$pet/activity';
  static final petActivityByPet = '$petActivity/pet';
  static final savePetActivity = '$petActivity/save';
  static final userAgenda = '$user/agenda';
  static final lostAndFoundReports = '$pet/report/open';
  static final reportLostPet = '$pet/report/pet/lost';
  static final reportFoundPet = '$pet/report/pet/found';
  static final closeReport = '$pet/report/close';
  static final transferPet = '$pet/transfer/';
}
