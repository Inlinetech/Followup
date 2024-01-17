import 'package:get/get.dart';
import 'package:inquiryapp/common/singleton_services.dart';
import 'package:inquiryapp/common/utillity_helper.dart';
import 'package:inquiryapp/screens/export/api/export_lead_repository.dart';
import 'package:inquiryapp/screens/export/model/export_lead_model.dart';
import 'package:inquiryapp/screens/home/model/lead_data_model.dart';

class ExportLeadDataController extends GetxController {
  final exportLeadRepo = getIt.get<ExportLeadRepository>();

  //Leads
  List<LeadDataModel> get leads => _leads;

  List<LeadDataModel> _leads = [];

  setLeads(List<LeadDataModel> value) {
    _leads = value;
    _selectedLeads = [];
    update();
  }

  //Selected Leads;
  List<LeadDataModel> get selectedLeads => _selectedLeads;

  List<LeadDataModel> _selectedLeads = [];

  setSelectedLeads(LeadDataModel value) {
    if (_selectedLeads.contains(value)) {
        value.isSelected = false;
      _selectedLeads.remove(value);
    } else {
      value.isSelected = true;
      _selectedLeads.add(value);
    }
    update();
  }

  setSelectedAllLeads() {
    _selectedLeads = [];
    for (var i=0;i<_leads.length;i++) {
      var lead = _leads[i];
      lead.isSelected = true;
      _selectedLeads.add(lead);
    }

    update();
  }

  setClearAllLeads() {
    _selectedLeads = [];
    for (var i=0;i<_leads.length;i++) {
      var lead = _leads[i];
      lead.isSelected = false;
    }
    update();
  }

  bool get isAllSelected => (_leads.isNotEmpty && _selectedLeads.length == _leads.length);

  Future<ExportLeadBaseModel> exportLeads() async {
    UtilityHelper.instance.showLoader();
    final idsArray = _selectedLeads.map((e) => int.parse(e.id ?? '')).toList();
    idsArray.sort((a,b) {
      return a.compareTo(b);
    });
    final ids = idsArray.join(",");

    final newlyAddedLead = await exportLeadRepo.exportLeads(
      ids: ids,
    );
    UtilityHelper.instance.hideLoader();
    return newlyAddedLead;
  }

}
