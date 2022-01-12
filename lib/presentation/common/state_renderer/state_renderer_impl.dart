import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/data/mapper/mapper.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getstateRendererType();
  String getMessage();
}

//Loading State (POPUP, FULL SCREEEN)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

//error state(POPUP, FULL LOADING)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getstateRendererType() => stateRendererType;
}

//content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getstateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

//Empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getstateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getstateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            //showing popup dialog
            showPopUp(context, getstateRendererType(), getMessage());
            //return content ui the screen
            return contentScreenWidget;
          } else //StateRendererType.FULL_SCREEN_LOADING_STATE
          {
            return StateRenderer(
                stateRendererType: getstateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ErrorState:
        {
          dissmisDialog(context);
          if (getstateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            //showing popup dialog
            showPopUp(context, getstateRendererType(), getMessage());
            //return content ui the screen
            return contentScreenWidget;
          } else //StateRendererType.FULL_SCREEN_ERROR_STATE
          {
            return StateRenderer(
                stateRendererType: getstateRendererType(),
                message: getMessage(),
                retryActionFunction: retryActionFunction);
          }
        }
      case ContentState:
        {
          dissmisDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              stateRendererType: getstateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction);
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  dissmisDialog(BuildContext context) {
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              retryActionFunction: () {},
            )));
  }
}
