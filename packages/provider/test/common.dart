import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

Element findElementOfWidget<T extends Widget>() {
  return find.byType(T).first.evaluate().first;
}

Type typeOf<T>() => T;

class InitialValueBuilderMock<T> extends Mock {
  InitialValueBuilderMock([T value]) {
    when(this(any)).thenAnswer((_) => value);
  }

  T call(BuildContext context);
}

class ValueBuilderMock<T> extends Mock {
  ValueBuilderMock([T value]) {
    when(this(any, any)).thenReturn(value);
  }
  T call(BuildContext context, T previous);
}

class StartListeningMock<T> extends Mock {
  StartListeningMock([VoidCallback value]) {
    when(this(any, any)).thenReturn(value);
  }

  VoidCallback call(InheritedProviderElement<T> context, T value);
}

class StopListeningMock extends Mock {
  void call();
}

class DisposeMock<T> extends Mock {
  void call(BuildContext context, T value);
}

class MockNotifier extends Mock implements ChangeNotifier {}

class BuilderMock extends Mock {
  Widget call(BuildContext context);
}

class StreamMock<T> extends Mock implements Stream<T> {}

class FutureMock<T> extends Mock implements Future<T> {}

class StreamSubscriptionMock<T> extends Mock implements StreamSubscription<T> {}

class MockConsumerBuilder<T> extends Mock {
  Widget call(BuildContext context, T value, Widget child);
}

class UpdateShouldNotifyMock<T> extends Mock {
  bool call(T old, T newValue);
}

class TextOf<T> extends StatelessWidget {
  const TextOf();

  @override
  Widget build(BuildContext context) {
    return Text(
      Provider.of<T>(context).toString(),
      textDirection: TextDirection.ltr,
    );
  }
}

class DeferredStartListeningMock<T, R> extends Mock {
  DeferredStartListeningMock(
      [VoidCallback call(
        DeferredInheritedProviderElement<T, R> context,
        void Function(R value) setState,
        T controller,
        R value,
      )]) {
    if (call != null) {
      when(this(any, any, any, any)).thenAnswer((invoc) {
        return Function.apply(
          call,
          invoc.positionalArguments,
          invoc.namedArguments,
        ) as VoidCallback;
      });
    }
  }

  VoidCallback call(
    DeferredInheritedProviderElement<T, R> context,
    void Function(R value) setState,
    T controller,
    R value,
  );
}

class DebugCheckValueTypeMock<T> extends Mock {
  void call(T value);
}

class A with DiagnosticableTreeMixin {}

class B with DiagnosticableTreeMixin {}

class C with DiagnosticableTreeMixin {}

class D with DiagnosticableTreeMixin {}

class E with DiagnosticableTreeMixin {}

class F with DiagnosticableTreeMixin {}

class MockCombinedBuilder extends Mock {
  Widget call(Combined foo);
}

class CombinerMock extends Mock {
  Combined call(BuildContext context, A a, Combined foo);
}

class ProviderBuilderMock extends Mock {
  Widget call(BuildContext context, Combined value, Widget child);
}

class Combined extends DiagnosticableTree {
  final A a;
  final B b;
  final C c;
  final D d;
  final E e;
  final F f;
  final Combined previous;
  final BuildContext context;

  Combined(this.context, this.previous, this.a,
      [this.b, this.c, this.d, this.e, this.f]);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is Combined &&
      other.context == context &&
      other.previous == previous &&
      other.a == a &&
      other.b == b &&
      other.c == c &&
      other.e == e &&
      other.f == f;

  // fancy toString for debug purposes.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.properties.addAll([
      DiagnosticsProperty('a', a, defaultValue: null),
      DiagnosticsProperty('b', b, defaultValue: null),
      DiagnosticsProperty('c', c, defaultValue: null),
      DiagnosticsProperty('d', d, defaultValue: null),
      DiagnosticsProperty('e', e, defaultValue: null),
      DiagnosticsProperty('f', f, defaultValue: null),
      DiagnosticsProperty('previous', previous, defaultValue: null),
      DiagnosticsProperty('context', context, defaultValue: null),
    ]);
  }
}

class MyListenable extends ChangeNotifier {}

class MyStream extends Stream<void> {
  @override
  StreamSubscription<void> listen(void Function(void event) onData,
      {Function onError, void Function() onDone, bool cancelOnError}) {
    return null;
  }
}
