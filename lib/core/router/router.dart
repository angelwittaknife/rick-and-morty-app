
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/src/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/src/character/presentation/pages/character_full_page.dart';
import 'package:rick_and_morty/src/character/presentation/pages/characters_page.dart';
import 'package:rick_and_morty/src/character/presentation/widgets/my_scaffold.dart';

import '../../src/character/presentation/pages/favorite_page.dart';

GoRouter router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MyScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CharactersPage()),
              routes: [
                GoRoute(
                  path: 'character',
                  pageBuilder: (context, state) {
                    final character = state.extra as CharacterEntity;
                    return NoTransitionPage(
                      child: CharacterFullPage(character: character),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: FavoritePage()),
            ),
          ],
        ),
      ],
    ),
  ],
);
