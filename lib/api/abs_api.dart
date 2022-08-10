import '../helper/client_helper.dart';

abstract class AbsAPI {
  ClientHelper client = ClientHelper();

  AbsAPI() {
    client = ClientHelper();
  }
}
