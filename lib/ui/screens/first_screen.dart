import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

import '../states/theme_provider.dart';
import '../widgets/first_screen/info_card.dart';
import '../widgets/header.dart';

class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children:  <Widget>[
            const Header(text: 'app_name'),
            Card(
              elevation: 2,
              color: Theme.of(context).cardColor,

              /// Example: Getting border radius circular as const
              /// Nested Widgets do not need to be declared as const.
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: SwitchListTile(
                onChanged: (bool newValue) {
                  /// Example: Change theme with Riverpod
                  if (newValue) {
                    ref.watch(themeProvider).enableDarkMode();
                  } else {
                    ref.watch(themeProvider).enableLightMode();
                  }
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                value: Theme.of(context).brightness == Brightness.dark,
                title: Row(
                  children: <Widget>[
                    /// Examle: Ionicons
                    /// Available icons -> https://ionic.io/ionicons
                    Icon(Ionicons.moon_outline,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 16),
                    Text(
                      /// Example: Use the easy_translations package
                      tr('dark_mode_title'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(fontWeightDelta: 2),
                    ),
                  ],
                ),
              ),
            ),

            /// Example: Good way to add space between items without using Paddings
            const SizedBox(height: 8),
            Card(
              elevation: 2,

              /// Example: Many items have their own colors inside of the ThemData
              /// You can overwrite them in [config/theme.dart].
              color: Theme.of(context).cardColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: SwitchListTile(
                onChanged: (bool newValue) {
                  /// Example: Change locale
                  /// The initial locale is automatically determined by the library.
                  /// Changing the locale like this will persist the selected locale.
                  context.setLocale(
                      newValue ? const Locale('de') : const Locale('en'));
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                value: context.locale == const Locale('de'),
                title: Row(
                  children: <Widget>[
                    Icon(Ionicons.text_outline,
                        color: Theme.of(context).primaryColor),
                    const SizedBox(width: 16),
                    Text(
                      tr('language_switch_title'),
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .apply(fontWeightDelta: 2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 4 / 5.5,
              children: const <InfoCard>[
                /// Example: it is good practice to put widgets in separate files.
                /// This way the screen files won't become too large and
                /// the code becomes more clear.
                InfoCard(
                    title: 'localization_title',
                    content: 'localization_content',
                    icon: Ionicons.text_outline,
                    isPrimaryColor: true),
                InfoCard(
                    title: 'linting_title',
                    content: 'linting_content',
                    icon: Ionicons.code_slash_outline,
                    isPrimaryColor: false),
                InfoCard(
                    title: 'storage_title',
                    content: 'storage_content',
                    icon: Ionicons.folder_open_outline,
                    isPrimaryColor: false),
                InfoCard(
                    title: 'dark_mode_title',
                    content: 'dark_mode_content',
                    icon: Ionicons.moon_outline,
                    isPrimaryColor: true),
                InfoCard(
                    title: 'state_title',
                    content: 'state_content',
                    icon: Ionicons.water_outline,
                    isPrimaryColor: true),
                InfoCard(
                    title: 'display_title',
                    content: 'display_content',
                    icon: Ionicons.speedometer_outline,
                    isPrimaryColor: false),
              ],
            ),
            const SizedBox(height: 36),
          ]),
    );
  }
}
