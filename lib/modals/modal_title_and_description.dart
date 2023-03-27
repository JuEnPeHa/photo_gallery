import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_gallery/consts.dart';

class ModalTitleAndDescriptionStepper extends StatefulWidget {
  const ModalTitleAndDescriptionStepper({super.key});

  @override
  State<ModalTitleAndDescriptionStepper> createState() =>
      _ModalTitleAndDescriptionStepperState();
}

class _ModalTitleAndDescriptionStepperState
    extends State<ModalTitleAndDescriptionStepper> {
  int currentStep = 0;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final FocusNode _titleFocusNode;
  late final FocusNode _descriptionFocusNode;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Dialog(
      // backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.green.withOpacity(0.35),
          borderRadius: BorderRadius.circular(10),
        ),
        height: size.height * 0.45,
        width: size.width * 0.85,
        child: Center(
          child: Stepper(
            type: StepperType.vertical,
            currentStep: currentStep,
            onStepCancel: () {
              if (currentStep > 0) {
                setState(() {
                  currentStep -= 1;
                });
              } else {
                callCancelEventWithBloc(context: context);
              }
            },
            onStepContinue: () {
              bool isLastStep = currentStep ==
                  getSteps(context: context, currentStep: currentStep).length -
                      1;
              if (isLastStep) {
                callSaveTitleAndDescriptionEventWithBloc(
                  context: context,
                  title: _titleController.text,
                  description: _descriptionController.text,
                );
              } else {
                setState(() {
                  currentStep += 1;
                });
              }
            },
            steps: getSteps(
              context: context,
              currentStep: currentStep,
              titleController: _titleController,
              descriptionController: _descriptionController,
            ),
          ),
        ),
      ),
    );
  }
}

List<Step> getSteps({
  required BuildContext context,
  required int currentStep,
  TextEditingController? titleController,
  TextEditingController? descriptionController,
  FocusNode? titleFocusNode,
  FocusNode? descriptionFocusNode,
}) {
  return [
    Step(
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      title: const Text('Title'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            focusNode: titleFocusNode,
            decoration: InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            maxLines: 1,
            maxLength: 75,
            onSubmitted: (String value) {
              FocusScope.of(context).requestFocus(descriptionFocusNode);
            },
          ),
        ],
      ),
      isActive: true,
    ),
    Step(
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      title: const Text('Description'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: descriptionController,
            focusNode: descriptionFocusNode,
            decoration: InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            maxLines: 3,
            maxLength: 250,
            onSubmitted: (String value) {
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
      isActive: true,
    ),
  ];
}
