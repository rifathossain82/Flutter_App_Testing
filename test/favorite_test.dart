import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_testing/models/favorites.dart';
import 'package:flutter_app_testing/screens/favorite_page.dart';

late Favorites favoritesList;

Widget createFavoritesScreen() => ChangeNotifierProvider(
      create: (context) {
        favoritesList = Favorites();
        return favoritesList;
      },
      child: const MaterialApp(
        home: FavoritesPage(),
      ),
    );

void addItems() {
  for (var i = 0; i < 10; i += 2) {
    favoritesList.add(i);
  }
}

void main() {
  group('Favorites Page Widget Tests', () {
    testWidgets('Test if ListView shows up', (widgetTester) async {
      await widgetTester.pumpWidget(createFavoritesScreen());
      addItems();
      await widgetTester.pumpAndSettle();
      var totalItems = widgetTester.widgetList(find.byIcon(Icons.close)).length;
      await widgetTester.tap(find.byIcon(Icons.close).first);
      await widgetTester.pumpAndSettle();
      expect(widgetTester.widgetList(find.byIcon(Icons.close)).length, lessThan(totalItems));
      expect(find.text('Removed from favorites.'), findsOneWidget);
    });
  });
}
