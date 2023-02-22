import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

extension OptionalInfixSubtraction<T extends num> on T? {
  T? operator -(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow - (other ?? 0) as T;
    } else {
      return null;
    }
  }
}

void testIt() {
  final int? int1 = null;
  final int? int2 = 1;
  final result = int1 + int2;
  print(result);
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  void incrementCounter() => state = state == null ? 1 : state + 1;
  void decrementCounter() => state = state == null ? 1 : state - 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>((ref) {
  return Counter();
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer(
          builder: (context, ref, child) {
            final counter = ref.watch(counterProvider);
            final text =
                counter == null ? "press the button" : counter.toString();
            return Text(text);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            onPressed: ref.read(counterProvider.notifier).incrementCounter,
            child: const Text("increment counter"),
          ),
          TextButton(
            onPressed: ref.read(counterProvider.notifier).decrementCounter,
            child: const Text("decrement counter"),
          ),
        ],
      ),
    );
  }
}
