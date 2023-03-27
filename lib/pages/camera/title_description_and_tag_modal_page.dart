import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/modals/modal_tag_choose.dart';
import 'package:photo_gallery/modals/modal_title_and_description.dart';
import 'package:photo_gallery/pages/camera/bloc/camera_bloc.dart';

class TitleDescriptionAndtagModalPage extends StatelessWidget {
  const TitleDescriptionAndtagModalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CameraBloc, CameraState>(
          buildWhen: (previous, current) =>
              previous.pictureModel.id != current.pictureModel.id ||
              previous.pictureModel.title != current.pictureModel.title ||
              previous.pictureModel.description !=
                  current.pictureModel.description ||
              previous.pictureModel.base64 != current.pictureModel.base64 ||
              previous.pictureModel.tag != current.pictureModel.tag ||
              previous.pictureModel.date != current.pictureModel.date,
          builder: (context, state) {
            if (state is CameraTakePictureState) {
              print('state is CameraTakePictureState');
              SchedulerBinding.instance.addPostFrameCallback((_) async {
                // <== HERE
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ModalTitleAndDescriptionStepper();
                  },
                );
              });
            } else if (state is CameraSaveTitleAnddescriptionState) {
              print('state is CameraSaveTitleAnddescriptionState');
              SchedulerBinding.instance.addPostFrameCallback((_) async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ModalTagChoose();
                  },
                );
              });
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Image.memory(
                    base64Decode(state.pictureModel.base64),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
