import 'package:get/get.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/signin/controller/signin_controller.dart';
import 'package:inquiryapp/screens/signin/model/signin_data_model.dart';
import 'package:inquiryapp/screens/update_company_profile/api/update_company_profile_repository.dart';

class UpdateCompanyProfileController extends GetxController {
  final updateCompanyRepo = getIt.get<UpdateCompanyProfileRepository>();

  Future<SigninDataModel> updateCompanyProfile({ required String companyName,
    required String businessCategoryId,
    required String businessTypeId,
    required String state,
    required String city,}) async {
    UtilityHelper.instance.showLoader();

    final responseModel = await updateCompanyRepo.updateCompanyProfile(
        companyName: companyName,
        businessCategoryId: businessCategoryId,
        businessTypeId: businessTypeId,state:state,city: city
    );
    // {"username":"Rohan 39","email":"rohan39@gmail.com","mobile":"8160353539","company_name":"Test","business_category_id":"1","business_type_id":"1","state":"Test","city":"Test"}
    final SignInDataController signInDataController = Get.find();
    if (responseModel.data != null) {
      signInDataController.setUserProfileDataModel(responseModel.data!);
    }

    UtilityHelper.instance.hideLoader();
    return responseModel;
  }

}
