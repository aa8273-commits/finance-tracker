import 'package:finance/cubit/SettingsCubit.dart';
import 'package:flutter/material.dart';

class currencyWidget extends StatelessWidget {
  const currencyWidget({
    super.key,
    required this.currencies,
    required this.cubit,
    required this.state,
  });

  final List<String> currencies;
  final SettingsCubit cubit;
  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.attach_money),
      title: const Text("Currency"),
      subtitle: Text(state.settings.currency),
      trailing: const Icon(Icons.arrow_forward_ios),

      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(currencies[index]),
                  onTap: () {
                    cubit.changeCurrency(currencies[index]);
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
