import 'package:evently/common/models/event_model.dart';
import 'package:evently/common/theme/widgets/custom_filled_bottom.dart';
import 'package:evently/common/theme/widgets/custom_text_field.dart';
import 'package:evently/common/utils/shared_container_decoration.dart';
import 'package:evently/common/utils/validation_utils.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/network/event_service.dart';
import 'package:evently/screens/events/add_new_events/category_row_widget.dart';
import 'package:evently/screens/events/provider/events_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({super.key});
  static const String routeName = "/add_new_event_screen";
  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _description = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => EventsProvider(),
      child: Form(
        key: _globalKey,
        child: Consumer<EventsProvider>(
          builder: (BuildContext context, provider, Widget? child) {
           
            return Scaffold(
              appBar: AppBar(
                title: Text("Add Event"),
              ),      
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 16,
                    children: [
                      Container(
                        decoration:
                            SharedContainerDecoration.decorationWithBorder(
                              theme,
                            ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            provider.selectedCtegory.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      CustomCategoryRow(),
                      CustomTextField(
                        titleText: "Event title",
                        hintText: "Title",
                        controller: _titleController,
                        validator: (value) =>
                            ValidationUtils.validateEmptyText(value)
                            ? null
                            :AppLocalizations.of(context)!.title_is_required,

                            //TODO:localization
                      ),
                      CustomTextField(
                        titleText: "Descreption",
                        hintText: "Event Descreption.....",
                        maxLines: 5,
                        controller: _description,
                        validator: (value) =>
                            ValidationUtils.validateEmptyText(value)
                            ? null
                            : "description is required", //TODO:localization
                      ),
                      _drawDataRow(
                        Icons.date_range_outlined,
                        "Event Data",
                        _getDate(provider),
                        () async {
                          DateTime? returnedValue = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030),
                            initialDate: DateTime.now(),
                          );
                          if (returnedValue != null) {
                            provider.editDate(returnedValue);
                          }
                          if (context.mounted) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      _drawDataRow(
                        Icons.date_range_outlined,
                        "Event Time",

                        _getTime(provider),
                        () async {
                          TimeOfDay? returnedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (returnedTime != null) {
                            provider.editTime(returnedTime);
                          }
                          if (context.mounted) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                      ),
                      CustomFilledBottom(
                        isLoading: isLoading,
                        text: "Add Events",
                        onPressed: () async {
                          if (_validateForm(provider)) {
                            setState(() {
                              isLoading = true;
                            });
                            DateTime date = provider.selectedDate!;

                            date = date.copyWith(
                              hour: provider.selectedTime!.hour,
                              minute: provider.selectedTime!.minute,
                            );

                            EventModel eventModel = EventModel(
                              catid: provider.selectedCtegory.id,
                              date: date,
                              description: _description.text,
                              title: _titleController.text,
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            );
                            String? errorMessage =
                                await EventService.createNewEvent(eventModel);
                            setState(() {
                              isLoading = false;
                            });
                            if (errorMessage != null) {
                              Fluttertoast.showToast(
                                msg: errorMessage,
                                backgroundColor: Colors.red,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Event Add sucssefuly",
                              );
                              if (context.mounted) {
                                // Nvigator.of(context).pop(true);
                                Navigator.pop(context, true);
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _validateForm(EventsProvider Provider) {
    if (!_globalKey.currentState!.validate()) {
      return false;
    } else {
      if (Provider.selectedDate == null) {
        Fluttertoast.showToast(msg: "Date is required");
        return false;
      }
      if (Provider.selectedTime == null) {
        Fluttertoast.showToast(msg: "Time is required");
        return false;
      }
      return true;
    }
  }

  _getDate(EventsProvider Provider) {
    if (Provider.selectedDate == null)
      return "select";
    else {
      return "${Provider.selectedDate!.year}/${Provider.selectedDate!.month}/${Provider.selectedDate!.day}";
    }
  }

  _getTime(EventsProvider Provider) {
    if (Provider.selectedTime == null)
      return "select";
    else {
      return Provider.selectedTime!.format(context);
    }
  }

  ListTile _drawDataRow(
    IconData icon,
    String title,
    String trailingTitle,
    void Function() onSelect,
  ) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.all(0),
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleMedium),
      trailing: TextButton(
        onPressed: onSelect,
        child: Text(
          trailingTitle,
          style: theme.textTheme.labelSmall!.copyWith(
            color: theme.colorScheme.primary,
            decoration: TextDecoration.underline,
            decorationColor: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
