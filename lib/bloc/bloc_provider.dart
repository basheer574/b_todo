import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  final T bloc;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext buildContext){
    BlocProvider<T> provider = buildContext.findAncestorWidgetOfExactType()!;
    return provider.bloc;
  }

}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>> {

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
