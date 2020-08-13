import 'package:flutter/material.dart';

import 'bloc.dart';

class BlockProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlockProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    final type = _providerType<BlockProvider<T>>();
    final BlockProvider<T> provider = context.ancestorWidgetOfExactType(type);
  }

  static Type _providerType<T>() => T;

  @override
  State<StatefulWidget> createState() => _BlockProviderState();
}

class _BlockProviderState extends State<BlockProvider> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }
}
