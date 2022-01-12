import 'dart:async';

import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOuputs {
  StreamController _inputStateStreamController =
      StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); //will be called while init of viewmodel
  void dispose(); //will be calles while viewmodel dies.

  Sink get inputState;
}

abstract class BaseViewModelOuputs {
  Stream<FlowState> get outputState;
}
